/*
Information page to indicate to user, his celebrity's group
*/

import 'package:flutter/material.dart';

class InfoGroupSosie extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);
  
  @override
  Widget build(BuildContext context) {

    //TO DO
    Function goToAccueil(){

    }

    final nextActionToDo = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: goToAccueil,
        child: Text("C'est partit !",
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );

    return Scaffold(
      backgroundColor: Color(0xff01A0C7),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Félicitations !"
            "\n Vous appartenez au groupe de sosi celèbre de Cristiano Ronaldo"
            "\n Vous pouvez a tout moment quitter le groupe dans les reglages",
                textAlign: TextAlign.center,
                style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            Text("Ceux qui se ressemble s'assemblent",
            textAlign: TextAlign.center),
          ],
        ),
      ),


      //nextActionToDo,    



    );
  }
}
