import 'package:flutter/material.dart';
import 'package:projet_twinny/pages/HomePage.dart';
import 'package:projet_twinny/widgets/HeaderWidget.dart';
import 'package:projet_twinny/widgets/PostWidget.dart';
import 'package:projet_twinny/widgets/ProgressWidget.dart';

class PostScreenPage extends StatelessWidget {

  final String postId;
  final String userId; //userId

  PostScreenPage({
    this.postId,
    this.userId
  });


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsReference.document(userId).collection("usersPosts").document(postId).get(),
      builder: (context, dataSnapshot) {
        if(!dataSnapshot.hasData) {
          return circularProgress();
        }

        Post post = Post.fromDocument(dataSnapshot.data);
        return Center(
          child: Scaffold(
            appBar: header(context, strTitle: post.description),
            body: ListView(
              children: <Widget>[
                Container(
                  child: post,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
