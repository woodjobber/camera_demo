import 'package:camerawesome_example/hidden_bottom_app_bar/app_binding.dart';
import 'package:camerawesome_example/hidden_bottom_app_bar/index_binding.dart';
import 'package:camerawesome_example/hidden_bottom_app_bar/index_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      routingCallback: (routing) {
        print(routing.current);
      },
      getPages: [
        GetPage(name: '/', page: () => IndexWidget(), binding: IndexBinding()),
      ],
    );
  }
}
