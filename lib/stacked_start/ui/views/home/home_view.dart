import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/stacked_start/ui/views/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(model.title),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: model.updateCounter,
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}