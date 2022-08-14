import 'package:camerawesome_example/hidden_bottom_app_bar/hidden_widget.dart';
import 'package:camerawesome_example/hidden_bottom_app_bar/hidden_widget_controller.dart';
import 'package:camerawesome_example/hidden_bottom_app_bar/index_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexWidget extends StatelessWidget {
  IndexWidget({Key key}) : super(key: key);
  final IndexController controller = Get.find();
  final HiddenWidgetController hiddenWidgetController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          hiddenWidgetController.toggle();
        },
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: buildPageView(),
    );
  }

  Widget buildPageView() {
    return PageView(
      children: controller.pages,
      controller: controller.pageController,
      onPageChanged: (index) => controller.onChangedPage(index),
    );
  }

  Widget buildBottomNavigationBar() {
    return Obx(() => HiddenWidget(
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(fontSize: 16),
              unselectedLabelStyle: TextStyle(fontSize: 16),
              showSelectedLabels: true,
              onTap: (index) {
                controller.onChangedTab(index);
              },
              selectedIconTheme: IconThemeData(color: Colors.amber),
              selectedItemColor: Colors.red,
              currentIndex: controller.currentPage,
              items: controller.bottomNavigationBarItems),
        ));
  }
}
