import 'package:get/get.dart';
import 'package:skyscape/pages/cities_list_page.dart';
import 'package:skyscape/pages/home.dart';
import 'package:skyscape/pages/map_page.dart';
import 'package:skyscape/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.citiesList, page: () => const CitiesListPage()),
    GetPage(name: AppRoutes.mapPage, page: () => const MapPage())
  ];
}
