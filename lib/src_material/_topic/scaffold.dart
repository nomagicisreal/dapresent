part of dapresent_material;

///
/// this file contains:
///
/// [CustomDrawer]
/// [CustomBottomNavigationBar]
///
///

///
/// [CustomDrawer.style1]
///
/// tip: use [SizedBox] enclosing [CustomDrawer] to constraint the drawer's height
///
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    this.shape,
    required this.child,
  });

  final ShapeBorder? shape;
  final Widget child;

  factory CustomDrawer.style1({
    ShapeBorder? shape,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    BoxShape headerShape = BoxShape.rectangle,
    String headerSize = "400",
    required String title,
    required List<Widget> tiles,
  }) =>
      CustomDrawer(
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 50,
              child: Center(child: Text(title)),
            ),
            DrawerHeader(
              decoration: BoxDecoration(
                shape: headerShape,
                image: DecorationImage(
                  image:
                      Image.network('https://picsum.photos/$headerSize').image,
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(),
            ),
            Padding(
              padding: padding,
              child: Column(
                children: tiles,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: shape,
      child: child,
    );
  }
}

///
///
///
/// [CustomBottomNavigationBar]
///
///
///
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    this.iconSize = 30,
  });

  final double iconSize;
  final List<BottomNavigationBarItem> items;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: widget.iconSize,
      backgroundColor: Colors.green,
      selectedFontSize: Theme.of(context).textTheme.titleMedium!.fontSize!,
      currentIndex: _bottomNavIndex,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      items: widget.items,
    );
  }
}
