///
///
/// this file contains:
/// [ColorPalette7]
/// [KTextStyle]
///
///
part of dapresent_custom;


extension BuildContextPreference on BuildContext {
  Preference get preference => findAncestorWidgetOfExactType()!;
}

///
///
///
class Preference extends StatelessWidget {
  const Preference({
    super.key,
    this.colorPalette7 = ColorPalette7.red,
    required this.child,
  });

  final ColorPalette7 colorPalette7;
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

///
///
/// [bright1], [bright2], [bright3]
/// [primary]
/// [dark1], [dark2], [dark3]
///
///
enum ColorPalette7 {
  red,
  green,
  blue,
  orange,
  yellow,
  purple;

  ///
  ///
  /// colors
  ///
  ///

  // R
  static const _redB1 = Color(0xFFffdddd);
  static const _redB2 = Color(0xFFeecccc);
  static const _redB3 = Color(0xFFdd9999);
  static const _redPrimary = Color(0xFFdd7777);
  static const _redD3 = Color(0xFFbb4444);
  static const _redD2 = Color(0xFFaa1111);
  static const _redD1 = Color(0xFF880000);

  // G
  static const _greenB1 = Color(0xFFddffdd);
  static const _greenB2 = Color(0xFFcceecc);
  static const _greenB3 = Color(0xFFaaddaa);
  static const _greenPrimary = Color(0xFF88aa88);
  static const _greenD3 = Color(0xFF559955);
  static const _greenD2 = Color(0xFF227722);
  static const _greenD1 = Color(0xFF005500);

  // B
  static const _blueB1 = Color(0xFFddddff);
  static const _blueB2 = Color(0xFFbbbbee);
  static const _blueB3 = Color(0xFF8888dd);
  static const _bluePrimary = Color(0xFF6666cc);
  static const _blueD3 = Color(0xFF4444bb);
  static const _blueD2 = Color(0xFF222288);
  static const _blueD1 = Color(0xFF111155);

  // oranges that G over B oranges
  static const _orangeB1 = Color(0xFFffeecc);
  static const _orangeB2 = Color(0xFFffccaa);
  static const _orangeB3 = Color(0xFFeeaa88);
  static const _orangePrimary = Color(0xFFcc8866);
  static const _orangeD3 = Color(0xFFaa5533);
  static const _orangeD2 = Color(0xFF773322);
  static const _orangeD1 = Color(0xFF551100);

  // yellows that R over G
  static const _yellowB1 = Color(0xFFffffbb);
  static const _yellowB2 = Color(0xFFeedd99);
  static const _yellowB3 = Color(0xFFddcc66);
  static const _yellowPrimary = Color(0xffccbb22);
  static const _yellowD3 = Color(0xFFccbb33);
  static const _yellowD2 = Color(0xFFbbaa22);
  static const _yellowD1 = Color(0xFF998811);

  // static const _yellowB1_1 = Color(0xFFeeeeaa);

  // purples that B over R
  static const _purpleB1 = Color(0xFFeeccff);
  static const _purpleB2 = Color(0xFFddbbee);
  static const _purpleB3 = Color(0xFFaa88dd);
  static const _purplePrimary = Color(0xff8866cc);
  static const _purpleD3 = Color(0xFF8844bb);
  static const _purpleD2 = Color(0xFF6622aa);
  static const _purpleD1 = Color(0xFF440099);

  // static const _purpleB4 = Color(0xFF9977cc);

  ///
  ///
  ///
  /// getters
  /// notice that colors on side panel in android studio are not the actual color,
  ///
  ///
  ///
  Color get bright1 => switch (this) {
        ColorPalette7.red => _redB1,
        ColorPalette7.green => _greenB1,
        ColorPalette7.blue => _blueB1,
        ColorPalette7.orange => _orangeB1,
        ColorPalette7.yellow => _yellowB1,
        ColorPalette7.purple => _purpleB1,
      };

  Color get bright2 => switch (this) {
        ColorPalette7.red => _redB2,
        ColorPalette7.green => _greenB2,
        ColorPalette7.blue => _blueB2,
        ColorPalette7.orange => _orangeB2,
        ColorPalette7.yellow => _yellowB2,
        ColorPalette7.purple => _purpleB2,
      };

  Color get bright3 => switch (this) {
        ColorPalette7.red => _redB3,
        ColorPalette7.green => _greenB3,
        ColorPalette7.blue => _blueB3,
        ColorPalette7.orange => _orangeB3,
        ColorPalette7.yellow => _yellowB3,
        ColorPalette7.purple => _purpleB3,
      };

  Color get primary => switch (this) {
        ColorPalette7.red => _redPrimary,
        ColorPalette7.green => _greenPrimary,
        ColorPalette7.blue => _bluePrimary,
        ColorPalette7.orange => _orangePrimary,
        ColorPalette7.yellow => _yellowPrimary,
        ColorPalette7.purple => _purplePrimary,
      };

  Color get dark1 => switch (this) {
        ColorPalette7.red => _redD1,
        ColorPalette7.green => _greenD1,
        ColorPalette7.blue => _blueD1,
        ColorPalette7.orange => _orangeD1,
        ColorPalette7.yellow => _yellowD1,
        ColorPalette7.purple => _purpleD1,
      };

  Color get dark2 => switch (this) {
        ColorPalette7.red => _redD2,
        ColorPalette7.green => _greenD2,
        ColorPalette7.blue => _blueD2,
        ColorPalette7.orange => _orangeD2,
        ColorPalette7.yellow => _yellowD2,
        ColorPalette7.purple => _purpleD2,
      };

  Color get dark3 => switch (this) {
        ColorPalette7.red => _redD3,
        ColorPalette7.green => _greenD3,
        ColorPalette7.blue => _blueD3,
        ColorPalette7.orange => _orangeD3,
        ColorPalette7.yellow => _yellowD3,
        ColorPalette7.purple => _purpleD3,
      };
}

// ///
// ///
// extension KTextStyle on TextStyle {
//   static const size_10 = TextStyle(fontSize: 10);
//   static const size_20 = TextStyle(fontSize: 20);
//   static const size_30 = TextStyle(fontSize: 30);
//   static const size_40 = TextStyle(fontSize: 40);
//   static const size_50 = TextStyle(fontSize: 50);
//   static const white = TextStyle(color: Colors.white);
//   static const black = TextStyle(color: Colors.black);
//   static const black12 = TextStyle(color: Colors.black12);
//   static const black26 = TextStyle(color: Colors.black26);
//   static const black38 = TextStyle(color: Colors.black38);
//   static const black45 = TextStyle(color: Colors.black45);
//   static const black54 = TextStyle(color: Colors.black54);
//   static const black87 = TextStyle(color: Colors.black87);
//
//   static const white_24 = TextStyle(color: Colors.white, fontSize: 24);
//   static const white_28 = TextStyle(color: Colors.white, fontSize: 28);
//   static const boldWhite = TextStyle(
//     fontWeight: FontWeight.bold,
//     color: Colors.white,
//   );
//   static const boldBlack = TextStyle(
//     fontWeight: FontWeight.bold,
//     color: Colors.black,
//   );
//
//   static const boldBlack_30 = TextStyle(
//     fontWeight: FontWeight.bold,
//     color: Colors.black,
//     fontSize: 30,
//   );
//
//   static const italicGrey_12 = TextStyle(
//     fontStyle: FontStyle.italic,
//     color: Colors.grey,
//     fontSize: 12,
//   );
// }
