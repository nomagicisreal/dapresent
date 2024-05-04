import 'package:dapresent/dapresent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    Preference(
      child: CustomMaterialApp(
        home: Demo(),
      ),
    ),
  );
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendarEventViewCalendar(
        onShowViewEventModification: (e) {},
        onShowViewEventDetail: (e) {},
      ),
    );
  }
}
