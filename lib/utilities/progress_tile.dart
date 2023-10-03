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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
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
        child: Container(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.0040, vertical: 0),
          //constraints: BoxConstraints.tight(const Size(500, 75)),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Flexible(
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  text: "$dateString - ",
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    /*const WidgetSpan(
                        child: Icon(
                          Icons.directions_walk,
                        )
                    ),*/
                    TextSpan(
                      text: "$distanceTraveled m\n",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: commentText,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}