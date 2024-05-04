///
///
/// this file contains:
///
/// extensions:
/// [BuildContextCustom]
///
/// widget:
/// [CustomMaterialApp]
///
///
part of dapresent_material;

///
/// [appMaterial]
///
extension BuildContextCustom on BuildContext {
  CustomMaterialAppState get appMaterial => CustomMaterialApp.of(this)!;
}

extension StateExtension<T extends StatefulWidget> on State<T> {
  VoidCallback listenSetStateOf(VoidCallback listener) =>
      // ignore: invalid_use_of_protected_member
      () => setState(listener);
}

///
///
///
class CustomMaterialApp extends StatefulWidget {
  const CustomMaterialApp({
    super.key,
    this.color = KColor.purpleB3,
    required this.home,
  });

  final Color color;
  final Widget home;

  @override
  State<CustomMaterialApp> createState() => CustomMaterialAppState();

  static CustomMaterialAppState? of(BuildContext context) =>
      context.findAncestorStateOfType();
}

class CustomMaterialAppState extends State<CustomMaterialApp> {
  late Color _color;
  late ColorScheme _colorScheme;

  Color get color => _color;

  ColorScheme get colorScheme => _colorScheme;

  set color(Color value) => setState(() => _color = value);

  set colorScheme(ColorScheme value) => setState(() => _colorScheme = value);

  @override
  void initState() {
    _color = widget.color;
    _colorScheme = ColorScheme.fromSeed(seedColor: _color);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: _color,
      theme: ThemeData(
        colorScheme: _colorScheme,
      ),
      home: widget.home,
    );
  }
}
