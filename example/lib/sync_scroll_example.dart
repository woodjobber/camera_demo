import 'package:camerawesome_example/share_model.dart';
import 'package:camerawesome_example/sync_scroll_controller.dart';
import 'package:camerawesome_example/sync_scroll_second_page.dart';
import 'package:flutter/material.dart';

Future<void> flutterExampleMain() async {
  runApp(MaterialApp(home: MyCompassApp()));
}

class MyCompassApp extends StatefulWidget {
  const MyCompassApp({
    Key key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

List<ShareModel> models = data();

class _MyAppState extends State<MyCompassApp> {
  SyncScrollControllerGroup horizontalControllers;
  @override
  void initState() {
    horizontalControllers = SyncScrollControllerGroup(
      initialScrollOffset: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.abc),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              return SecondExample(
                onRefresh: () {
                  models = models.length == 100 ? data2() : data();
                  setState(() {});
                },
                horizontalControllers: horizontalControllers,
              );
            }));
          },
        ),
        appBar: AppBar(
          title: const Text('Flutter Compass'),
        ),
        body: Example(
          horizontalControllers: horizontalControllers,
        ),
      );
    });
  }
}

class Example extends StatefulWidget {
  const Example({Key key, this.horizontalControllers}) : super(key: key);
  final SyncScrollControllerGroup horizontalControllers;
  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  ScrollController rowsControllerHeader;
  ScrollController rowsControllerBody;
  SyncScrollControllerGroup get horizontalControllers =>
      widget.horizontalControllers;

  @override
  void initState() {
    super.initState();

    rowsControllerHeader = horizontalControllers.obs();
    rowsControllerBody = horizontalControllers.obs();
  }

  @override
  void deactivate() {
    horizontalControllers.destroy();
    super.deactivate();
  }

  @override
  void dispose() {
    horizontalControllers.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                controller: rowsControllerHeader,
                itemCount: models.length,
                itemBuilder: (BuildContext context, int index) {
                  return Flexible(
                    child: Container(
                        color: Colors.red,
                        child: Text('$index', style: TextStyle(fontSize: 20))),
                    fit: FlexFit.tight,
                  );
                },
              ),
            ),
          ]),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: rowsControllerBody,
                  itemCount: models.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('$index'),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
