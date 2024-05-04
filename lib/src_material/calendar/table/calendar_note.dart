part of dapresent_calendar;

///
/// this file contains:
/// [TableCalendarDailyNoteViewCalendar]
/// [_TableCalendarDailyNoteElementMonthArrow]
/// [_TableCalendarDailyNoteViewDailyNote]
///
///

class TableCalendarDailyNoteViewCalendar extends StatefulWidget {
  const TableCalendarDailyNoteViewCalendar({
    // super.key,
    // this.animatedMonthArrow = true,
    required this.initialFocusedDay,
    // required this.onSelectDate,
    required this.onSelectingSelectedDate,
  });

  final DateTime initialFocusedDay;
  final Consumer<DateTime> onSelectingSelectedDate;

  // final Consumer<DateTime> onSelectDate;
  // final bool animatedMonthArrow;

  @override
  State<TableCalendarDailyNoteViewCalendar> createState() =>
      _TableCalendarDailyNoteViewCalendarState();
}

class _TableCalendarDailyNoteViewCalendarState
    extends State<TableCalendarDailyNoteViewCalendar> {
  late final DateTime _focusedDay;
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = _focusedDay = widget.initialFocusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 420,
        child: TableCalendar(
          shouldFillViewport: true,
          // locale: 'zh',
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(1911, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          selectedDayPredicate: DateTimeExtension.sameDayWith(_selectedDate),
          onDaySelected: (selectedDate, focusedDate) {
            _focusedDay = focusedDate;

            setState(() {
              if (isSameDay(_selectedDate, selectedDate)) {
                widget.onSelectingSelectedDate(selectedDate);
              } else {
                _selectedDate = selectedDate;
                // next: show AnimatedFinger around selected day
              }
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          pageJumpingEnabled: true,
          calendarBuilders: CalendarBuilders(
            prioritizedBuilder: null,
            todayBuilder: TableCalendarDayCell.today.builderStyle1,
            selectedBuilder: TableCalendarDayCell.selected.builderStyle1,
            rangeStartBuilder: null,
            rangeEndBuilder: null,
            withinRangeBuilder: null,
            rangeHighlightBuilder: null,
            outsideBuilder: TableCalendarDayCell.outside.builderStyle1,
            disabledBuilder: null,
            holidayBuilder: null,
            defaultBuilder: TableCalendarDayCell.normal.builderStyle1,
            singleMarkerBuilder: null,
            markerBuilder: null,
            dowBuilder: null,
            headerTitleBuilder: (context, dateTime) => null,
            weekNumberBuilder: null,
          ),
          daysOfWeekVisible: false,
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            headerPadding: KEdgeInsets.symH_12,
            leftChevronIcon: _TableCalendarDailyNoteElementMonthArrow(
              isPrevious: true,
              // isAnimatable: null,
            ),
            rightChevronIcon: _TableCalendarDailyNoteElementMonthArrow(
              isPrevious: false,
              // isAnimatable: null,
            ),
          ),
          // onCalendarCreated: (controller) => pageController = controller,
        ),
      ),
    );
  }
}

class _TableCalendarDailyNoteElementMonthArrow extends StatelessWidget {
  const _TableCalendarDailyNoteElementMonthArrow._({
    required this.iconBuilder,
  });

  factory _TableCalendarDailyNoteElementMonthArrow({
    Direction3DIn6 directionA = Direction3DIn6.left,
    Direction3DIn6 directionB = Direction3DIn6.right,
    Duration? isAnimatable = KCore.durationSecond1,
    required bool isPrevious,
  }) {
    final iconData = switch (directionA) {
      Direction3DIn6.left => switch (directionB) {
          Direction3DIn6.right =>
            isPrevious ? Icons.chevron_left : Icons.chevron_right,
          _ => throw UnimplementedError(),
        },
      _ => throw UnimplementedError(),
    };

    Icon iconOf(BuildContext context) => Icon(
          iconData,
          color: context.preference.colorPalette7.dark1,
        );

    // final end = (isPrevious ? KOffset.left : KOffset.right) * 0.2;

    final iconBuilder = isAnimatable != null
        // ? (context) => MyAnimationSin.slider(
        //       amplitudePosition: end,
        //       times: 1,
        //       home: iconOf(context),
        //     )
        ? iconOf
        : iconOf;

    return _TableCalendarDailyNoteElementMonthArrow._(iconBuilder: iconBuilder);
  }

