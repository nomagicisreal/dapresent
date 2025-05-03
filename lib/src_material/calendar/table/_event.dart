part of '../calendar.dart';

///
/// [CalendarEvent]
/// [CalenderRepository]
///

///
///
///
class CalendarEvent {
  final String id;
  String name;
  String description;
  DateTime? start;
  DateTime? end;

  CalendarEvent(
    this.id,
    this.start,
    this.end, {
    this.description = '',
    required this.name,
  });

  CalendarEvent.init()
      : id = DateTime.now().toString(),
        start = null,
        end = null,
        name = '',
        description = '';

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(covariant CalendarEvent other) => id == other.id;
}

class CalenderRepository {
  CalenderRepository._();

  static final CalenderRepository _instance = CalenderRepository._();

  bool _databaseNotYetOpen = true;

  factory CalenderRepository() {
    if (_instance._databaseNotYetOpen) {
      _instance._databaseNotYetOpen = false;
      throw UnimplementedError();
    }

    return _instance;
  }

  List<CalendarEvent> getEventForDay(DateTime dateTime) {
    // throw UnimplementedError();
    return [
      CalendarEvent('id', DateTime.now(), null, name: 'name'),
      CalendarEvent('ad', DateTime.now(), null, name: 'come'),
      CalendarEvent('bd', DateTime.now(), null, name: 'na'),
      CalendarEvent('cd', DateTime.now(), null, name: 'a'),
    ];
  }
}
