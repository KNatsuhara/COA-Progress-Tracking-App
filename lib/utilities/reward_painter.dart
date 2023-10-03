import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:coa_progress_tracking_app/pages/progress_info_page.dart';
import 'package:coa_progress_tracking_app/utilities/reward_animator.dart';

class RewardPainter extends CustomPainter {
  ///final List<ImagePainter> balloonImages;
  final List<Particle> particles;
  double time = 0.0;

  RewardPainter({
    ///required this.balloonImages,
    required this.particles,
  });

  void updatePhysics(double step) {
    time += step;
  }

  @override
  void paint(ui.Canvas canvas, ui.Size size)
  {
     /*balloonImages.forEach((b) {
       paintImage(
        canvas: canvas,
        rect: Rect.fromLTWH(
            b.pos.dx, b.pos.dy,
            b.image!.width * 0.2,
            b.image!.height * 0.2),
        image: b.image!,
        filterQuality: FilterQuality.low,
       );
     });*/
    
    particles.forEach((p) {
      var _paint = Paint();
      _paint.style = PaintingStyle.fill;
      _paint.color = p.color;
      canvas.drawCircle(p.pos, p.radius, _paint);
    });
    //canvas.drawImage(balloonImages[0]!, Offset(0, height), Paint());
    //final c = ui.Offset(size.width / 2, size.height / 2);
    //canvas.drawCircle(c, 100.0, Paint());
  }

  @override
  bool shouldRepaint(RewardPainter oldDelegate) =>
    time != oldDelegate.time;
}