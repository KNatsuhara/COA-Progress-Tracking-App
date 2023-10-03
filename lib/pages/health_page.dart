import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coa_progress_tracking_app/utilities/heat_map.dart';
import 'package:intl/intl.dart';
import '../utilities/app_bar_wrapper.dart';

class Feeling<int, DateTime> {
  final int feeling;
  final DateTime date;

  Feeling(this.feeling, this.date);
}

class HealthPage extends StatefulWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  var healthCollection = FirebaseFirestore.instance.collection("health");
  final user = FirebaseAuth.instance.currentUser!;
  List<Feeling> feelingList = [];
  Map<DateTime, int> feelingData = Map<DateTime, int>();
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    getHealthData();
  }

  Future<void> getHealthData() async {
    print("User in health:" + user.uid + user.email.toString());

    var querySnapshot =
        await healthCollection.where("user", isEqualTo: user.uid).get().then(
      (QuerySnapshot querySnapshot) async {
        if (querySnapshot.size > 0) {
          //add weekly progress
          // for each document record feeling and update calendar date
          for (var doc in querySnapshot.docs) {
            feelingList.add(Feeling(doc.get("feeling"), doc.get("date")));
          }

          for (Feeling feeling in feelingList) {
            DateTime dateTime = DateFormat('MM/dd/yyyy').parse(feeling.date);
            feelingData[dateTime] = feeling.feeling;
          }
        } else {
          //no milestones
          print('No feelings recorded for this user :(');
        }
      },
      onError: (e) => print("error $e")
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      /// ***** App Bar ***** ///
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarWrapper(
          title: "Health",
        ),
      ),
      body: Center(
          child: MyHeatMap(
              width: width, height: height, feelingData: feelingData)),
    );
  }
}
