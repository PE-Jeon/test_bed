import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/views/othernavigator_viewmodel.dart';

class OtherNavigatorView extends StatelessWidget {
  const OtherNavigatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtherNavigatorViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            body: Center(
                child: Text('OtherNavigatorView View'),
            )
        ),
        viewModelBuilder: () => OtherNavigatorViewModel(),
    );
  }
}