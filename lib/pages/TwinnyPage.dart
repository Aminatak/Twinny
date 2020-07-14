import 'package:flutter/material.dart';
import 'package:projet_twinny/widgets/HeaderWidget.dart';

/*class TwinnyPage extends StatefulWidget {
  @override
  _TwinnyPageState createState() => _TwinnyPageState();
}

class _TwinnyPageState extends State<TwinnyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, strTitle: "Twinny"),
    );
  }
}*/

//MACHINE LEARNING HERE

import 'package:flutter/material.dart';
import 'dart:io';

class TwinnyPage extends StatefulWidget {
  @override
  _TwinnyPageState createState() => _TwinnyPageState();
}

class _TwinnyPageState extends State<TwinnyPage> {
  File
  _imageReturnedByIa; // Ce fichier recevra l'image du sosie renvoyée par l'IA

  @override
  Widget build(BuildContext context) {
    final twinsPhoto = ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        "https://image.flaticon.com/icons/svg/187/187150.svg",
        height: 150.0,
        width: 100.0,
        fit: BoxFit.fill,
      ),
    );

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Retrouve ton sosie'),
        centerTitle: true,
        /*backgroundColor: Color(0xff01A0C7),
        leading: BackButton(
          color: Colors.white,
        ),*/
      ),*/
      appBar: AppBar(
        title: Text('Retrouve ton sosie'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: (_imageReturnedByIa != null)
                  ? Text('Felicitations vous avez trouvé votre twins !')
                  : Text(
                'Uhm, on dirait que votre twins se cache bien. Ressayez plus tard.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Alegreya-Black.ttf',
                  //fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                  height: 1.0,
                ),
              ),
            ),
            twinsPhoto,
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Envoyez-lui un message !',
        child: Icon(Icons.message),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      */
    );
  }
}
