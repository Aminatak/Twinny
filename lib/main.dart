 import 'package:flutter/material.dart';
 //import 'screens/premiere_page_screen.dart';
 import 'screens/page_info_groupe_sosie_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application twinny',
      //home: FirstPage()
      home: InfoGroupSosie()
    );
  }
}