/*
Information page to indicate to user, his celebrity's group
*/

import 'package:flutter/material.dart';

class InfoGroupSosie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff01A0C7),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 45.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                  child: Text("Félicitations !\nVous appartenez au groupe de sosi celèbre de Cristiano Ronaldo \nVous pouvez a tout moment quitter le groupe dans les reglages",
                  style: TextStyle(fontFamily: 'Alegreya'),
                  )
                  ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                  child: Text(
                "Ceux qui se ressemble s'assemblent",
                style: TextStyle(fontFamily: 'Alegreya'),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
