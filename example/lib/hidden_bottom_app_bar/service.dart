import 'package:camerawesome_example/camera_progress_button.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: buildCaptureButton(),
      ),
    );
  }

  /// The shooting button.
  /// 拍照按钮
  Widget buildCaptureButton() {
    const Size outerSize = Size.square(115);
    const Size innerSize = Size.square(82);
    return Semantics(
      child: Listener(
        behavior: HitTestBehavior.opaque,
        child: GestureDetector(
          child: SizedBox.fromSize(
            size: outerSize,
            child: Stack(
              children: <Widget>[
                Center(
                  child: AnimatedContainer(
                    duration: kThemeChangeDuration,
                    width: outerSize.width,
                    height: outerSize.height,
                    padding: EdgeInsets.all(41),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      shape: BoxShape.circle,
                    ),
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                CameraProgressButton(
                  duration: Duration(seconds: 60),
                  outerRadius: outerSize.width,
                  ringsWidth: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
