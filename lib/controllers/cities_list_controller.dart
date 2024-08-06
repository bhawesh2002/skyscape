import 'package:get/get.dart';
import 'package:skyscape/utils/models/owm_city.dart';
import 'package:skyscape/utils/repository/owm_cities_list_repo.dart';

class CitiesListController extends GetxController {
  late Rxn<List<OwmCity>> owmCitiesList = Rxn<List<OwmCity>>();

  @override
  void onInit() {
    super.onInit();
    getCitiesList();
  }

  Future<void> getCitiesList() async {
    owmCitiesList.value = await OwmCitiesListRepo().getOwmCitiesListData();
  }
}
