
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Src/infrastructure/route/route-names.dart';
import 'Src/infrastructure/route/route-pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
    initialRoute: RouteNames.home,
    getPages: RoutePages.pages,
    debugShowCheckedModeBanner: false,
  );
}
