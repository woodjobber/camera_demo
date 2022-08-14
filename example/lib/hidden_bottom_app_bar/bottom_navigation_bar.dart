import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hidden_widget_controller.dart';

class HiddenBottomNavigationBar extends StatelessWidget
    with PreferredSizeWidget {
  const HiddenBottomNavigationBar({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final HiddenWidgetController controller = Get.find();
    return Obx(
      () {
        return PreferredSize(
          preferredSize: Size.fromHeight(Get.bottomBarHeight),
          child: SizedBox(
            child: AnimatedContainer(
              child: child,
              height: controller.visible
                  ? kBottomNavigationBarHeight
                  : Get.mediaQuery.padding.bottom + kBottomNavigationBarHeight,
              duration: controller.duration,
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Get.bottomBarHeight);
}
