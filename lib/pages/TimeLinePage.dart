
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet_twinny/models/user.dart';
import 'package:projet_twinny/pages/HomePage.dart';
import 'package:projet_twinny/widgets/HeaderWidget.dart';
import 'package:projet_twinny/widgets/PostWidget.dart';
import 'package:projet_twinny/widgets/ProgressWidget.dart';

class TimeLinePage extends StatefulWidget {

  final User gCurrentUser;

  TimeLinePage({this.gCurrentUser});

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}



class _TimeLinePageState extends State<TimeLinePage> {

  List<Post> posts;
  List<String> followingsList = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  retrieveTimeLine() async {
    QuerySnapshot querySnapshot = await timeLineReference.document(widget.gCurrentUser.id)
        .collection("timelinePosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();

    List<Post> allPosts = querySnapshot.documents.map((document) => Post.fromDocument(document)).toList();

    setState(() {
      this.posts = allPosts;
    });
  }

  retrieveFollowings() async {
    QuerySnapshot querySnapshot = await followingReference.document(currentUser.id)
        .collection("userFollowing")
        .getDocuments();

    setState(() {
      followingsList = querySnapshot.documents.map((document) => document.documentID).toList();
    });
  }


  @override
  void initState() {
    super.initState();

    retrieveTimeLine();
    retrieveFollowings();
  }

  createUserTimeLine() {
    if(posts == null) {
      return circularProgress();
    }
    else {
      return ListView(children: posts,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //appBar: header(context, isAppTitle: true,),
      appBar: AppBar(
        title: Text("Twinny",
          style: TextStyle(
          color: Colors.blue,
          fontFamily: "Signatra",
          fontSize: 45.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).accentColor,
      ),

      body: RefreshIndicator(child: createUserTimeLine(), onRefresh: () => retrieveTimeLine(),)//circularProgress(),
    );
  }
}
