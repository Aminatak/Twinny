/*
Application's first page 
*/
import 'package:flutter/material.dart';
import 'page_info_groupe_sosie_screen.dart'; 


class FirstPage extends StatelessWidget{
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  @override
  Widget build(BuildContext context){

    //TO DO
    Function goToInfoGoupeSosiePage(){

    }

    /*
    //Function to define action for the page's unique button
    final nextAction = FloatingActionButton(
        onPressed: goToInfoGoupeSosiePage,
        child: Icon(
          Icons.arrow_forward_ios
          ),
      );

    */

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
            padding: const EdgeInsets.all(100.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 250.0,
                  child: Image.asset(
                    "assets/Logo_twinny.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height:45.0),
                Text("Creer une communauté avec ceux qui vous ressemble !",
                textAlign: TextAlign.center,
                style: style.copyWith(
                  fontWeight: FontWeight.bold)),
              
              ],
            ),
          ),
        ),    
      ),

      //This part can be removed by the final function 'nextAction' just above
      floatingActionButton: FloatingActionButton(
        onPressed: goToInfoGoupeSosiePage,
        child: Icon(Icons.arrow_forward_ios),
      ),
    );

  }
}