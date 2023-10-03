import 'package:flutter/material.dart';
import 'package:coa_progress_tracking_app/pages/progress_info_page.dart';

class ProgressTile extends StatelessWidget {
  final String docId;
  final String dateString;
  final double distanceTraveled;
  final String userDoc;
  final String commentText;

  const ProgressTile({
    super.key,
    required this.docId,
    required this.dateString,
    required this.distanceTraveled,
    required this.userDoc,
    required this.commentText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ProgressInfoPage(
                  docId: docId,
                  dateString: dateString,
                  distanceTraveled: distanceTraveled,
                  userDoc: userDoc,
                  commentText: commentText,
                );
              }),
            );
          },
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(dateString,
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 15),
                  Text("$distanceTraveled m",
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 50,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                          child: Text(commentText),
                      )
                  ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
