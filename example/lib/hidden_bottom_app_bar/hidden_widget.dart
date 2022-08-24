import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hidden_widget_controller.dart';

class HiddenWidget extends StatefulWidget {
  const HiddenWidget({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  State<HiddenWidget> createState() => _HiddenWidgetState();
}

class _HiddenWidgetState extends State<HiddenWidget> {
  final HiddenWidgetController controller = Get.find();
  StreamSubscription subscription;
  @override
  void initState() {
    subscription = controller.stream.listen((event) {
      print(event.toString());
    });
    super.initState();
  }

  @override
  void dispose() {
    ChangeNotifier;
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AnimatedContainer(
          duration: controller.duration,
          height: controller.visible
              ? kBottomNavigationBarHeight +
                  MediaQuery.of(context).viewPadding.bottom
              : 0,
          child: controller.visible
              ? Wrap(
                  children: [widget.child],
                )
              : SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: widget.child,
                ),
        );
      },
    );
  }
}
