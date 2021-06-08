// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../views/bottom_nav_example_view.dart';
import '../views/home_view.dart';
import '../views/other_view.dart';
import '../views/othernavigator_view.dart';
import '../views/othernested_view.dart';

class Routes {
  static const String homeView = '/';
  static const String bottomNavExampleView = '/bottom-nav-example-view';
  static const String otherNavigatorView = '/other-navigator-view';
  static const all = <String>{
    homeView,
    bottomNavExampleView,
    otherNavigatorView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.bottomNavExampleView, page: BottomNavExampleView),
    RouteDef(
      Routes.otherNavigatorView,
      page: OtherNavigatorView,
      generator: OtherNavigatorViewRouter(),
    ),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    BottomNavExampleView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BottomNavExampleView(),
        settings: data,
      );
    },
    OtherNavigatorView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OtherNavigatorView(),
        settings: data,
      );
    },
  };
}

class OtherNavigatorViewRoutes {
  static const String otherView = '/';
  static const String otherNestedView = '/other-nested-view';
  static const all = <String>{
    otherView,
    otherNestedView,
  };
}

class OtherNavigatorViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(OtherNavigatorViewRoutes.otherView, page: OtherView),
    RouteDef(OtherNavigatorViewRoutes.otherNestedView, page: OtherNestedView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    OtherView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OtherView(),
        settings: data,
      );
    },
    OtherNestedView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OtherNestedView(),
        settings: data,
      );
    },
  };
}
