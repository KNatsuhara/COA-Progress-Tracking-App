import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFirstName extends StatelessWidget {
  final String documentId;
  const GetFirstName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    // get the collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print(data['firstName']);
            return IntrinsicWidth(
              child: Container(
                //width: width * 0.5,
                constraints: BoxConstraints(
                    minWidth: width * 0.1, maxWidth: width * 0.5),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    'Hi, ${data['firstName']}!',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
          return const Text('loading...');
        }));
  }
}
