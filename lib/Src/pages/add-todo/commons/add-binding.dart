
import 'package:get/get.dart';

import '../controllers/add-controller.dart';

class AddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddController());
  }
}
