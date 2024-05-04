///
///
///
///
// ignore_for_file: constant_identifier_names
part of dapresent_calendar;

extension KTableCalendarStyle on TableCalendar {
  static const CalendarStyle none = CalendarStyle();
}

extension KTableCalendarDaysOfWeekStyle on DaysOfWeekStyle {
  static const DaysOfWeekStyle weekDayBlack_weekendBlack45 = DaysOfWeekStyle(
    weekdayStyle: KTextStyle.black,
    weekendStyle: KTextStyle.black45,
  );
}


///
///
/// [TableCalendarDayCell]
/// [TableCalendarRangeSwitchScope]
///
/// [CalendarEvent]
///

enum TableCalendarDayCell {
  normal,
  outside, // outside month
  today,
  selected;

  ///
  /// style 1
  ///

  static Widget _animatedTextStyle({
    required EdgeInsetsGeometry margin,
    required EdgeInsetsGeometry padding,
    required AlignmentGeometry alignment,
    required Duration duration,
    required Decoration decoration,
    required TextStyle textStyle,
    required DateTime day,
  }) =>
      DefaultTextStyle(
        style: textStyle,
        child: AnimatedContainer(
          duration: duration,
          margin: margin,
          padding: padding,
          alignment: alignment,
          decoration: decoration,
          child: Text(day.day.toString()),
        ),
      );

  static Widget configuration1({
    EdgeInsetsGeometry margin = KEdgeInsets.all_6,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    AlignmentGeometry alignment = Alignment.center,
    Duration duration = KCore.durationMilli300,
    Decoration? decoration,
    required TextStyle textStyle,
    required DateTime day,
  }) =>
      _animatedTextStyle(
        margin: margin,
        padding: padding,
        alignment: alignment,
        duration: duration,
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: KBorderRadius.allCircular_8,
          ),
        ),
        textStyle: textStyle,
        day: day,
      );

  FocusedDayBuilder get builderStyle1 => switch (this) {
        TableCalendarDayCell.normal => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.black45,
              day: day,
            ),
        TableCalendarDayCell.outside => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.black26,
              day: day,
            ),
        TableCalendarDayCell.today => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.boldBlack,
              day: day,
              decoration: ShapeDecoration(
                color: context.preference.colorPalette7.bright1,
                shape: FBorderOutlined.roundedRectangle(
                  borderRadius: KBorderRadius.allCircular_8,
                ),
              ),
            ),
        TableCalendarDayCell.selected => (context, day, focusedDay) =>
            configuration1(
              textStyle: KTextStyle.white,
              day: day,
              decoration: BoxDecoration(
                color: context.preference.colorPalette7.bright3,
                shape: BoxShape.circle,
              ),
            ),
      };

  ///
  /// style 2
  ///

  static Widget configuration2({
    EdgeInsetsGeometry margin = KEdgeInsets.ltrb_2_16_2_0,
    EdgeInsetsGeometry padding = KEdgeInsets.onlyTop_16,
    AlignmentGeometry alignment = Alignment.topCenter,
    Duration duration = KCore.durationMilli400,
    VoidCallback managementButtonOnTap = FListener.none,
    TextStyle textStyle = KTextStyle.black87,
    required ShapeDecoration decoration,
    required DateTime day,
  }) =>
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _animatedTextStyle(
            margin: margin,
            padding: padding,
            alignment: alignment,
            duration: duration,
            decoration: decoration,
            textStyle: textStyle,
            day: day,
          ),
          IgnorePointerAnimatedOpacity(
            duration: duration,
            ignoring: managementButtonOnTap == FListener.none,
            child: Padding(
              padding: KEdgeInsets.ltrb_8_0_8_8,
              child: SizedBox(
                height: textStyle.fontSize,
                width: double.infinity,
                child: Material(
                  elevation: 1.0,
                  color: decoration.color!.minusARGB(0, 30, 30, 30),
                  shape: FBorderOutlined.roundedRectangle(
                    borderRadius: KBorderRadius.bottom_10 * 0.8,
                  ),
                  child: InkWell(
                    borderRadius: KBorderRadius.bottom_10 * 0.8,
                    onTap: managementButtonOnTap,
                    child: Icon(
                      Icons.add,
                      size: textStyle.fontSize,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  FocusedDayBuilder builderStyle2({
    Intersector<DateTime>? beforeBuild,
    VoidCallback onTapIcon = FListener.none,
    int? focusMonth,
  }) {
    Widget defaultBuilder(
      BuildContext context,
      DateTime day,
      DateTime focusedDay,
    ) =>
        TableCalendarDayCell.configuration2(
          textStyle: KTextStyle.black45,
          duration: KCore.durationMilli200,
          decoration: ShapeDecoration(
            color: context.preference.colorPalette7.bright2,
            shape: FBorderOutlined.continuousRectangle(
              borderRadius: KBorderRadius.bottom_10 * 5.6,
            ),
          ),
          day: day,
        );
    Widget outsideBuilder(
      BuildContext context,
      DateTime day,
      DateTime focusedDay,
    ) =>
        TableCalendarDayCell.configuration2(
          textStyle: KTextStyle.black26,
          decoration: ShapeDecoration(
            color: context.preference.colorPalette7.bright1,
            shape: FBorderOutlined.continuousRectangle(
              side: FBorderSide.solidInside(color: Colors.black),
              borderRadius: KBorderRadius.bottom_10 * 1.6,
            ),
          ),
          day: day,
        );

    return switch (this) {
      // when sliding or changing page,
      // the 'newFocusedDay' is at the same position of 'focusedDay'
      TableCalendarDayCell.normal => (context, day, newFocusedDay) {
          beforeBuild?.call(day, newFocusedDay);
          return focusMonth != newFocusedDay.month
              ? outsideBuilder(context, day, newFocusedDay)
              : defaultBuilder(context, day, newFocusedDay);
        },
      TableCalendarDayCell.outside => (context, day, newFocusedDay) {
          beforeBuild?.call(day, newFocusedDay);
          return focusMonth != newFocusedDay.month
              ? defaultBuilder(context, day, newFocusedDay)
              : outsideBuilder(context, day, newFocusedDay);
        },
      TableCalendarDayCell.today => (context, day, newFocusedDay) {
          beforeBuild?.call(day, newFocusedDay);
          return TableCalendarDayCell.configuration2(
            textStyle: KTextStyle.black54,
            decoration: ShapeDecoration(
              color: context.preference.colorPalette7.bright3,
              shape: FBorderOutlined.continuousRectangle(
                borderRadius: KBorderRadius.bottom_10 * 4,
              ),
            ),
            day: day,
          );
        },
      TableCalendarDayCell.selected => (context, day, newFocusedDay) {
          beforeBuild?.call(day, newFocusedDay);
          return TableCalendarDayCell.configuration2(
            managementButtonOnTap: onTapIcon,
            textStyle: KTextStyle.boldWhite,
            decoration: ShapeDecoration(
              color: context.preference.colorPalette7.primary,
              shape: FBorderOutlined.continuousRectangle(
                borderRadius: KBorderRadius.bottom_10 * 1.4,
              ),
            ),
            day: day,
          );
        },
    };
  }
}

enum TableCalendarRangeSwitchScope {
  twoWeek,
  oneYear;

  int get pageDateCount => switch (this) {
        TableCalendarRangeSwitchScope.twoWeek => 14,
        TableCalendarRangeSwitchScope.oneYear => 35 * 12,
      };
}
