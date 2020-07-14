// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet_twinny/models/user.dart';
import 'package:projet_twinny/pages/HomePage.dart';
import 'package:projet_twinny/widgets/ProgressWidget.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPagesState createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPage> with AutomaticKeepAliveClientMixin<SearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  controlSearching(String str) {
    Future<QuerySnapshot> allUsers = usersReference.where("profileName", isGreaterThanOrEqualTo: str).getDocuments();
    setState(() {
      futureSearchResults = allUsers;
    });
  }

  AppBar searchPageHeader() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.lightBlue,
      title: TextFormField(
        style: TextStyle(fontSize: 18.0, color: Colors.white),
        controller: searchTextEditingController,
        decoration: InputDecoration(
          hintText: "Rechercher par ici ...",
          hintStyle : TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          prefixIcon: Icon(Icons.person_pin,color: Colors.white, size: 30.0,),
          suffixIcon: IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: emptyTheTextFormField,)
        ),
        onFieldSubmitted: controlSearching,
      ),
    );
  }

  Container displayNoSearchResultScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(Icons.group, color: Colors.blue, size: 200.0,),
            Text(
              "Rechercher Utilisateurs",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w400, fontSize: 40.0),
            ),
          ],
        ),
      ),
    );
  }

  displayUsersFoundScreen() {
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, dataSnapshot) {
        if(!dataSnapshot.hasData) {
          return circularProgress();
        }

        List<UserResult> searchUsersResult = [];
        dataSnapshot.data.documents.forEach((document) {
          User eachUser = User.fromDocument(document);
          UserResult userResult = UserResult(eachUser);
          searchUsersResult.add(userResult);
        });

        return ListView(children: searchUsersResult);
      },
    );
  }

  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: searchPageHeader(),
      body: futureSearchResults == null ? displayNoSearchResultScreen() : displayUsersFoundScreen(),
    );
  }
}

class UserResult extends StatelessWidget {

  final User eachUser;
  UserResult(this.eachUser);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white54,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap:() => print("tapped"),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Colors.lightGreenAccent, backgroundImage: CachedNetworkImageProvider(eachUser.url),),
                title: Text(eachUser.profileName, style: TextStyle(
                  color: Colors.black, fontSize:  16.0, fontWeight: FontWeight.bold,
                ),),
                subtitle: Text(eachUser.username, style: TextStyle(
                  color: Colors.grey, fontSize:  13.0,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
