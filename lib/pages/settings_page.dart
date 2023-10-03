import 'package:flutter/material.dart';
import '../utilities/app_bar_wrapper.dart';
import 'package:volume_control/volume_control.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';


class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double volume = 0.2;

  void initState() {
    super.initState();
    getVolume();
  }

  void getVolume() async {
    double currentVolume = await PerfectVolumeControl.getVolume();
    print("current volume is: $currentVolume");
    setState(() {
      volume = currentVolume;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.grey[300],

        /// ***** App Bar ***** ///
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBarWrapper(
            title: "Settings",
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            //add more rows for additional settings
            //NOTE: volume container
            Container(
                //color: Colors.grey[100],
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border: Border(
                    bottom: BorderSide(color: Colors.grey)
                  )
                ),
                child: Row(
                  //NOTE: NOTIFICATIONS ROW
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IntrinsicWidth(
                      child: Container(
                          constraints: BoxConstraints(
                            minWidth: width * 0.1,
                            maxWidth: width * 0.6,
                          ),
                          // username textbox container
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.025,
                              vertical: height * 0.025),
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                              vertical: height * 0.015),
                          decoration: BoxDecoration(
                            //color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              'Volume',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Colors.black,
                                fontSize: width * 0.05,
                              ),
                            ),
                          )),
                    ),
                    Flexible(
                      child: Container(
                          //color: Colors.red,
                          margin: EdgeInsets.symmetric(
                              horizontal: width * 0.04,
                              vertical: height * 0.01),
                          child: Transform.scale(
                            scale: 1 + (height * 0.00025),
                            child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 7,
                                ),
                                child: Container(
                                    width: width * 0.3,
                                    height: height * 0.1,
                                    child: Slider(
                                      divisions: 5,
                                      max: 100,
                                      value: volume,
                                      onChanged: (newBool) {
                                        setState(() {
                                          volume = newBool;
                                        });
                                        print("volume is:  $volume");

                                        PerfectVolumeControl.setVolume(volume/100);
                                        //print("width is: $width");
                                      },
                                    ))),
                          )),
                    )
                  ],
                )),
            //NOTE: Notifications container

          ],
        )));
  }
}
