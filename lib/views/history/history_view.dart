import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/app/app.locator.dart';
import 'package:test_bed/views/history/history_viewmodel.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      initialiseSpecialViewModelsOnce: true,
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
          body: Center(
              child: viewModel.isBusy
                  ? CircularProgressIndicator()
                  : Text(viewModel.data.toString()))),
      // viewModelBuilder: () => locator<HistoryViewModel>(),
      viewModelBuilder: () => HistoryViewModel(),
    );
  }
}
