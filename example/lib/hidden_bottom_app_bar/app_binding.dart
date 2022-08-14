import 'package:camerawesome_example/hidden_bottom_app_bar/hidden_widget_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HiddenWidgetController());
  }
}
