part of dapresent_custom;

///
/// this file contains:
/// [CustomCard]
/// [CustomListTile]
/// [CustomAnimatedListController]
///
/// [AnimatedListItemUpdateConsumer], [AnimatedListItemInsertConsumer]
/// [AnimatedListItemPlan]
/// [AnimatedListItemIndexCreator]
/// [AnimatedListModification], [AnimatedListItem]
///
/// [FListAnimatedItemBuilder], [FListAnimatedItemBuilder]
///
///
///
///

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.elevation,
    required this.child,
  });

  final double? elevation;
  final Widget child;

  factory CustomCard.iconText({
    double elevation = 5,
    GestureTapCallback onTap = FListener.none,
    required IconData icon,
    required String text,
  }) =>
      CustomCard(
        elevation: elevation,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(icon), Text(text)],
            ),
          ),
        ),
      );

  factory CustomCard.listTile({
    double? elevation,
    required CustomListTile listTile,
  }) =>
      CustomCard(
        elevation: elevation,
        child: listTile,
      );

  @override
  Widget build(BuildContext context) => Card(
        elevation: elevation,
        child: child,
      );
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final GestureTapCallback? onTap;

  factory CustomListTile.style1({
    required String title,
    required String subtitle,
    required GestureTapCallback onTap,
  }) =>
      CustomListTile(
        title: Center(child: Text(title)),
        subtitle: Text(subtitle),
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}

class CustomAnimatedListController extends StatefulWidget {
  const CustomAnimatedListController({
    required this.listKey,
    required this.modification,
    required this.list,
  }) : super(key: listKey);

  final GlobalKey<AnimatedListState> listKey;
  final AnimatedListModification modification;
  final List<AnimatedListItem> list;

  @override
  State<CustomAnimatedListController> createState() =>
      _CustomAnimatedListControllerState();
}

class _CustomAnimatedListControllerState
    extends State<CustomAnimatedListController> {
  AnimatedListState get listState => widget.listKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final modification = widget.modification;
    return AnimatedList(
      key: widget.key,
      initialItemCount: widget.list.length,
      itemBuilder: modification.itemPlan(
        items: widget.list,
        listState: listState,
        modification: modification,
      ),
    );
  }
}

typedef AnimatedListItemUpdateConsumer = void Function({
  required AnimatedItemBuilder? builder,
  required AnimatedListState listState,
  required List<AnimatedListItem> items,
  required int index,
});
typedef AnimatedListItemInsertConsumer = void Function({
  required AnimatedItemBuilder builder,
  required AnimatedListState listState,
  required List<AnimatedListItem> items,
  required AnimatedListItem item,
  required int index,
});

///
///
///
typedef AnimatedListItemPlan = AnimatedItemBuilder Function({
  required List<AnimatedListItem> items,
  required AnimatedListState listState,
  required AnimatedListModification modification,
});

///
/// others
///
typedef AnimatedListItemIndexCreator = int Function({
  required AnimatedItemBuilder? builder,
  required List<AnimatedListItem> items,
  required AnimatedListItem item,
});

class AnimatedListModification {
  final AnimatedListItemPlan itemPlan;
  final AnimatedListItemIndexCreator index;
  final AnimatedListItemInsertConsumer insert;
  final AnimatedListItemUpdateConsumer remove;
  final AnimatedListItemUpdateConsumer onTap;

  // final AnimatedListItemUpdate onDrag;
  // final AnimatedListItemUpdate onPress;
  // final AnimatedListItemUpdate onPressLong;

  const AnimatedListModification({
    this.itemPlan = FListAnimatedItemBuilder.plan1,
    this.index = FListAnimatedItemBuilder.listenIndex0,
    this.insert = FListAnimatedItemBuilder.listenInsert0,
    this.remove = FListAnimatedItemBuilder.listenRemove0,
    this.onTap = FListAnimatedItemBuilder.listenOnTap0,
  });

  static const instance = AnimatedListModification();
}

class AnimatedListItem {
  final String data;

  const AnimatedListItem({
    required this.data,
  });
}

///
/// 
/// 
/// [plan1], ...
/// [listenIndex0], ...
/// 
/// 
extension FListAnimatedItemBuilder on AnimatedItemBuilder {
  
  ///
  /// [plan1]
  /// [plan2]
  /// 
  static AnimatedItemBuilder plan1({
    required List<AnimatedListItem> items,
    required AnimatedListState listState,
    required AnimatedListModification modification,
  }) =>
      (context, index, animation) {
        final item = items[index];
        return Padding(
          padding: KEdgeInsets.all_1 * 3,
          child: SizeTransition(
            sizeFactor: animation,
            child: GestureDetector(
              onTap: () => modification.onTap(
                builder: null,
                listState: listState,
                items: items,
                index: index,
              ),
              child: SizedBox(
                height: 80.0,
                child: Card(
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Item $item',
                      style: context.theme.textTheme.headlineMedium!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      };

  static AnimatedItemBuilder plan2({
    required List<AnimatedListItem> items,
    required AnimatedListState listState,
    required AnimatedListModification setting,
  }) {
    Widget builder(
      BuildContext context,
      int index,
      Animation<double> animation,
    ) {
      return SizeTransition(
        sizeFactor: animation,
        child: Container(
          height: 48,
          decoration: FDecorationShape.stadiumBorder(
            side: FBorderSide.solidCenter(color: Colors.grey),
          ),
          clipBehavior: Clip.antiAlias,
          padding: KEdgeInsets.symV_8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: KEdgeInsets.onlyLeft_24,
                child: SizedBox(
                  width: 168,
                  child: Text(items[index].toString()),
                ),
              ),
              IconButton(
                onPressed: () => setting.remove(
                  builder: builder,
                  listState: listState,
                  items: items,
                  index: index,
                ),
                color: KColor.greenB1,
                icon: WIconMaterial.cancel_24,
                splashRadius: 20.0,
              ),
            ],
          ),
        ),
      );
    }

    return builder;
  }

  ///
  ///
  /// listen
  ///
  ///

  /// index style
  static int listenIndex0({
    required AnimatedItemBuilder? builder,
    required List<AnimatedListItem> items,
    required AnimatedListItem item,
  }) =>
      items.indexOf(item);

  /// insert style
  static void listenInsert0({
    required AnimatedItemBuilder builder,
    required AnimatedListState listState,
    required List<AnimatedListItem> items,
    required AnimatedListItem item,
    required int index,
  }) {
    items.insert(index, item);
    listState.insertItem(index);
  }

  /// remove style
  static void listenRemove0({
    required AnimatedItemBuilder? builder,
    required AnimatedListState listState,
    required List<AnimatedListItem> items,
    required int index,
  }) {
    try {
      final item = items[index];

      listState.removeItem(index, (context, animation) {
        void listener(AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            items.remove(item);
            animation.removeStatusListener(listener);
          }
        }

        animation.addStatusListener(listener);

        return builder == null
            ? Container()
            : builder(context, index, animation);
      });
    } catch (_) {
      throw UnimplementedError();
    }
  }

  /// onTap style
  static void listenOnTap0({
    required AnimatedItemBuilder? builder,
    required AnimatedListState listState,
    required List<AnimatedListItem> items,
    required int index,
  }) =>
      throw UnimplementedError();
}
