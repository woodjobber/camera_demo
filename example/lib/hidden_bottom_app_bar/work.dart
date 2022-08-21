import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import 'bottom_navigation_bar.dart';
import 'hidden_widget_controller.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    HiddenWidgetController logic = Get.find();
    return Scaffold(
      bottomNavigationBar: HiddenBottomNavigationBar(
        child: Container(
          color: Colors.purple,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.green,
              child: ListView.separated(
                itemCount: 25,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Obx(
                      () => Offstage(
                        offstage: logic.visible,
                        child: Container(
                          child: Icon(Ionicons.ios_radio_button_off),
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    horizontalTitleGap: 5,
                    minLeadingWidth: 0,
                    title: Text('item $index'),
                  );
                },
              ),
            ),
            Align(
              child: IconButton(
                  onPressed: () {
                    logic.toggle();
                  },
                  icon: Icon(
                    FontAwesome.gavel,
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
