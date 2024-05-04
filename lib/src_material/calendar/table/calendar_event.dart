///
///
/// this file contains:
/// [TableCalendarEventViewCalendar]
/// [_TableCalendarEventElementHeader]
/// [_TableCalendarEventElementTail]
/// [_TableCalendarEventViewEventDetail]
/// [_TableCalendarEventViewEventModification]
///
part of dapresent_calendar;

class TableCalendarEventViewCalendar extends StatefulWidget {
  const TableCalendarEventViewCalendar({
    super.key,
    required this.onShowViewEventModification,
    required this.onShowViewEventDetail,
  });

  final Consumer<CalendarEvent> onShowViewEventModification;
  final Consumer<CalendarEvent> onShowViewEventDetail;

  @override
  State<TableCalendarEventViewCalendar> createState() =>
      _TableCalendarEventViewCalendarState();
}

class _TableCalendarEventViewCalendarState
    extends State<TableCalendarEventViewCalendar> {
  late final PageController _pageController;
  final List<CalendarEvent> _selectedEvents = <CalendarEvent>[];

  DateTime? _selectedDay;
  bool _isTodayOnPage = true;

  // late TableCalendarRangeSwitchScope _switchScope;
  late DateTime _focusedDay;

  int get _focusedMonth => _focusedDay.month;

  // late RangeSelectionMode _rangeSelectionMode;
  // DateTime? _rangeStart;
  // DateTime? _rangeEnd;

  @override
  void initState() {
    _focusedDay = DateTime.now();
    // _rangeSelectionMode = RangeSelectionMode.toggledOff;
    // _switchScope = TableCalendarRangeSwitchScope.twoWeek;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TableCalendarEventElementHeader(
          height: 40.0,
          focusedDay: _focusedDay,
          showTodayButton: !_isTodayOnPage,
          onTodayButtonTap: listenSetStateOf(
            () => _focusedDay = DateTime.now(),
          ),
          onLeftArrowTap: () => _pageController.previousPage(
            duration: KCore.durationMilli300,
            curve: Curves.easeOut,
          ),
          onRightArrowTap: () => _pageController.nextPage(
            duration: KCore.durationMilli300,
            curve: Curves.easeOut,
          ),
        ),
        SizedBox(
          height: 360,
          child: Padding(
            padding: KEdgeInsets.onlyBottom_16,
            child: TableCalendar(
              // locale: 'zh',
              firstDay: DateTime.utc(1911, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              shouldFillViewport: true,
              headerVisible: false,
              daysOfWeekVisible: true,
              calendarFormat: CalendarFormat.twoWeeks,
              daysOfWeekStyle:
                  KTableCalendarDaysOfWeekStyle.weekDayBlack_weekendBlack45,
              onCalendarCreated: (controller) => _pageController = controller,
              calendarBuilders: CalendarBuilders(
                defaultBuilder: TableCalendarDayCell.normal.builderStyle2(
                  focusMonth: _focusedMonth,
                ),
                outsideBuilder: TableCalendarDayCell.outside.builderStyle2(
                  focusMonth: _focusedMonth,
                ),
                todayBuilder: TableCalendarDayCell.today.builderStyle2(
                  beforeBuild: (day, focusedDay) => _isTodayOnPage = true,
                ),
                selectedBuilder: TableCalendarDayCell.selected.builderStyle2(
                  onTapIcon: () => widget.onShowViewEventModification(
                    CalendarEvent(
                      'id',
                      DateTime.now(),
                      DateTime.now(),
                      name: 'name',
                    ),
                  ),
                ),
                // rangeStartBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // rangeEndBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // withinRangeBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // disabledBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // holidayBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // rangeHighlightBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // singleMarkerBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // markerBuilder: (context, builtDay, focusedDay) {
                //   return Container();
                // },
                // weekNumberBuilder: ,
              ),
              selectedDayPredicate: DateTimeExtension.sameDayWith(_selectedDay),
              onDaySelected: (selectedDay, focusedDay) => setState(() {
                if (!DateTimeExtension.predicateSameDate(
                    _selectedDay, selectedDay)) {
                  _focusedDay = focusedDay;
                  _selectedDay = selectedDay;
                  _selectedEvents.addAll(
                    CalenderRepository().getEventForDay(selectedDay),
                  );
                } else {
                  _selectedDay = null; // cancel select
                }

                //   _rangeStart = null;
                //   _rangeEnd = null;
                //   _rangeSelectionMode = RangeSelectionMode.toggledOff;
              }),

              // rangeStartDay: _rangeStart,
              // rangeEndDay: _rangeEnd,
              // rangeSelectionMode: _rangeSelectionMode,
              // onRangeSelected: (start, end, focusedDay) {
              //   setState(() {
              //     _selectedDate = null;
              //     _latestFocusedDate = focusedDay;
              //     _rangeStart = start;
              //     _rangeEnd = end;
              //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
              //   });
              // },
              focusedDay: _focusedDay,
              onPageChanged: (focusedDay) => setState(
                () => _focusedDay = focusedDay,
              ),
            ),
          ),
        ),
        _TableCalendarEventElementTail(
          selectedDate: _selectedDay,
          eventListForDay: _selectedEvents,
          eventOnTap: widget.onShowViewEventDetail,
        ),
      ],
    );
  }
}

