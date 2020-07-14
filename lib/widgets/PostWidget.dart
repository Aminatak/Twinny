import 'dart:async';
//import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projet_twinny/models/user.dart';
import 'package:projet_twinny/pages/CommentsPage.dart';
import 'package:projet_twinny/pages/HomePage.dart';
import 'package:projet_twinny/pages/ProfilePage.dart';
import 'package:projet_twinny/widgets/CImageWidget.dart';
import 'package:projet_twinny/widgets/ProgressWidget.dart';

class Post extends StatefulWidget {

  final String postId;
  final String ownerId;
  final dynamic likes;
  final String username;
  final String description;
  final String location;
  final String url;

  Post({
    this.postId,
    this.ownerId,
    this.likes,
    this.username,
    this.description,
    this.location,
    this.url,
  });

  factory Post.fromDocument(DocumentSnapshot documentSnapshot) {
    return Post(
      postId: documentSnapshot["postId"],
      ownerId: documentSnapshot["ownerId"],
      likes: documentSnapshot["likes"],
      username: documentSnapshot["username"],
      description: documentSnapshot["description"],
      location: documentSnapshot["location"],
      url: documentSnapshot["url"],
    );
  }

  int getTotalNumberOfLikes(likes) {
    if(likes == null) {
      return 0;
    }

    int counter = 0;
    likes.values.forEach((eachValue) {
      if(eachValue == true) {
        counter = counter + 1;
      }
    });

    return counter;
  }
  @override
  _PostState createState() => _PostState(
    postId : this.postId,
    ownerId: this.ownerId,
    likes: this.likes,
    username: this.username,
    description: this.description,
    location: this.location,
    url: this.url,
    likeCount: getTotalNumberOfLikes(this.likes),
  );
}


class _PostState extends State<Post> {

  final String postId;
  final String ownerId;
  Map likes;
  final String username;
  final String description;
  final String location;
  final String url;
  int likeCount;
  bool isLiked;
  bool showHeart = false;
  final String currentOnLineUserId = currentUser?.id;

  _PostState({
    this.postId,
    this.ownerId,
    this.likes,
    this.username,
    this.description,
    this.location,
    this.url,
    this.likeCount,
  });

  @override
  Widget build(BuildContext context) {

    isLiked = (likes[currentOnLineUserId] == true);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          createPostHead(),
          createPostPicture(),
          createPostFooter(),
        ],
      ),
    );
  }

  createPostHead() {
    return FutureBuilder(
      future: usersReference.document(ownerId).get(),
      builder: (context, dataSnapshot) {
        if(!dataSnapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(dataSnapshot.data);
        bool isPostOwner = currentOnLineUserId == ownerId;
        return ListTile(
          leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(user.url), backgroundColor: Colors.grey,),
          title: GestureDetector(
            onTap: () => displayUserProfile(context, userProfileId: user.id),//print("montrer le profil"),
            child: Text(
              user.username,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text(location, style: TextStyle(color: Colors.blueGrey),),
          trailing: isPostOwner ? IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black,),
            onPressed: () => print("supprimé"),//controlPostDelete(context),//
          ) : Text(""),
        );
      },
    );
  }

  controlPostDelete(BuildContext mContext) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Que voulez vous faire ?", style:  TextStyle(color: Colors.blueAccent),),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Supprimer", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.pop(context);
                removeUserPost();
              },
            ),
            SimpleDialogOption(
              child: Text("Annuler", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      }
    );
  }

  removeUserPost() async {
    postsReference.document(ownerId)
        .collection("usersPosts")
        .document(postId)
        .get()
        .then((document) {
          if(document.exists) {
            document.reference.delete();
          }
        });

    storageReference.child("post_$postId.jpg").delete();

    QuerySnapshot querySnapshot = await activityFeedReference.document(ownerId)
        .collection("feedItems")
        .where("postId", isEqualTo: postId)
        .getDocuments();

    querySnapshot.documents.forEach((document) {
      if(document.exists) {
        document.reference.delete();
      }
    });

    QuerySnapshot commentsQuerySnapshot = await commentsReference.document(postId).collection("comments").getDocuments();

    commentsQuerySnapshot.documents.forEach((document) {
      if(document.exists) {
        document.reference.delete();
      }
    });

  }

  displayUserProfile(BuildContext context, {String userProfileId}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userProfileId: userProfileId,)));
  }

  removeLike() {
    bool isNotPostOwner = currentOnLineUserId != ownerId;

    if(isNotPostOwner) {
      activityFeedReference.document(ownerId).collection("feedItems").document(postId).get().then((document) {
        if(document.exists) {
          document.reference.delete();
        }
      });
    }
  }

  addLike() {
    bool isNotPostOwner = currentOnLineUserId != ownerId;

    if(isNotPostOwner) {
      activityFeedReference.document(ownerId).collection("feedItems").document(postId).setData({
        "type": "like",
        "username": currentUser.username,
        "ownerId": currentUser.id, //"userId"
        "timestamp": DateTime.now(),
        "url": url,
        "postId": postId,
        "userProfileImg": currentUser.url,
      });
    }
  }

  controlUserLikePost() {
    bool _liked = likes[currentOnLineUserId] == true;

    if(_liked) {
      postsReference.document(ownerId).collection("usersPosts").document(postId).updateData({"likes.$currentOnLineUserId": false});

      removeLike();

      setState(() {
        likeCount = likeCount - 1;
        isLiked = false;
        likes[currentOnLineUserId] = false;
      });
    }
    else if(!_liked) {
      postsReference.document(ownerId).collection("usersPosts").document(postId).updateData({"likes.$currentOnLineUserId": true});

      addLike();

      setState(() {
        likeCount = likeCount + 1;
        isLiked = true;
        likes[currentOnLineUserId] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 800), (){
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  createPostPicture() {
    return GestureDetector(
      onDoubleTap: () => controlUserLikePost,//print("post liké"),//
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //cachedNetworkImage(url),
          Image.network(url),
          showHeart ? Icon(Icons.favorite, size: 140.0, color: Colors.redAccent,) : Text(""),
        ],
      ),
    );
  }

  createPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
            GestureDetector(
              onTap: () => controlUserLikePost(),//print("post liké"),
              child: Icon(
                //Icons.favorite, color:  Colors.grey,
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 28.0,
                color: Colors.redAccent,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 20.0)),
            GestureDetector(
              onTap: () => displayComments(context, postId: postId, ownerId: ownerId, url: url),//print("commentaires"),
              child: Icon(Icons.chat_bubble_outline, size: 28.0,color: Colors.green,),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$likeCount likes",
                style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text("$username ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              ),
              Expanded(
                child: Text(description, style: TextStyle(color: Colors.white),),
              ),
            ],
        ),
      ],
    );
  }

  displayComments(BuildContext context, {String postId, String ownerId, String url}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CommentsPage(postId: postId, postOwnerId: ownerId, postImageUrl: url);
    }
    ));
  }
}
