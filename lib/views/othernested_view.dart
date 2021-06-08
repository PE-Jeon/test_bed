import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/views/othernested_viewmodel.dart';

class OtherNestedView extends StatelessWidget {
  const OtherNestedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtherNestedViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            body: Center(
                child: Text('OtherNestedView View'),
            )
        ),
        viewModelBuilder: () => OtherNestedViewModel(),
    );
  }
}
