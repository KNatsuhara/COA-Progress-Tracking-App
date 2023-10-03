import 'package:coa_progress_tracking_app/pages/calendar_page.dart';
import 'package:coa_progress_tracking_app/pages/progress_page.dart';
import 'package:flutter/material.dart';
import '../utilities/app_bar_wrapper.dart';

class ProgressCalendarPage extends StatefulWidget {
  const ProgressCalendarPage({super.key});
  @override
  State<ProgressCalendarPage> createState() => _ProgressCalendarState();
}

class _ProgressCalendarState extends State<ProgressCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],

        /// ***** App Bar ***** ///
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBarWrapper(
            title: "Progress",
          ),
        ),

        body: Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Icon(Icons.table_rows_rounded, color: Colors.green),
              ),
              Tab(
                icon: Icon(Icons.calendar_month_rounded, color: Colors.green),
              ),
            ]),

            Expanded(
              child: TabBarView(children: [
                // 1st Tab
                ProgressPage(),
                // 2nd Tab
                CalendarPage(),
              ]),
            )

          ],
        ),
      ),
    );
  }
}
