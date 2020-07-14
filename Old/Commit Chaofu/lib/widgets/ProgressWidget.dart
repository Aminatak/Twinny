import 'package:flutter/material.dart';

//chargement bar circular
circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.lightBlueAccent),),
  );
}

//chargement bar linear
linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.lightGreenAccent),),
  );
}
