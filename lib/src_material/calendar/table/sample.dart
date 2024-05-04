

// class SampleTableCalendarEvent extends StatefulWidget {
//   const SampleTableCalendarEvent({super.key});
//
//   @override
//   State<SampleTableCalendarEvent> createState() =>
//       _SampleTableCalendarEventState();
// }
//
// class _SampleTableCalendarEventState extends State<SampleTableCalendarEvent> {
//   final MyOverlay _overlay = MyOverlay();
//   bool _shouldBackToCalendar = false;
//
//   void _hideLastOverlayEntry() {
//     if (_overlay.entries.length == 1) _shouldBackToCalendar = true;
//     _overlay.removeLast();
//   }
//
//   Consumer<CalendarEvent> _showOverlay(bool isModificationView) => (event) {
//     _shouldBackToCalendar = false;
//     _overlay.addFadingEntry(
//       context: context,
//       shouldFadeOut: () => _shouldBackToCalendar,
//       builder: isModificationView
//           ? (context) => CustomMaterialApp(
//         home: _TableCalendarEventViewEventModification(
//           event: event,
//           onPressCancel: _hideLastOverlayEntry,
//           onPressSave: _hideLastOverlayEntry,
//         ),
//       )
//           : (context) => CustomMaterialApp(
//         home: _TableCalendarEventViewEventDetail(
//           event: event,
//           onBackButtonPressed: _hideLastOverlayEntry,
//           onEditButtonPressed: _showOverlay(true),
//         ),
//       ),
//     );
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.preference.colorPalette7.bright1,
//       body: Padding(
//         padding: KEdgeInsets.symH_8,
//         child: TableCalendarEventViewCalendar(
//           onShowViewEventModification: _showOverlay(true),
//           onShowViewEventDetail: _showOverlay(false),
//         ),
//       ),
//     );
//   }
// }



// class SampleTableCalendarNote extends StatefulWidget {
//   SampleTableCalendarNote({
//     super.key,
//     DateTime? initialDateTime,
//   }) : initialFocusedDay = initialDateTime ?? DateTime.now();
//
//   final DateTime initialFocusedDay;
//
//   @override
//   State<SampleTableCalendarNote> createState() =>
//       _SampleTableCalendarNoteState();
// }
//
// class _SampleTableCalendarNoteState extends State<SampleTableCalendarNote> {
//   final MyOverlay _overlay = MyOverlay();
//
//   void _showSelectedDateNoteDetail(DateTime dateTime) {
//     bool shouldBackToCalendarView = false;
//     _overlay.addFadingEntry(
//       context: context,
//       shouldFadeOut: () => shouldBackToCalendarView,
//       builder: (context) => _TableCalendarDailyNoteViewDailyNote(
//         dateTime: dateTime,
//         backButtonPressed: () {
//           shouldBackToCalendarView = true;
//           _overlay.removeLast();
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: context.preference.colorPalette7.bright1,
//       child: _TableCalendarDailyNoteViewCalendar(
//         initialFocusedDay: widget.initialFocusedDay,
//         onSelectingSelectedDate: _showSelectedDateNoteDetail,
//       ),
//     );
//   }
// }
