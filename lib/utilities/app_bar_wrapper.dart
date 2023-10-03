import 'package:flutter/material.dart';

class AppBarWrapper extends StatelessWidget {
  final String title;
  final double fontSize;

  const AppBarWrapper({
    super.key,
    required this.title,
    this.fontSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[600],
          title: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              shadows: const <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 10.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}