part of dapresent_material;

///
/// this file contains:
///
/// [CustomText]
/// [CustomTextFormField]
/// [CustomSearchingBar]
///
/// [OperatorExtension]
///
///
///
///

class CustomText extends StatelessWidget {
  const CustomText._(
    this.data, {
    super.key,
    this.style,
  });

  final String data;
  final TextStyle? style;

  factory CustomText.ofDouble(
    double value, {
    Key? key,
    int fixed = 0,
    TextStyle? style,
  }) =>
      CustomText._(
        value.toStringAsFixed(fixed),
        key: key,
        style: style,
      );

  // factory CustomText.ofDuration(
  //   Duration value, {
  //   Key? key,
  //   bool toDayMinuteSecond = true,
  //   String splitter = ':',
  //   TextStyle? style,
  // }) =>
  //     throw UnimplementedError();

  // CustomText._(
  //   value.toStringDayMinuteSecond(splitter: splitter),
  //   key: key,
  //   style: style,
  // );

  //...

  @override
  Widget build(BuildContext context) {
    return Text(data, key: key, style: style);
  }
}

///
///
/// [CustomTextFormField]
///
///
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.decoration,
    required this.style,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;
  final TextStyle? style;

  factory CustomTextFormField.style1({
    TextStyle? textStyle,
    TextFormFieldValidator validator =
        FTextFormFieldValidator.validateNullOrEmpty,
    required TextEditingController controller,
    required String vfMessage,
    required InputDecoration decoration,
  }) =>
      CustomTextFormField(
        controller: controller,
        validator: validator(vfMessage),
        decoration: decoration,
        style: textStyle,
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: decoration,
      style: style,
    );
  }
}

///
///
/// [CustomSearchingBar]
///
///
class CustomSearchingBar extends StatefulWidget {
  const CustomSearchingBar({
    super.key,
    required this.backgroundColor,
    required this.child,
  });
  final Color backgroundColor;
  final Widget child;

  @override
  State<CustomSearchingBar> createState() => _SearchingBarState();
}

class _SearchingBarState extends State<CustomSearchingBar>
    with SingleTickerProviderStateMixin {
  final FocusNode _searchingFocusNode = FocusNode();
  late final double _searchingBarHeight;
  late final double _searchingBarTopPadding;
  late final Color _searchingColor;
  late final Color _pageColor;
  late final Color _backgroundColor;
  late final Offset _maxWindowOffset;
  late bool _isExpand;

  @override
  void initState() {
    _maxWindowOffset = context.sizeMedia.bottomRight(Offset.zero);
    _isExpand = false;
    _backgroundColor = widget.backgroundColor;
    _pageColor = _backgroundColor.plusAllRGB(30);
    _searchingColor = _backgroundColor.plusAllRGB(50);

    final appBarHeight = AppBar().preferredSize.height;
    _searchingBarHeight = appBarHeight * 4 / 5;
    _searchingBarTopPadding = appBarHeight / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: Size.fromHeight(_searchingBarHeight),
        child: Stack(
          children: [
            widget.child,
            AnimatedPositioned(
              curve: Curves.fastLinearToSlowEaseIn,
              top: _isExpand ? 0.0 : _searchingBarTopPadding,
              left: _isExpand ? 0.0 : _maxWindowOffset.dx / 6,
              right: _isExpand
                  ? _maxWindowOffset.dx
                  : _maxWindowOffset.dx * 1 / 24,
              height: _isExpand ? _maxWindowOffset.dy : _searchingBarHeight,
              duration: KCore.durationMilli500,
              child: Container(
                decoration: FDecorationBox.rectangle(color: _backgroundColor),
                child: _searchingPage(),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.fastLinearToSlowEaseIn,
              top: _searchingBarTopPadding,
              left: _isExpand
                  ? _maxWindowOffset.dx / 10
                  : _maxWindowOffset.dx / 6,
              right: _maxWindowOffset.dx / 10,
              height: _searchingBarHeight,
              duration: KCore.durationMilli300,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: KBorderRadius.allCircular_10,
                  color: _searchingColor,
                ),
                child: Focus(
                  child: SizedBox(
                    width: 50,
                    child: Padding(
                      padding: KEdgeInsets.onlyLeft_8,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "search",
                          icon: InkWell(
                            child: AnimatedOpacity(
                              opacity: _isExpand ? 1.0 : 0.0,
                              duration: KCore.durationMilli300,
                              child: WIconMaterial.arrowLeftward,
                            ),
                            onTap: () => setState(() {
                              if (_isExpand) {
                                _isExpand = false;
                                _searchingFocusNode.unfocus();
                              }

                              _pageColor = _pageColor;
                            }),
                          ),
                        ),
                        focusNode: _searchingFocusNode,
                      ),
                    ),
                  ),
                  onFocusChange: (hasFocus) {
                    if (hasFocus && !_isExpand) {
                      setState(() => _isExpand = true);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchingPage() => Container(
        padding: KEdgeInsets.symH_10,
        decoration: FDecorationBox.rectangle(
          borderRadius: KBorderRadius.allCircular_10,
        ),
        child: AnimatedOpacity(
          opacity: _isExpand ? 1.0 : 0.0,
          duration: KCore.durationMilli300,
          child: Container(
            decoration: FDecorationBox.rectangle(
              border: FBorderBox.sideSolidCenter(),
            ),
          ),
        ),
      );
}


// ///
// ///
// ///
// ///
// extension OperatorExtension on Operator {
//   static Column operationColumnForm({
//     MainAxisAlignment columnAlignment = MainAxisAlignment.center,
//     required Widget valueA,
//     required Icon operator,
//     required Widget valueB,
//     required Divider divider,
//     required Widget result,
//   }) =>
//       Column(
//         mainAxisAlignment: columnAlignment,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           valueA,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [operator, valueB],
//           ),
//           divider,
//           result,
//         ],
//       );
//
//   Widget formOfDoubleOperation(
//       double a,
//       double b, {
//         bool inColumnForm = true,
//         int fixed = 0,
//         TextStyle? textStyle,
//         Divider divider = WDivider.black_3,
//       }) =>
//       inColumnForm
//           ? operationColumnForm(
//         valueA: CustomText.ofDouble(a, fixed: fixed, style: textStyle),
//         operator: icon,
//         valueB: CustomText.ofDouble(b, fixed: fixed, style: textStyle),
//         divider: divider,
//         result: CustomText.ofDouble(
//           operateDouble(a, b),
//           fixed: fixed,
//           style: textStyle,
//         ),
//       )
//           : throw UnimplementedError();
//
//   Widget formOfDurationOperation(
//       Duration a,
//       Duration b, {
//         bool inColumnForm = true,
//         TextStyle? textStyle,
//         Divider divider = WDivider.black_3,
//       }) =>
//       inColumnForm
//           ? operationColumnForm(
//         valueA: CustomText.ofDuration(a, style: textStyle),
//         operator: icon,
//         valueB: CustomText.ofDuration(b, style: textStyle),
//         divider: divider,
//         result: CustomText.ofDuration(operateDuration(a, b),
//             style: textStyle),
//       )
//           : throw UnimplementedError();
// }