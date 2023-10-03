import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui' as ui;
import '../utilities/app_bar_wrapper.dart';
import 'package:coa_progress_tracking_app/utilities/reward_painter.dart';

class RewardAnimator extends StatefulWidget {
  RewardAnimator({Key? key}) : super(key: key);

  late _RewardAnimatorState state;

  void doConfetti() {
    state.addParticles(100);
  }

  void doGoCougs() {
    state.showGoCougs();
  }

  @override
  State<RewardAnimator> createState() {
    state = _RewardAnimatorState();
    return state;
  }
}

class _RewardAnimatorState extends State<RewardAnimator> {
  var particles = List<Particle>.from([]);
  RewardPainter rewardPainter = RewardPainter(/*balloonImages: [], */particles: []);
  var imagePainters = List<ImagePainter>.from([]);
  Size size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;

  late Timer myTimer;

  //ui.Image? balloon;

  @override
  void initState() {
    super.initState();

    ///loadImage("assets/balloon_red.png").then((value) => balloon = value);

    myTimer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (Timer timer) {
      setState(() {

        /// Update the physics.
        rewardPainter.updatePhysics(1 / 60.0);
        particles.forEach((p) {


          p.dx = moveTowards(p.dx, 0, p.dragx);
          p.dy += p.ddy;
          p.dy = moveTowards(p.dy, 0, p.dragy);
          p.pos += Offset(p.dx, p.dy);
          //p.color = confettiColors[index % 7];
        });
        /// Destroy the particles.
        for (int i = 0; i < particles.length; i++) {
          if (particles[i].lifetime > 0) {
            particles[i].lifetime -= 1 / 60.0;
          }
          else {
            particles.removeAt(i);
            i--;
          }
        }

        imagePainters.forEach((i) {
          i.pos += Offset(0, 1);
        });
      });
    });
  }

  double moveTowards(double value, double target, double delta) {
    if (value > target){
      value -= delta;
      if (value < target) {
        value = target;
      }
    }
    else if (value < target){
      value += delta;
      if (value > target) {
        value = target;
      }
    }

    return value;
  }

  void addParticles(int amount) {
    for (int i = 0; i < amount; i++) {
      particles.add(Particle(Utils.Range(50, size.width - 50), size.height, Utils.Range(-2, 2), Utils.Range(-sqrt(size.height * 2 * 0.9) / 2, -sqrt(size.height * 2 * 0.9))));
    }
  }

  void showGoCougs() {

    //imagePainters.add(ImagePainter(balloon!));
  }

  @override
  void dispose() {
    myTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return IgnorePointer(
      ignoring: true,
      /// The Container is where the images are painted.
      child: Container(
        child: CustomPaint(
          painter: () {
            rewardPainter = RewardPainter(
              //balloonImages: imagePainters,
              particles: particles,
            );
            return rewardPainter;
          }(),
          child: Container(),
        ),
      ),
    );
  }

  Future<ui.Image> loadImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}

class Particle {
  Particle(double x, double y, double dx, double dy) {
    radius = Utils.Range(4, 10);
    color = confettiColors[Utils.RangeInteger(0, 6)];
    this.x = x;
    this.y = y;
    pos = Offset(x, y);
    this.dx = dx;
    this.dy = dy;
    ///this.dy = Utils.Range(-20, -40);
    ddy = 0.5;
    dragx = 0.0;
    dragy = 0.4;
    lifetime = 3.0;
  }

  var confettiColors = [Colors.lightBlueAccent, Colors.deepPurpleAccent, Colors.deepOrangeAccent, Colors.yellowAccent,
    Colors.lightGreenAccent, Colors.pinkAccent, Colors.redAccent];
  late double lifetime;
  late double radius;
  late Color color;
  late double x;
  late double y;
  late Offset pos;
  late double dx;
  late double dy;
  late double ddy;
  late double dragx;
  late double dragy;
}

class ImagePainter {
  ImagePainter(ui.Image _image) {
    image = _image;
    double x = 0;
    double y = 40;
    pos = Offset(x, y);
  }

  late ui.Image image;
  late Offset pos;
}

final rng = Random();
class Utils {
  static double Range(double min, double max) =>
      rng.nextDouble() * (max - min) + min;
  static int RangeInteger(int min, int max) =>
      rng.nextInt(max) + min;
}
