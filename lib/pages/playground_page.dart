import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui' as ui;
import '../utilities/app_bar_wrapper.dart';
import 'package:coa_progress_tracking_app/utilities/reward_animator.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaygroundPage extends StatefulWidget {
  const PlaygroundPage({Key? key}) : super(key: key);

  @override
  State<PlaygroundPage> createState() => _PlaygroundPageState();
}

class _PlaygroundPageState extends State<PlaygroundPage> {
  final tileColor = Colors.red[700]!;
  final List playOptions =
  [
    "Confetti!",
    "Go Cougs!",
  ];
  final List<IconData> iconsForPlayOptions =
  [
    Icons.celebration,
    Icons.sports_football,
  ];
  //final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    //_rewardAnimator = RewardAnimator();
  }

  @override
  Widget build(BuildContext context) {
    final RewardAnimator _rewardAnimator = RewardAnimator();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// ***** App Bar ***** ///
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarWrapper(
          title: "Playground",
        ),
      ),
      body: Column(
        children: [
          _rewardAnimator,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () {
                    _rewardAnimator.doConfetti();
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
                            iconsForPlayOptions[0],
                            color: Colors.white,
                            size: size.width * 0.2,
                          ),
                          Text(
                            playOptions[0],
                            style: TextStyle(color: Colors.white, fontSize: 24),
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
                    final AudioPlayer player = AudioPlayer();
                    player.play(AssetSource("Go_Cougs.m4a"));
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
                            iconsForPlayOptions[1],
                            color: Colors.white,
                            size: size.width * 0.2,
                          ),
                          Text(
                            playOptions[1],
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      /*Stack(
        alignment: AlignmentDirectional.center,
        children: [
          _rewardAnimator,
          MaterialButton(
            onPressed: () {
              _rewardAnimator.doConfetti();
            },
            color: Colors.blue,
            child: const Text(
              "Confetti!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              final player=AudioPlayer();
              player.play(AssetSource("movie_1.mp3"));
            },
            color: Colors.blue,
            child: const Text(
              "Sound!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ), */
    );
  }

  /*Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future<ui.Image> loadImage(File file) async {
    final data = await file.readAsBytes();
    return await decodeImageFromList(data);
  }*/
}
