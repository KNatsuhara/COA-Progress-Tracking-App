import 'package:flutter/material.dart';

class Constants extends InheritedWidget {
  static Constants? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Constants>();

  const Constants({required Widget child, required Key key}): super(key: key, child: child);

  final String successMessage = 'Some message';

  @override
  bool updateShouldNotify(Constants oldWidget) => false;
}


/// https://stackoverflow.com/questions/54069239/whats-the-best-practice-to-keep-all-the-constants-in-flutter#:~:text=Flutter%20tend%20to%20not%20have%20any%20global%2Fstatic%20variables,use%20an%20InheritedWidget.%20Which%20means%20you%20can%20write%3A