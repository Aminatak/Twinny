/*
 * Page de connexion de l'application
 */

import 'package:flutter/material.dart';

TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

class Inscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final pseudoField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Pseudo",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final anniversaireField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Date de naissance",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );


    final passwordField = TextField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 65.0,
                  child: Image.asset(
                    "assets/Logo_twinny.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 185.0
                  ),
                emailField,
                SizedBox(height: 15.0),
                pseudoField,
                SizedBox(height: 15.0),
                anniversaireField,
                SizedBox(height: 15.0),
                passwordField,
                SizedBox(
                  height: 50.0,
                ),
                loginButon,                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