class _TableCalendarEventElementHeader extends StatefulWidget {
  const _TableCalendarEventElementHeader({
    this.height = 40.0,
    required this.focusedDay,
    required this.showTodayButton,
    required this.onTodayButtonTap,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  });

  final double height;
  final DateTime focusedDay;
  final bool showTodayButton;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  @override
  State<_TableCalendarEventElementHeader> createState() =>
      _TableCalendarEventElementHeaderState();
}

class _TableCalendarEventElementHeaderState
    extends State<_TableCalendarEventElementHeader> {
  late final GlobalKey<AnimatedListState> _titleWidgetsKey;

  AnimatedListState? get _titleWidgetsState => _titleWidgetsKey.currentState;
  final List<Widget> _titleWidgets = <Widget>[];
  late double _headerHeight;

  @override
  void initState() {
    _headerHeight = widget.height;
    _titleWidgets.add(_textWidget(widget.focusedDay));
    _titleWidgetsKey = GlobalKey<AnimatedListState>();

    super.initState();
  }

  @override
  void didUpdateWidget(
    covariant _TableCalendarEventElementHeader oldWidget,
  ) {
    _headerHeight = widget.height;

    final oldFocusedDate = oldWidget.focusedDay;
    final newFocusedDate = widget.focusedDay;
    if (newFocusedDate.month != oldFocusedDate.month) {
      // remove old text
      final oldTextIndex = _findWidgetIndex('SizedBox');
      _titleWidgets.removeAt(oldTextIndex);

      _titleWidgetsState!.removeItem(
        oldTextIndex,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          axisAlignment: 0.0,
          child: _textWidget(oldWidget.focusedDay),
        ),
      );

      // insert new text
      _titleWidgets.insert(oldTextIndex, _textWidget(widget.focusedDay));
      _titleWidgetsState!.insertItem(oldTextIndex);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    // if (direction != null) {
    //   if (widget.showTodayButton) {
    //     switch (direction) {
    //       case Direction2DIn4.left:
    //         if (_titleWidgets.length == 1) {
    //           _titleWidgets.insert(1, _todayButton);
    //           _titleWidgetsState!.insertItem(1);
    //         }
    //         break;
    //
    //       case Direction2DIn4.right:
    //         if (_titleWidgets.length == 1) {
    //           _titleWidgets.insert(0, _todayButton);
    //           _titleWidgetsState!.insertItem(0);
    //         }
    //         break;
    //       default:
    //         throw UnimplementedError();
    //     }
    //   } else {
    //     if (_titleWidgets.length == 2) {
    //       _removeTodayButton();
    //     }
    //   }
    // }

    // next: build direction for next month, next year
    return Row(
      children: [
        IconButton(
          splashRadius: 16,
          icon: WIconMaterial.chevronLeft,
          iconSize: _headerHeight / 2,
          onPressed: () {
            widget.onLeftArrowTap();
            // next: insert previous title widget in here, but do it after have a nice [CustomAnimatedList], and more generic calendar header arrow
          },
        ),
        WSpacer.none,
        AnimatedContainer(
          width: _titleWidgets.length == 1 ? 120 : 180,
          height: _headerHeight,
          duration: KCore.durationMilli300,
          child: AnimatedList(
            key: _titleWidgetsKey,
            scrollDirection: Axis.horizontal,
            initialItemCount: _titleWidgets.length,
            itemBuilder: (context, index, animation) {
              final currentWidget = _titleWidgets.elementAt(index);
              final current = currentWidget.toStringShort();

              return SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                axisAlignment: switch (current) {
                  'IconButton' => switch (index) {
                      0 => 1.0,
                      1 => -1.0,
                      _ => throw UnimplementedError(),
                    },
                  'SizedBox' => 1.0,
                  _ => 0.0,
                },
                child: currentWidget,
              );
            },
          ),
        ),
        WSpacer.none,
        IconButton(
          splashRadius: 16,
          icon: WIconMaterial.chevronRight,
          iconSize: _headerHeight / 2,
          onPressed: () {
            widget.onRightArrowTap();
            // next: insert next title widget in here, but do it after have a nice [CustomAnimatedList], and more generic calendar header arrow
          },
        ),
      ],
    );
  }

  // next: only modify yearText, only modify monthText
  Widget _textWidget(DateTime focusedDate) => SizedBox(
        width: 120,
        height: widget.height,
        child: Center(
          child: Text(
            widget.focusedDay.month.toString(),
            // DateFormat.yMMM('zh').format(focusedDate),
            style: TextStyle(fontSize: _headerHeight / 2),
          ),
        ),
      );

  Widget get _todayButton => IconButton(
        splashRadius: 16,
        padding: EdgeInsets.zero,
        icon: WIconMaterial.calendarToday,
        iconSize: _headerHeight / 2,
        onPressed: () {
          widget.onTodayButtonTap();
          _removeTodayButton();
        },
      );

  void _removeTodayButton() {
    final index = _findWidgetIndex('IconButton');
    _titleWidgets.removeAt(index);
    _titleWidgetsState!.removeItem(
        index,
        (context, animation) => SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              axisAlignment: index == 0 ? 1.0 : -1.0,
              // 1.0: remove to left
              // -1.0: remove to right
              child: _todayButton,
            ));
  }

  int _findWidgetIndex(String widgetName) =>
      _titleWidgets.elementAt(0).toStringShort() == widgetName ? 0 : 1;
}

