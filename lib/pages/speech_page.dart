import 'package:flutter/material.dart';
import '../utilities/app_bar_wrapper.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechPage extends StatefulWidget {
  const SpeechPage({Key? key}) : super(key: key);

  @override
  State<SpeechPage> createState() => _SpeechPageState();
}

class _SpeechPageState extends State<SpeechPage> {
  final tileColor = Colors.blue[700]!;
  final FlutterTts tts = FlutterTts();
  final List textOptions =
  ["Yes",
    "No",
    "Juice",
    "Snack",
    "Please",
    "Thank you",
    "Help",
    "Potty",
  ];
  final List<IconData> iconsForTextOptions =
  [Icons.check,
    Icons.cancel,
    Icons.water_drop_outlined,
    Icons.local_pizza,
    Icons.emoji_emotions,
    Icons.handshake,
    Icons.waving_hand,
    Icons.bathroom,
  ];

  void textToSpeech(String text) async {
    await tts.setLanguage("en-US");
    await tts.setVolume(1);
    await tts.setSpeechRate(0.4);
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// ***** App Bar ***** ///
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarWrapper(
          title: "Speech",
        ),
      ),
      body: ListView.builder(
        itemCount: (textOptions.length / 2).ceil(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    textToSpeech(textOptions[index * 2]);
                  },
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: size.width * 0.35,
                    width: size.width * 0.35,
                    color: tileColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            iconsForTextOptions[index * 2],
                            color: Colors.white,
                            size: size.width * 0.2,
                          ),
                          Text(
                            textOptions[index * 2],
                            style: TextStyle(
                            color: Colors.white,
                            fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    textToSpeech(textOptions[index * 2 + 1]);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: size.width * 0.35,
                      width: size.width * 0.35,
                      color: tileColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            iconsForTextOptions[index * 2 + 1],
                            color: Colors.white,
                            size: size.width * 0.2,
                          ),
                          Text(
                            textOptions[index * 2 + 1],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
