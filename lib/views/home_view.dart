import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/views/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Home View'),
        )
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