  final WidgetBuilder iconBuilder;

  @override
  Widget build(BuildContext context) => iconBuilder(context);
}

class _TableCalendarDailyNoteViewDailyNote extends StatefulWidget {
  const _TableCalendarDailyNoteViewDailyNote({
    required this.dateTime,
    required this.backButtonPressed,
  });

  final DateTime dateTime;
  final VoidCallback backButtonPressed;

  @override
  State<_TableCalendarDailyNoteViewDailyNote> createState() =>
      _TableCalendarDailyNoteViewDailyNoteState();
}

class _TableCalendarDailyNoteViewDailyNoteState
    extends State<_TableCalendarDailyNoteViewDailyNote> {
  late final FocusNode _focusNode;
  late final TextEditingController _noteController;

  // late DailyNote? _note;

  // String get _noteId => "${_newDay.year.toString()} "
  //     "${_newDay.month.toString()} "
  //     "${_newDay.day.toString()}";
  // late DateTime _newDay;

  // final currentHour = dateTime.hour.toString();
  // final currentMinute = dateTime.minute.toString();
  // final currentSecond = dateTime.second.toString();

  // late final DailyNoteLocalDatabaseProvider _database;
  bool _databaseOpen = false;

  Future<void> _saveNote() async {
    if (_noteController.text.isEmpty) {
      //   if (await _database.itemExist(_noteId)) {
      //     // next: show dialog, make sure user want delete
      //
      //     await _deleteNote();
      //   }
      // } else {
      //   final newNote = DailyNote(id: _noteId, content: _noteController.text);
      //
      //   if (_note == null) {
      //     await _database.itemInsert(newNote);
      //   } else {
      //     await _database.itemUpdate(_noteId, newNote);
      //   }
    }
  }

  // Future<void> _deleteNote() async => await _database.itemDelete(_noteId);

  late Future<void> _futureNote;

  Future<void> _getNote() async {
    if (!_databaseOpen) {
      // await _database.open();
      // await _database.close();
      // await _database.remove();
      _databaseOpen = true;
    }

    // _note = await _database.itemGet(_noteId);
    // _noteController.text = _note != null ? _note!.content : '';
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    // _database = DailyNoteLocalDatabaseProvider();
    _noteController = TextEditingController();
    // _newDay = widget.dateTime;

    _futureNote = _getNote();
    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant _TableCalendarDailyNoteViewDailyNote oldWidget) {
    final dateTime = widget.dateTime;
    if (!DateTimeExtension.predicateSameDate(oldWidget.dateTime, dateTime)) {
      // _newDay = dateTime;
      _futureNote = _getNote();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _noteController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      _saveNote();

                      widget.backButtonPressed();
                    },
                    icon: BackButton(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${widget.dateTime.month} / ${widget.dateTime.day}')
                ],
              )
            ],
          ),
          InkWell(
            focusColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Padding(
              padding: KEdgeInsets.symH_18,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: _futureNote,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        return TextField(
                          enabled: true,
                          autofocus: true,
                          focusNode: _focusNode,
                          onTap: _focusNode.requestFocus,
                          controller: _noteController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                            hintText: 'note',
                          ),
                        );
                      default:
                        return WProgressIndicator.circular;
                    }
                  },
                ),
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: WIconMaterial.photo,
                iconSize: 20.0,
                splashRadius: 20.0,
                onPressed: FListener.none,
              ),
              IconButton(
                icon: WIconMaterial.mailOutline,
                iconSize: 20.0,
                splashRadius: 20.0,
                onPressed: FListener.none,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
