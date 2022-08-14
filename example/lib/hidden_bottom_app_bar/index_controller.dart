import 'package:camerawesome_example/hidden_bottom_app_bar/home.dart';
import 'package:camerawesome_example/hidden_bottom_app_bar/mine.dart';
import 'package:camerawesome_example/hidden_bottom_app_bar/service.dart';
import 'package:camerawesome_example/hidden_bottom_app_bar/work.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexController extends GetxController {
  final _currentPage = 0.obs;
  int get currentPage => _currentPage.value;
  set currentPage(int index) => _currentPage.value = index;
  PageController pageController;
  List<Widget> pages;
  List<BottomNavigationBarItem> bottomNavigationBarItems;

  void onChangedPage(int index) {
    currentPage = index;
  }

  void onChangedTab(int index) {
    pageController.jumpToPage(index);
  }

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage);
    bottomNavigationBarItems = [
      BottomNavigationBarItem(
          label: '首页',
          icon: Icon(
            Icons.home_outlined,
            size: 20,
          ),
          activeIcon: Icon(
            Icons.home,
            size: 24,
          )),
      BottomNavigationBarItem(
          label: '工作台',
          icon: Icon(
            Icons.accessibility_new_outlined,
            size: 20,
          ),
          activeIcon: Icon(
            Icons.accessibility_new,
            size: 24,
          )),
      BottomNavigationBarItem(
          label: '服务',
          icon: Icon(
            Icons.access_alarm_outlined,
            size: 20,
          ),
          activeIcon: Icon(
            Icons.access_alarm,
            size: 24,
          )),
      BottomNavigationBarItem(
          label: '我的',
          icon: Icon(
            Icons.person_outlined,
            size: 20,
          ),
          activeIcon: Icon(
            Icons.person,
            size: 24,
          )),
    ];
    pages = [
      HomePage(),
      WorkPage(),
      ServicePage(),
      MinePage(),
    ];
  }
}
