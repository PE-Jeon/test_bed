
import 'package:auto_route/auto_route_annotations.dart';
import 'package:test_bed/stacked_start/ui/views/home/home_view.dart';
import 'package:test_bed/stacked_start/ui/views/home/startup_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
  ]
)


class $Router {

}