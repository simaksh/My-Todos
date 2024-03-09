
import 'package:get/get.dart';
import 'package:untitled116/Src/infrastructure/route/route-names.dart';

import '../../pages/add-todo/commons/add-binding.dart';
import '../../pages/add-todo/views/add-page.dart';
import '../../pages/home/commons/home-binding.dart';
import '../../pages/home/views/home-page.dart';

class RoutePages {
  static List<GetPage> pages = [
    GetPage(
      name: RouteNames.home,
      page: () => HomePage(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: RouteNames.addTodo,
          page: () => const AddPage(),
          binding: AddBinding(),
        ),
      ],
    ),
  ];
}
