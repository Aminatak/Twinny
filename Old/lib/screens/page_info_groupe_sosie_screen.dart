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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Félicitations !\nVous appartenez au groupe de sosi celèbre de Cristiano Ronaldo ! \nVous pouvez a tout moment quitter le groupe dans les reglages",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Alegreya-Black.ttf',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 25.0,
                  height: 1.5,
                  color: Colors.white,
                ),
              ),
            ),
            //SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                "CEUX QUI SE RESSEMBLENT \n S'ASSEMBLENT !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Alegreya-BlackItalic.ttf',
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.white,
        onPressed: () {},
        tooltip: 'Suivant',
        child: const Icon(Icons.arrow_forward, color: Color(0xff01A0C7)),
      ),
      
    );
  }
}
