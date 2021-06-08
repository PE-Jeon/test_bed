import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/views/bottom_nav_example_viewmodel.dart';

class BottomNavExampleView extends StatelessWidget {
  const BottomNavExampleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavExampleViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
          body: Center(
            child: Text('Bottom Nav Example View'),
          )
      ),
      viewModelBuilder: () => BottomNavExampleViewModel(),
    );
  }
}
