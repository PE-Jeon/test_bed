import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:test_bed/views/bottom_nav_example_viewmodel.dart';
import 'package:test_bed/views/favorites/favorites_view.dart';
import 'package:test_bed/views/history/history_view.dart';
import 'package:test_bed/views/profile/profile_view.dart';

class BottomNavExampleView extends StatefulWidget {
  const BottomNavExampleView({Key? key}) : super(key: key);

  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExampleView> {
  final Map<int, Widget> _viewCache = Map<int, Widget>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavExampleViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        body: getViewForIndex(viewModel.currentTabIndex),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 6,
          backgroundColor: Colors.white,
          currentIndex: viewModel.currentTabIndex,
          onTap: viewModel.setTabIndex,
          items: [
            BottomNavigationBarItem(
              title: SizedBox(),
              icon: Icon(Icons.ac_unit),
            ),
            BottomNavigationBarItem(
              title: SizedBox(),
              icon: Icon(Icons.access_alarm),
            ),
            BottomNavigationBarItem(
              title: SizedBox(),
              icon: Icon(Icons.access_alarms),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => BottomNavExampleViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = FavoritesView();
          break;
        case 1:
          _viewCache[index] = HistoryView();
          break;
        case 2:
          _viewCache[index] = ProfileView();
          break;
      }
    }

    return _viewCache[index]!;
  }
}
