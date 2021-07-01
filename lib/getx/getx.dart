import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

class GetXMain extends StatelessWidget {
  const GetXMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        body: Center(child: ElevatedButton(
            child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
  }
}

class Other extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("${c.count}")));
  }
}
