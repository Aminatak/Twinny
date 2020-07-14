import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projet_twinny/widgets/HeaderWidget.dart';


class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

//String get username => username;

class _CreateAccountPageState extends State<CreateAccountPage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;

  //Submit user and notification
  submitUsername() {
    final form = _formKey.currentState;

    if(form.validate()) {
      form.save();
      
      SnackBar snackBar = SnackBar(content: Text("Bienvenu " + username));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 4), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, strTitle: "Paramètres", disappearedBackButton: true),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 26.0),
                  child: Center(
                    child: Text("Créer un surnom", style: TextStyle(fontSize: 26.0),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidate: true,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        validator: (val){
                          if(val.trim().length<3 || val.isEmpty) {
                            return "surnom trop court";
                          }
                          else if(val.trim().length>15) {
                            return "surnom trop long";
                          }
                          else {
                            return null;
                          }
                        },
                        onSaved: (val) => username = val,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Surnom",
                          labelStyle: TextStyle(fontSize: 16.0),
                          hintText: "doit être au moins 3 lettres",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                //Valider button
                GestureDetector(
                  onTap: submitUsername,
                  child: Container(
                    height: 55.0,
                    width: 360.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        "Valider",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
