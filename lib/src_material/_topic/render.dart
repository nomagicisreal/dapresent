part of dapresent_material;

///
/// this file contains:
/// [RenderSizing], [RenderPainting]
/// [BagList], [BagMap]
///
///
///
///
///

typedef RenderPainting = void Function(PaintingContext context, Offset offset);
typedef RenderSizing = Mapper<BoxConstraints, Size>;

class BagRenderObject extends RenderBox {
  BagRenderObject(this._sizing, this._painting);

  RenderSizing _sizing;
  RenderPainting _painting;

  RenderSizing get sizing => _sizing;

  RenderPainting get painting => _painting;

  set sizing(RenderSizing val) {
    if (_sizing == val) return;
    _sizing = val;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  set painting(RenderPainting val) {
    if (_painting == val) return;
    _painting = val;
    markNeedsLayout();
  }

  @override
  void performLayout() => size = _sizing(constraints);

  @override
  void paint(PaintingContext context, Offset offset) =>
      _painting(context, offset);
}

class BagList<T> extends LeafRenderObjectWidget {
  const BagList(
      this.items, {
        super.key,
        required this.sizing,
        required this.painting,
      });

  final List<T> items;
  final Mapper<List<T>, RenderSizing> sizing;
  final Mapper<List<T>, RenderPainting> painting;

  @override
  BagRenderObject createRenderObject(BuildContext context) =>
      BagRenderObject(sizing(items), painting(items));

  @override
  void updateRenderObject(BuildContext context, BagRenderObject renderObject) =>
      renderObject
        ..sizing = sizing(items)
        ..painting = painting(items);
}

class BagMap<K, V> extends LeafRenderObjectWidget {
  const BagMap(
      this.items, {
        super.key,
        required this.sizing,
        required this.painting,
      });

  final Map<K, V> items;
  final Mapper<Map<K, V>, RenderSizing> sizing;
  final Mapper<Map<K, V>, RenderPainting> painting;

  @override
  BagRenderObject createRenderObject(BuildContext context) =>
      BagRenderObject(sizing(items), painting(items));

  @override
  void updateRenderObject(BuildContext context, BagRenderObject renderObject) =>
      renderObject
        ..sizing = sizing(items)
        ..painting = painting(items);
}
