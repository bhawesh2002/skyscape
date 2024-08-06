import 'package:get/get.dart';
import 'package:skyscape/pages/cities_list_page.dart';
import 'package:skyscape/pages/home.dart';
import 'package:skyscape/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(
              lat: 56.0667,
              long: 37.05,
            )),
    GetPage(name: AppRoutes.citiesList, page: () => const CitiesListPage()),
  ];
}
