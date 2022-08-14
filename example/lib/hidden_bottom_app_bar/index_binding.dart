import 'package:camerawesome_example/hidden_bottom_app_bar/index_controller.dart';
import 'package:get/get.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
  }
}
