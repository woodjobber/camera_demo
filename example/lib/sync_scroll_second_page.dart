import 'package:camerawesome_example/share_model.dart';
import 'package:camerawesome_example/sync_scroll_controller.dart';
import 'package:flutter/material.dart';

class SecondExample extends StatefulWidget {
  const SecondExample({Key key, this.horizontalControllers, this.onRefresh})
      : super(key: key);
  final SyncScrollControllerGroup horizontalControllers;
  final VoidCallback onRefresh;
  @override
  State<SecondExample> createState() => _SecondExampleState();
}

class _SecondExampleState extends State<SecondExample> {
  SyncScrollControllerGroup get horizontalControllers =>
      widget.horizontalControllers;
  ScrollController rowsControllerHeader;
  ScrollController rowsControllerBody;
  List<ShareModel> models = data();
  @override
  void initState() {
    super.initState();
    rowsControllerHeader = horizontalControllers.obs();
    rowsControllerBody = horizontalControllers.obs();
  }

  @override
  void deactivate() {
    horizontalControllers.remove(rowsControllerBody);
    horizontalControllers.remove(rowsControllerHeader);
    super.deactivate();
  }

  @override
  void dispose() {
    horizontalControllers.remove(rowsControllerBody);
    horizontalControllers.remove(rowsControllerHeader);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('同步2'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.abc),
        onPressed: () {
          models = models.length == 100 ? data2() : data();
          setState(() {});
          widget.onRefresh();
        },
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  controller: rowsControllerHeader,
                  itemCount: models.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('$index'),
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
      ),
    );
  }
}
