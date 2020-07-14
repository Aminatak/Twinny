import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projet_twinny/models/user.dart';
import 'package:projet_twinny/pages/CreateAccountPage.dart';
import 'package:projet_twinny/pages/NotificationsPage.dart';
import 'package:projet_twinny/pages/ProfilePage.dart';
import 'package:projet_twinny/pages/SearchPage.dart';
import 'package:projet_twinny/pages/TimeLinePage.dart';
import 'package:projet_twinny/pages/UploadPage.dart';

import 'TwinnyPage.dart';
//import 'package:projet_twinny/pages/CreateAccountPage.dart';
//import 'CreateAccountPage.dart' as createAccount;

//connexion google account
final GoogleSignIn gSignIn = GoogleSignIn();
final usersReference = Firestore.instance.collection("utilisateurs");
final StorageReference storageReference = FirebaseStorage.instance.ref().child("Posts Pictures");
final postsReference = Firestore.instance.collection("posts"); //stock all users posts
final activityFeedReference = Firestore.instance.collection("feed"); //activity (likes, dislikes, etc...) feed
final commentsReference = Firestore.instance.collection("comments"); //feed comments
final followersReference = Firestore.instance.collection("followers");
final followingReference = Firestore.instance.collection("following");
final timeLineReference = Firestore.instance.collection("timeline"); //Timeline feed

final DateTime timestamp = DateTime.now();
User currentUser;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isSignedIn = false;
  PageController pageController;
  int getPageIndex = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  //Init connexion
  void initState() {
    super.initState();

    pageController = PageController();
    
    gSignIn.onCurrentUserChanged.listen((gSigninAccount) {
      controlSignIn(gSigninAccount);
    }, onError: (gError) {
      print("Error message: " + gError);
    });
    
    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount){
      controlSignIn(gSignInAccount);
    }).catchError((gError) {
      print("Error message: " + gError);
    });
  }

  //Control user sign and call data save
  controlSignIn(GoogleSignInAccount signInAccount) async {
    if(signInAccount != null) {
      await saveUserInfoToFireStore();
      setState(() {
        isSignedIn = true;
      });

      configureRealTimePushNotifications();
    }
    else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  configureRealTimePushNotifications() {
    final GoogleSignInAccount gUser = gSignIn.currentUser;

    if(Platform.isIOS) {
      getIOSPermissions();
    }

    _firebaseMessaging.getToken().then((token) {
      //usersReference.document((gUser.id).updateData({""}));
      usersReference.document(gUser.id).updateData({"androidNotificationToken" : token});
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> msg) async {
        final String recipientId = msg["data"]["recipient"];
        final String body = msg["notification"]["body"];

        if(recipientId == gUser.id) {
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.grey,
            content: Text(body, style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis,),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      },
    );
  }

  getIOSPermissions() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(alert: true, badge: true, sound: true));

    _firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      print("Autorisations requises : $settings");
    });
  }

  //Save data to FireStore
  saveUserInfoToFireStore() async {
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot = await usersReference.document(gCurrentUser.id).get();

    if(!documentSnapshot.exists) {
      final username = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CreateAccountPage()));

      //from user.dart
      usersReference.document(gCurrentUser.id).setData({
        "id": gCurrentUser.id,
        "profileName": gCurrentUser.displayName,
        "username": username,
        "url": gCurrentUser.photoUrl,
        "email": gCurrentUser.email,
        "bio": "",
        "timestamp": timestamp,
      });

      await followersReference.document(gCurrentUser.id).collection("userFollowers").document(gCurrentUser.id).setData({});

      documentSnapshot = await usersReference.document(gCurrentUser.id).get();
    }

    currentUser = User.fromDocument(documentSnapshot);
  }

  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //Login User
  loginUser() {
    gSignIn.signIn();
  }

  //Logout User
  logoutUser() {
    gSignIn.signOut();
  }

  //Get page index
  whenPageChanges(int pageIndex) {
    //this.getPageIndex = pageIndex;
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex) {
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 500), curve: Curves.bounceInOut,);
  }

  //Home screen body
  Scaffold buildHomeScreen() {
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          TimeLinePage(gCurrentUser: currentUser,),
          //RaisedButton.icon(onPressed: logoutUser, icon: Icon(Icons.close), label: Text("Déconnexion")),
          SearchPage(),
          TwinnyPage(),
          UploadPage(gCurrentUser: currentUser,),
          NotificationsPage(),
          ProfilePage(userProfileId: currentUser.id),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      //bottom navigation bar
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        onTap: onTapChangePage,
        backgroundColor: Theme.of(context).accentColor,
        activeColor: Colors.lightBlueAccent,
        inactiveColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.title)),
          BottomNavigationBarItem(icon: Icon(Icons.photo_camera,)),//size: 30.0,
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
    //return RaisedButton.icon(onPressed: logoutUser, icon: Icon(Icons.close), label: Text("Déconnexion"));
  }

  //connexion screen body
  Scaffold buildSignInScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor]
          ),
        ),
        alignment:  Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Connexion",
              style: TextStyle(fontSize: 80.0, color: Colors.white, fontFamily: "Signatra"),
            ),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                width: 270.0,
                height: 65.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/google_signin_button.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //build des screen body
  @override
  Widget build(BuildContext context) {
    if(isSignedIn) {
      return buildHomeScreen();
    }
    else {
      return buildSignInScreen();
    }
  }
}
