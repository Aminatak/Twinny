import 'package:flutter/material.dart';
import 'package:projet_twinny/pages/FirstPage.dart';
import 'package:projet_twinny/pages/HomePage.dart';

void main()
{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twinny',
      debugShowCheckedModeBanner: false,
      theme: ThemeData
      (
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.black,
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.white70,
        cardColor: Colors.white70,
      ),
      home: FirstPage(),
      /*Scaffold(
        appBar: AppBar(
          title: Text('Twinny', style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
        ),
        body: Center(
          child: Text('Welcome to Twinny', style: TextStyle(color: Colors.white, fontSize: 40.0,),),
        ),
      ),*/
    );
  }
}