class _TableCalendarEventElementTail extends StatefulWidget {
  const _TableCalendarEventElementTail({
    required this.selectedDate,
    required this.eventListForDay,
    required this.eventOnTap,
  });

  final DateTime? selectedDate;
  final List<CalendarEvent> eventListForDay;
  // final bool updateRemoveThenAdd;
  final Consumer<CalendarEvent> eventOnTap;

  @override
  State<_TableCalendarEventElementTail> createState() =>
      _TableCalendarEventElementTailState();
}

class _TableCalendarEventElementTailState
    extends State<_TableCalendarEventElementTail> {
  final List<CalendarEvent> _selectedEvents = <CalendarEvent>[];
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  AnimatedListState? get _listState => _key.currentState;
  DateTime? _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.selectedDate;
    super.initState();
  }

  @override
  void didUpdateWidget(
      covariant _TableCalendarEventElementTail oldWidget) {
    _selectedDate = widget.selectedDate;
    final oldEvents = oldWidget.eventListForDay;
    final newEvents = widget.eventListForDay;
    if (_selectedEvents.isNotEmpty) {
      ///
      /// next:
      /// 1. removing not modified index, adding as old;
      /// 2. removing modified index, update adding indexes;
      /// 3. adding not modified index, removing as old;
      /// 4. adding modified index, update removing indexes;
      ///
      // final intersection = oldEvents.iterator.intersection(newEvents);
      final toRemoved = oldEvents.iterator.differenceIndex(newEvents);
      final toAdded = newEvents.iterator.differenceDetail(oldEvents);

      for (var index in toRemoved) {
        _listState!.removeItem(
          index,
          (context, animation) => SizeTransition(
            sizeFactor: animation,
            child: _eventOf(_selectedEvents.removeAt(index)),
          ),
        );
      }

      for (var added in toAdded.entries) {
        final index = added.key;
        _selectedEvents.insert(index, added.value.$1);
        _listState!.insertItem(index);
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: _selectedDate == null ? 0.0 : 180.0,
      duration: KCore.durationMilli300,
      padding: KEdgeInsets.symH_12,
      child: IgnorePointer(
        ignoring: _selectedDate == null,
        child: AnimatedOpacity(
          opacity: _selectedDate == null ? 0.0 : 1.0,
          duration: KCore.durationMilli300,
          child: Container(
            decoration: ShapeDecoration(
              color: context.preference.colorPalette7.bright3,
              shape: FBorderInput.outline(borderRadius: BorderRadius.zero),
            ),
            child: AnimatedList(
              key: _key,
              initialItemCount: _selectedEvents.length,
              itemBuilder: (context, index, animation) => FadeTransition(
                opacity: animation,
                child: _eventOf(_selectedEvents[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _eventOf(CalendarEvent event) => SizedBox(
        height: 64,
        child: Stack(
          children: [
            RowPaddingColumn(
              mainAxisAlignmentRow: MainAxisAlignment.end,
              mainAxisAlignmentColumn: MainAxisAlignment.center,
              padding: KEdgeInsets.onlyRight_8,
              children: [
                SizedBox(
                  height: 32,
                  width: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.preference.colorPalette7.bright3,
                    ),
                    onPressed: () => widget.eventOnTap(event),
                    child: const Center(child: WIconMaterial.readMore),
                  ),
                ),
              ],
            ),
            RowPadding(
              padding: KEdgeInsets.symH_12 + KEdgeInsets.onlyRight_4,
              child: Padding(
                padding: KEdgeInsets.all_8,
                child: Card(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 156,
                        child: Center(child: Text(event.name)),
                      ),
                      const SizedBox(
                        height: 48.0,
                        child: VerticalDivider(
                          color: Colors.black,
                          thickness: 1.0,
                        ),
                      ),
                      SizedBox(
                        width: 96,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('start: ${event.start?.date}'),
                            Text(' end : ${event.end?.date}'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _TableCalendarEventViewEventDetail extends StatefulWidget {
  const _TableCalendarEventViewEventDetail({
    required this.event,
    required this.onBackButtonPressed,
    required this.onEditButtonPressed,
  });

  final CalendarEvent? event;
  final VoidCallback onBackButtonPressed;
  final Consumer<CalendarEvent> onEditButtonPressed;

  @override
  State<_TableCalendarEventViewEventDetail> createState() =>
      _TableCalendarEventViewEventDetailState();
}

class _TableCalendarEventViewEventDetailState
    extends State<_TableCalendarEventViewEventDetail> {
  late final FocusNode _focusNode;
  late final TextEditingController _chatTextController;
  late CalendarEvent? _event;

  @override
  void initState() {
    _chatTextController = TextEditingController();
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _chatTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(
      covariant _TableCalendarEventViewEventDetail oldWidget) {
    if (widget.event == null) {
      _chatTextController.clear();
    } else {
      _event = widget.event;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.preference.colorPalette7;
    _event = widget.event;

    return Material(
      color: palette.bright2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: KEdgeInsets.symH_8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 20,
                  icon: WIconMaterial.backspace,
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  onPressed: widget.onBackButtonPressed,
                ),
                Text(_event?.name ?? ''),
                IconButton(
                  splashRadius: 20.0,
                  icon: WIconMaterial.edit,
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  onPressed: () => widget.onEditButtonPressed(_event!),
                ),
              ],
            ),
          ),
          Divider(thickness: 2.0, color: palette.bright3),
          Padding(
            padding: KEdgeInsets.symH_12,
            child: SingleChildScrollView(child: Container()),
          ),
        ],
      ),
    );
  }
}

class _TableCalendarEventViewEventModification extends StatefulWidget {
  const _TableCalendarEventViewEventModification({
    required this.event,
    required this.onPressCancel,
    required this.onPressSave,
  });

  final CalendarEvent event;
  final VoidCallback onPressCancel;
  final VoidCallback onPressSave;

  @override
  State<_TableCalendarEventViewEventModification> createState() =>
      _TableCalendarEventViewEventModificationState();
}

class _TableCalendarEventViewEventModificationState
    extends State<_TableCalendarEventViewEventModification> {
  late final TextEditingController _eventNameController;
  late final TextEditingController _eventDescriptionController;
  CalendarEvent? _tableCalendarEvent;

  bool _isDatabaseOpen = false;

  // late final TableCalendarEventLocalDatabaseProvider _database;

  // CalendarEvent _createTableCalendarEvent(String eventId) => CalendarEvent(
  //       eventId,
  //       _tableCalendarEvent!.start,
  //       _tableCalendarEvent!.end,
  //       name: _eventNameController.text,
  //     );

  Future<void> _saveTableCalendarEvent() async {
    if (!_isDatabaseOpen) {
      // await _database.open();
      // await _database.close();
      // await _database.remove();
      _isDatabaseOpen = true;
    }

    // if (widget.defaultAddingEventStartTime != null) {
    //   final eventId = DateTime.now().millisecondsSinceEpoch.toString();
    //   final newTableCalendarEvent = _createTableCalendarEvent(eventId);
    //   // _database.itemInsert(newTableCalendarEvent);
    // } else if (widget.event != null) {
    //   final eventId = _tableCalendarEvent!.id;
    //   final newTableCalendarEvent = _createTableCalendarEvent(eventId);
    //   // await _database.itemUpdate(eventId, newTableCalendarEvent);
    // } else {
    //   throw Exception('impossible');
    // }

    _tableCalendarEvent = null;
    _eventDescriptionController.clear();
    _eventNameController.clear();
  }

  @override
  void initState() {
    // _database = TableCalendarEventLocalDatabaseProvider();
    _eventNameController = TextEditingController();
    _eventDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.preference.colorPalette7;
    _tableCalendarEvent = widget.event;
    // if (widget.defaultAddingEventStartTime == null &&
    //     _tableCalendarEvent == null) {
    //   return Material(color: palette.bright3, child: Container());
    // } else {
    _eventNameController.text = _tableCalendarEvent?.name ?? '';
    _eventDescriptionController.text = _tableCalendarEvent?.description ?? '';

    return Material(
      color: palette.bright3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: KEdgeInsets.symH_8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 20,
                  color: Colors.white,
                  icon: WIconMaterial.delete,
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  onPressed: widget.onPressCancel,
                ),
                SizedBox(
                  width: 250,
                  child: TextField(
                    autofocus: true,
                    controller: _eventNameController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'event name',
                      hintStyle: KTextStyle.white_24,
                    ),
                    style: KTextStyle.white_28,
                    cursorColor: Colors.white,
                  ),
                ),
                IconButton(
                  splashRadius: 20.0,
                  color: Colors.white,
                  icon: WIconMaterial.check,
                  iconSize: 28,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if (_eventNameController.text.isEmpty) {
                      context.showSnackbarWithMessage(
                        'name must not be null',
                        duration: KCore.durationMilli300,
                      );
                    } else {
                      _saveTableCalendarEvent();
                      context.showSnackbarWithMessage('save event',
                          duration: KCore.durationMilli300);
                      widget.onPressSave();
                    }
                  },
                ),
              ],
            ),
          ),
          Divider(
            indent: 16.0,
            endIndent: 16.0,
            thickness: 4.0,
            color: palette.bright1,
          ),
          Padding(
            padding: KEdgeInsets.symH_12,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'start : ${widget.event.start?.date}',
                    style: KTextStyle.white,
                  ),
                  Text(' end  : ${widget.event.end?.date}',
                      style: const TextStyle(color: Colors.white)),
                  WDivider.white,
                  TextField(
                    controller: _eventDescriptionController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'description',
                      hintStyle: KTextStyle.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // }
  }
}
