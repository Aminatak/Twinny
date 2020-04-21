/*
Première page de l'applcation 
*/
import 'package:flutter/material.dart';


class FirstPage extends StatelessWidget{
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('BIENVENUE',
        //textAlign: TextAlign.center,
        style: style.copyWith(fontWeight: FontWeight.bold)
        ),
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
                  height: 200.0,
                  child: Image.asset(
                    "assets/Logo_twinny.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Text("Creer une communauté avec ceux qui vous ressemble !",
                textAlign: TextAlign.center,
                style: style.copyWith(
                  fontWeight: FontWeight.bold)),
              
              ],
            ),
          ),
        ),    
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
      ),

    );

  }
}