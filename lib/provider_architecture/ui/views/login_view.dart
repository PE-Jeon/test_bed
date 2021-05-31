import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bed/provider_architecture/core/viewmodels/login_model.dart';
import 'package:test_bed/provider_architecture/locator.dart';
import 'package:test_bed/provider_architecture/ui/shared/app_colors.dart';
import 'package:test_bed/provider_architecture/ui/widgets/login_header.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (context) => locator<LoginModel>(),
      child: Consumer<LoginModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginHeader(),
              FlatButton(
                  color: Colors.white,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {})
            ],
          ),
        ),
      ),
    );
  }
}
