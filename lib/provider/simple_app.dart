import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bed/provider/simple_page.dart';

class SimpleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<int>.value(
      value: 4,
      child: MaterialApp(
        home: SimplePage()
      )
    );
  }
}
