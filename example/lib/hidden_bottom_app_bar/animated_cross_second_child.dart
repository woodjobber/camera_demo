import 'package:flutter/material.dart';

class AnimatedCrossSecondChild extends StatefulWidget {
  const AnimatedCrossSecondChild({Key key}) : super(key: key);

  @override
  State<AnimatedCrossSecondChild> createState() =>
      _AnimatedCrossSecondChildState();
}

class _AnimatedCrossSecondChildState extends State<AnimatedCrossSecondChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
                child: Text(
              '第二个',
              style: TextStyle(fontSize: 60),
            )),
            Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text('data'))),
            Positioned(
              top: 200,
              child: TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('data'),
                      Icon(Icons.call),
                    ],
                  )),
            ),
            Positioned(
              top: 100,
              child: TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('data'),
                      Icon(Icons.call),
                    ],
                  )),
            ),
            Positioned(
              top: 50,
              child: TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.android),
                      Text('data'),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
