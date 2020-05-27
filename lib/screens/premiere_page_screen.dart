/*
Application's first page 
*/
import 'package:flutter/material.dart';
import 'connexion_screen.dart';

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginPage = Material(
      elevation: 15.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return Login();
            }),
          );
        },
        child: Text("Connexion",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final inscriptionPage = Material(
      elevation: 15.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
        onPressed: () {},
        child: Text("Inscription",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('BIENVENUE'),
        centerTitle: true,
        backgroundColor: Color(0xff01A0C7),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(
                100.0), //Aim to manege spaces (left, right, ...) around widgets (column here)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  //Aim to create empty boxes to add spaces between widgets
                  height: 155.0,
                  child: Image.asset(
                    "assets/Logo_twinny.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 25.0),
                Text("Creer une communauté avec ceux qui vous ressemble !",
                    textAlign: TextAlign.center,
                    style: style.copyWith(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 60.0,
                ),
                loginPage,
                SizedBox(
                  height: 10.0,
                ),
                inscriptionPage,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
