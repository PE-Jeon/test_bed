import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/app/app.locator.dart';
import 'package:test_bed/views/favorites/favorites_viewmodel.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => viewModel.incrementCounter(),
          ),
          body: Center(
              child: Text(
                viewModel.counter.toString(),
                style: TextStyle(fontSize: 30),
              ))),
      // viewModelBuilder: () => locator<FavoritesViewModel>(),
      viewModelBuilder: () => FavoritesViewModel(),
      onModelReady: (viewModel) => viewModel.setCounterTo999(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
    );
  }
}
