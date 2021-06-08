

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:test_bed/views/bottom_nav_example_view.dart';
import 'package:test_bed/views/home_view.dart';
import 'package:test_bed/views/other_view.dart';
import 'package:test_bed/views/othernavigator_view.dart';
import 'package:test_bed/views/othernested_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: BottomNavExampleView),
    // CustomRoute(page: StreamCounterView),

    MaterialRoute(page: OtherNavigatorView, children: [
      MaterialRoute(page: OtherView, initial: true),
      MaterialRoute(page: OtherNestedView),
    ])
  ],
  dependencies: [
    LazySingleton(
        classType: NavigationService),
  ]
)

class App {

  /** This class has no puporse besides housing the annotation that
   * generates the required functionality **/
}

