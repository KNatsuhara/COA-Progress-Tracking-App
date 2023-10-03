import 'package:coa_progress_tracking_app/utilities/app_bar_wrapper.dart';
import 'package:coa_progress_tracking_app/utilities/progress_tile_2.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  final user = FirebaseAuth.instance.currentUser!;
  bool commentMode = false;
  int commentId = -1;

  void setCommentMode(int newCommentId) {
    if (commentId == newCommentId) {
      commentMode = false;
      commentId = -1;
    }
    else {
      commentMode = true;
      commentId = newCommentId;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final Stream<QuerySnapshot> distanceStream = FirebaseFirestore.instance.collection("distance").orderBy("DateTime", descending: true).snapshots();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      /// ***** App Bar ***** ///
      // appBar: const PreferredSize(
      //   preferredSize: Size.fromHeight(70),
      //   child: AppBarWrapper(
      //     title: "Progress",
      //   ),
      // ),
      body: Column(
        children: [
          /// ***** Comment input field ***** ///
          Visibility(
            visible: commentMode,
            child: Flexible(
              child: Container(
                padding: const EdgeInsets.all(25.0),
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.040, vertical: height * 0.005),
                child: TextField(
                  controller: TextEditingController(),
                  maxLines: 3,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    hintText: 'Enter a comment',
                    fillColor: Colors.grey[300],
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
          /// ***** Progress Tile View ***** ///
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: distanceStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError){

                }
                if (snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List distanceDocs = [];
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map a = document.data() as Map<String, dynamic>;
                  distanceDocs.add(a);
                  a['id'] = document.id;
                }).toList();

                return ListView.builder(
                  itemCount: distanceDocs.length,
                  itemBuilder: (context, index) {
                    if (distanceDocs[index]['user'] == user.uid)
                      {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              ProgressTile(
                                docId: distanceDocs[index]['id'],
                                dateString: distanceDocs[index]['date'],
                                distanceTraveled: distanceDocs[index]['distance'].roundToDouble(),
                                userDoc: distanceDocs[index]['user'],
                                commentText: () {
                                  if (distanceDocs[index]['comment'] == null) {
                                    return "";
                                  }
                                  return distanceDocs[index]['comment'];
                                }(),
                              ),
                            ],
                          ),
                        );
                      }
                    else
                      {
                        return const Card();
                      }
                  },
                );
              },
            ),
            /*child: ListView.builder(
              shrinkWrap: true,
              itemCount: days.length,
              itemBuilder: (context, index) {
                return ProgressTile(
                  dateString: days[index][0],
                  distanceTraveled: days[index][1],
                  commentText: days[index][2],
                  displayId: index,
                );
              },
            ),*/
          ),
        ],
      ),
    );
  }
}