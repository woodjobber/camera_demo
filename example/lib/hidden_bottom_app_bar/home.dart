import 'package:camerawesome_example/hidden_bottom_app_bar/animated_cross_second_child.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showFirst = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            showFirst = !showFirst;
          });
        },
        child: Container(
          color: Colors.white,
          child: AnimatedCrossFade(
              firstCurve: Curves.easeOut,
              secondCurve: Curves.easeIn,
              sizeCurve: Curves.bounceOut,
              layoutBuilder: (Widget topChild, Key topKey, Widget bottomChild,
                  Key bottomKey) {
                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      key: bottomKey,
                      child: bottomChild,
                    ),
                    Positioned(
                      key: topKey,
                      child: topChild,
                    ),
                  ],
                );
              },
              firstChild: Container(
                width: Get.width,
                height: Get.height,
                key: ValueKey(1),
                child: Stack(
                  children: [
                    Align(
                        child: Text(
                      '第一个',
                      style: TextStyle(fontSize: 60),
                    ))
                  ],
                ),
                color: Colors.white,
              ),
              secondChild: SizedBox(
                width: Get.width,
                height: Get.height,
                child: AnimatedCrossSecondChild(
                  key: ValueKey(2),
                ),
              ),
              crossFadeState: showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              reverseDuration: Duration(milliseconds: 10),
              duration: Duration(milliseconds: 10)),
        ),
      ),
    );
  }
}
