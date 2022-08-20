import 'package:camerawesome_example/hidden_bottom_app_bar/hidden_widget_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  HiddenWidgetController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      child: ListView.separated(
        itemCount: 25,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Obx(
              () => Offstage(
                offstage: controller.visible,
                child: controller.visible
                    ? Icon(Ionicons.ios_radio_button_on)
                    : Icon(Ionicons.ios_radio_button_off),
              ),
            ),
            horizontalTitleGap: 5,
            minLeadingWidth: 0,
            title: Text('item $index'),
          );
        },
      ),
    );
  }
}
