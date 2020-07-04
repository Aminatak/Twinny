import 'package:flutter/material.dart';
import 'package:projet_twinny/widgets/HeaderWidget.dart';

class TwinnyPage extends StatefulWidget {
  @override
  _TwinnyPageState createState() => _TwinnyPageState();
}

class _TwinnyPageState extends State<TwinnyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, strTitle: "Twinny"),
    );
  }
}