import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coa_progress_tracking_app/utilities/get_first_name.dart';
import 'package:coa_progress_tracking_app/pages/games_page.dart';
import 'package:coa_progress_tracking_app/pages/location_tracking_page.dart';
import 'package:coa_progress_tracking_app/pages/milestone_page.dart';
import 'package:coa_progress_tracking_app/pages/profile_page.dart';
import 'package:coa_progress_tracking_app/pages/progress_calendar_page.dart';
import 'package:coa_progress_tracking_app/pages/settings_page.dart';
import 'package:coa_progress_tracking_app/pages/speech_page.dart';
import 'package:coa_progress_tracking_app/pages/playground_page.dart';
import 'package:coa_progress_tracking_app/utilities/emoticon_face.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coa_progress_tracking_app/utilities/home_tiles.dart';
import 'health_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final backgroundColor = Colors.grey[200];
  final tileColor = Colors.green[700]!;
  final tileTextColor = Colors.white;
  bool showWellBeing = true;

  Future<void> sendFeelings(int feelings) async {
    // Create new document
    // Send user id, date, feelings (1-4)
    DateTime now = DateTime.now();

    await FirebaseFirestore.instance.collection('health').add({
      'feeling': feelings,
      'user': global_current_user.uid,
      'date': "${now.month}/${now.day}/${now.year}",
      'DateTime': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Greetings Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Hello User
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(builder: (context, snapshot) {
                          return GetFirstName(documentId: user.uid);
                        }),
                        const SizedBox(height: 8),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          DateFormat.MMMMEEEEd().format(DateTime.now()),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Settings Button
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SettingsPage();
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: tileColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            /**/
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        // Logout Button
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: tileColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // How do you feel?
                Visibility(
                  visible: showWellBeing,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'How do you feel?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

                Visibility(
                    visible: showWellBeing, child: const SizedBox(height: 20)),

                // Emote Well-being
                Visibility(
                  visible: showWellBeing,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // bad
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showWellBeing = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content: Text('Bad Feeling Recorded!'),
                                      );
                                    });
                                sendFeelings(1);
                              },
                              child: const EmoticonFace(emoticonFace: '🤬')),
                          const SizedBox(height: 8),
                          const Text(
                            'Bad',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      // fine
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showWellBeing = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content: Text('Fine Feeling Recorded!'),
                                      );
                                    });
                                sendFeelings(2);
                              },
                              child: const EmoticonFace(emoticonFace: '🤨')),
                          const SizedBox(height: 8),
                          const Text(
                            'Fine',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      // good
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showWellBeing = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content: Text('Good Feeling Recorded!'),
                                      );
                                    });
                                sendFeelings(3);
                              },
                              child: const EmoticonFace(emoticonFace: '🤭')),
                          const SizedBox(height: 8),
                          const Text(
                            'Good',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),

                      // excellent
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showWellBeing = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content:
                                            Text('Excellent Feeling Recorded!'),
                                      );
                                    });
                                sendFeelings(4);
                              },
                              child: const EmoticonFace(emoticonFace: '🥰')),
                          const SizedBox(height: 8),
                          const Text(
                            'Excellent',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: size.width * 2.2,

                    /// set height: size.width 1.8 to revert to Pre-testing.
                    color: backgroundColor,
                    child: Column(
                      children: [
                        // ============ First Row ============
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HomeTile(
                              tileName: 'Speech',
                              tileIcon: Icons.record_voice_over,
                              tileRoute: SpeechPage(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                            HomeTile(
                              tileName: 'Playground',
                              tileIcon: Icons.attractions_outlined,
                              tileRoute: PlaygroundPage(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                          ],
                        ),

                        // ============ Second Row ============

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HomeTile(
                              tileName: 'Progress',
                              tileIcon: Icons.auto_graph,
                              tileRoute: ProgressCalendarPage(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                            HomeTile(
                              tileName: 'Milestones',
                              tileIcon: Icons.star,
                              tileRoute: MilestonePage(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                          ],
                        ),

                        // ============ Third Row ============

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HomeTile(
                              tileName: 'Profile',
                              tileIcon: Icons.person,
                              tileRoute: ProfilePage(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                            HomeTile(
                              tileName: 'Health',
                              tileIcon: Icons.medical_services,
                              tileRoute: HealthPage(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                          ],
                        ),

                        // ============ Fourth Row ============

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HomeTile(
                              tileName: 'Games',
                              tileIcon: Icons.videogame_asset,
                              tileRoute: GamePage(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                            HomeTile(
                              tileName: 'Location',
                              tileIcon: Icons.my_location,
                              tileRoute: LocationModule(),
                              tileColor: tileColor,
                              tileTextColor: tileTextColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
