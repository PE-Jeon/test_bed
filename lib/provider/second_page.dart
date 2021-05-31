import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bed/provider/couter.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
      ),
      body: Center(
        child: Container(
          child: Text('second page counter ${counter.getCounter()}'),
        ),
      ),
    );
  }
}
