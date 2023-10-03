import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coa_progress_tracking_app/utilities/app_bar_wrapper.dart';

class ProgressInfoPage extends StatefulWidget {
  final String docId;
  final String dateString;
  final double distanceTraveled;
  final String userDoc;
  final String commentText;

  const ProgressInfoPage({
    super.key,
    required this.docId,
    required this.dateString,
    required this.distanceTraveled,
    required this.userDoc,
    required this.commentText,
  });

  @override
  State<ProgressInfoPage> createState() => _ProgressInfoPageState();
}

class _ProgressInfoPageState extends State<ProgressInfoPage> {

  final TextEditingController commentController = TextEditingController();

  bool editingComment = false;
  String currentCommentText = "";
  String modifiedCommentText = "";

  get docId => widget.docId;
  get distanceTraveled => widget.distanceTraveled;
  get dateString => widget.dateString;
  get userDoc => widget.userDoc;

  @override
  void initState(){
    super.initState();
    currentCommentText = widget.commentText;
    modifiedCommentText = currentCommentText;
  }

  Future updateComment() async {
    if (modifiedCommentText != currentCommentText) {
      final CollectionReference distanceCollection = FirebaseFirestore.instance.collection('distance');
      distanceCollection.doc(docId).update({
        'comment': modifiedCommentText,
        'date': dateString,
        'distance': distanceTraveled,
        'user': userDoc
      });
      currentCommentText = modifiedCommentText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// ***** App Bar ***** ///
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarWrapper(
          title: "Progress Info",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                text: "$dateString\n\n",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                children: [
                  TextSpan(
                    text: "$distanceTraveled meters\n\n",
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const TextSpan(
                    text: "Comment\t\t",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  /// Edit comment button
                  WidgetSpan(
                    child: Visibility(
                      visible: editingComment == false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            editingComment = true;
                            commentController.text = currentCommentText;
                          });
                        },
                        child: const Icon(
                          Icons.edit,
                        ),
                      ),
                    ),
                  ),
                  /// Save comment button
                  WidgetSpan(
                    child: Visibility(
                      visible: editingComment == true,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            editingComment = false;
                            modifiedCommentText = commentController.text;
                          });
                          updateComment();
                        },
                        child: const Icon(
                          Icons.save_as,
                        ),
                      ),
                    ),
                  ),

                  /// New lines
                  const TextSpan(
                    text: "\n\n",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  /// Comment text
                  WidgetSpan(
                    child: Visibility(
                      visible: editingComment == false,
                      child: Text(
                        currentCommentText,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  /// Comment text field
                  WidgetSpan(
                    child: Visibility(
                      visible: editingComment == true,
                      child: TextField(
                        controller: commentController,
                        maxLines: 25,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
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
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}