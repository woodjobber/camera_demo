import 'package:get/get.dart';

class HiddenWidgetController extends GetxController {
  final _visible = true.obs;

  /// 动画时长
  Duration duration = 200.milliseconds;

  /// 设置显示底部导航栏
  set visible(bool enable) => _visible(enable);
  bool get visible => _visible.value;

  /// switches the value between true/false
  void toggle() => _visible.toggle();

  /// 底部导航栏显示状态数据流
  Stream<bool> get stream => _visible.stream.asBroadcastStream();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
