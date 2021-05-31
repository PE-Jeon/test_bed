


import 'package:auto_route/auto_route_annotations.dart';
import 'package:test_bed/stacked_start/ui/views/home/home_view.dart';
import 'package:test_bed/stacked_start/ui/views/home/startup_view.dart';

@MaterialAutoRouter()
class $Router {

  @initial
  StartupView startupViewRoute;

  HomeView homeViewRoute;
}
