import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/views/other_viewmodel.dart';

class OtherView extends StatelessWidget {
  const OtherView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtherViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            body: Center(
                child: Text('OtherView View'),
            )
        ),
        viewModelBuilder: () => OtherViewModel(),
    );
  }
}