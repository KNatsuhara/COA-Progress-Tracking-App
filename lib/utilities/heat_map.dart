import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final double width;
  final double height;
  final Map<DateTime, int> feelingData;

  const MyHeatMap({
    Key ? key,
    required this.width,
    required this.height,
    required this.feelingData,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      datasets: feelingData,
      size: width/8,
      fontSize: width/36,
      monthFontSize: width/22,
      weekFontSize: width/36,
      textColor: Colors.black,
      colorMode: ColorMode.opacity,
      colorsets: {
        1: Color.fromARGB(10, 11, 194, 14),
        2: Color.fromARGB(80, 11, 194, 18),
        3: Color.fromARGB(140, 11, 194, 22),
        4: Color.fromARGB(255, 11, 194, 26),
      },
      onClick: (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
      },
    );
  }
}