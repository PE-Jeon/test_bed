/*

Provider Architecture Guide in Fluter

Reference
https://medium.com/flutter-community/flutter-architecture-provider-implementation-guide-d33133a9a4e8

 */



import 'package:flutter/material.dart';
import 'package:test_bed/provider_architecture/ui/views/login_view.dart';

class ProviderMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LoginView(),
    );
  }
}