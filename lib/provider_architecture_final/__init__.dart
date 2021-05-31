

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bed/provider_architecture_final/core/models/user.dart';
import 'package:test_bed/provider_architecture_final/core/services/authentication_service.dart';
import 'package:test_bed/provider_architecture_final/locator.dart';
import 'package:test_bed/provider_architecture_final/ui/router.dart' as R;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (BuildContext context) =>
          locator<AuthenticationService>().userController.stream,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: 'login',
        onGenerateRoute: R.Router.generateRoute,
      ),
    );
  }
}
