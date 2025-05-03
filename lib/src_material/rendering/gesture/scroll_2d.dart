part of '../rendering.dart';

// ///
// /// this file contains:
// ///
// ///
// /// next: reference to table view, with table header and cell
// ///
// /// widgets:
// /// [Scrolling2DView]
// ///   * [Viewport2DSetting]
// ///   * [Viewport2DConfiguration]
// ///   [_Viewport2D]
// ///     [_Viewport2DRender]
// ///
// /// [FLoop]
// /// [_TwoDimensionalChildBuilderDelegateExtension]
// ///
// ///
//
// typedef TwoDimensionalSequencer = void Function(
//   ViewportOffset verticalOffset,
//   ViewportOffset horizontalOffset,
//   Size viewportSize,
//   TwoDimensionalItemListener listener,
// );
//
// typedef TwoDimensionalItemListener = void Function(
//   int column,
//   int row,
//   double x,
//   double y,
// );
//
// class Scrolling2DView extends TwoDimensionalScrollView {
//   final Viewport2DConfiguration configuration;
//
//   Scrolling2DView({
//     super.key,
//     required this.configuration,
//     super.primary,
//     super.mainAxis = Axis.vertical,
//     super.verticalDetails = const ScrollableDetails.vertical(),
//     super.horizontalDetails = const ScrollableDetails.horizontal(),
//     super.diagonalDragBehavior = DiagonalDragBehavior.free,
//     super.dragStartBehavior = DragStartBehavior.start,
//     super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
//     super.cacheExtent,
//     super.clipBehavior = Clip.hardEdge,
//   }) : super(delegate: configuration.delegate);
//
//   static Widget get sampleWidget => Scrolling2DView(
//         configuration: Viewport2DConfiguration.gridSquareDistanced(
//           dimension: 200,
//           dimensionD: 20,
//           from: (dimension) => TwoDimensionalChildBuilderDelegate(
//             maxXIndex: 9,
//             maxYIndex: 9,
//             builder: (context, vicinity) => Container(
//               color: vicinity.xIndex.isEven && vicinity.yIndex.isEven
//                   ? Colors.amber[50]
//                   : (vicinity.xIndex.isOdd && vicinity.yIndex.isOdd
//                       ? Colors.purple[50]
//                       : null),
//               height: dimension,
//               width: dimension,
//               child: Center(
//                 child: Text(
//                   'Row ${vicinity.yIndex}: '
//                   'Column ${vicinity.xIndex}',
//                 ),
//               ),
//             ),
//           ),
//           itemConstraints: (constraints) => constraints.loosen(),
//         ),
//       );
//
//   @override
//   Widget buildViewport(
//     BuildContext context,
//     ViewportOffset verticalOffset,
//     ViewportOffset horizontalOffset,
//   ) =>
//       _Viewport2D(
//         setting: Viewport2DSetting._(
//           mainAxis: mainAxis,
//           verticalOffset: verticalOffset,
//           verticalAxisDirection: verticalDetails.direction,
//           horizontalOffset: horizontalOffset,
//           horizontalAxisDirection: horizontalDetails.direction,
//           cacheExtent: cacheExtent,
//           clipBehavior: clipBehavior,
//         ),
//         configuration: configuration,
//       );
// }
//
// ///
// ///
// ///
// ///
// ///
// /// viewport
// ///
// ///
// ///
// ///
// ///
//
// class Viewport2DSetting {
//   final Axis mainAxis;
//   final ViewportOffset verticalOffset;
//   final AxisDirection verticalAxisDirection;
//   final ViewportOffset horizontalOffset;
//   final AxisDirection horizontalAxisDirection;
//   final Clip clipBehavior;
//   final double? cacheExtent;
//
//   const Viewport2DSetting._({
//     required this.mainAxis,
//     required this.verticalOffset,
//     required this.verticalAxisDirection,
//     required this.horizontalOffset,
//     required this.horizontalAxisDirection,
//     required this.cacheExtent,
//     required this.clipBehavior,
//   });
//
//   const Viewport2DSetting({
//     required this.mainAxis,
//     required this.verticalOffset,
//     required this.verticalAxisDirection,
//     required this.horizontalOffset,
//     required this.horizontalAxisDirection,
//     this.cacheExtent,
//     this.clipBehavior = Clip.hardEdge,
//   });
// }
//
// ///
// ///
// ///
// /// [forTableSquare]
// ///
// /// [Viewport2DConfiguration.gridSquare]
// ///
// ///
// ///
// class Viewport2DConfiguration {
//   final Size extent;
//   final TwoDimensionalChildBuilderDelegate delegate;
//   final Applier<BoxConstraints> itemConstraints;
//
//   ///
//   /// see [_Viewport2DRender.layoutChildSequence] for implementation
//   ///
//   final TwoDimensionalSequencer _sequenceBy;
//
//   const Viewport2DConfiguration._({
//     required this.extent,
//     required this.delegate,
//     required this.itemConstraints,
//     required TwoDimensionalSequencer sequenceBy,
//   }) : _sequenceBy = sequenceBy;
//
//   factory Viewport2DConfiguration.gridSquare({
//     required double dimension,
//     required Mapper<double, TwoDimensionalChildBuilderDelegate> from,
//     required Applier<BoxConstraints> itemConstraints,
//   }) {
//     final delegate = from(dimension);
//     final int maxColumnIndex = delegate.maxXIndex!;
//     final int maxRowIndex = delegate.maxYIndex!;
//
//     return Viewport2DConfiguration._(
//       extent: delegate.extent(Offset(dimension, dimension)),
//       delegate: delegate,
//       itemConstraints: itemConstraints,
//       sequenceBy: (
//         ViewportOffset verticalOffset,
//         ViewportOffset horizontalOffset,
//         Size viewportSize,
//         TwoDimensionalItemListener listener,
//       ) {
//         final double hPixels = horizontalOffset.pixels;
//         final double vPixels = verticalOffset.pixels;
//         final int columnStart = math.max((hPixels / dimension).floor(), 0);
//         final int rowStart = math.max((vPixels / dimension).floor(), 0);
//
//         FLoop.forTableSquare(
//           (columnStart * dimension) - hPixels,
//           (rowStart * dimension) - vPixels,
//           d: dimension,
//           columnStart: columnStart,
//           columnEnd: math.min(
//             ((hPixels + viewportSize.width) / dimension).ceil(),
//             maxColumnIndex,
//           ),
//           rowStart: rowStart,
//           rowEnd: math.min(
//             ((vPixels + viewportSize.height) / dimension).ceil(),
//             maxRowIndex,
//           ),
//           listener: listener,
//         );
//       },
//     );
//   }
//
//   factory Viewport2DConfiguration.gridSquareDistanced({
//     required double dimension,
//     required double dimensionD,
//     required Mapper<double, TwoDimensionalChildBuilderDelegate> from,
//     required Applier<BoxConstraints> itemConstraints,
//   }) {
//     final delegate = from(dimension);
//     final int maxColumnIndex = delegate.maxXIndex!;
//     final int maxRowIndex = delegate.maxYIndex!;
//     final d = dimension + dimensionD;
//
//     return Viewport2DConfiguration._(
//       extent: delegate.extentWithDistance(
//         Offset(dimension, dimension),
//         Offset(dimensionD, dimensionD),
//       ),
//       delegate: delegate,
//       itemConstraints: itemConstraints,
//       sequenceBy: (
//         ViewportOffset verticalOffset,
//         ViewportOffset horizontalOffset,
//         Size viewportSize,
//         TwoDimensionalItemListener listener,
//       ) {
//         final double hPixels = horizontalOffset.pixels;
//         final double vPixels = verticalOffset.pixels;
//         final int columnStart = math.max((hPixels / d).floor(), 0);
//         final int rowStart = math.max((vPixels / d).floor(), 0);
//
//         FLoop.forTableSquareDistanced(
//           (columnStart * d) - hPixels,
//           (rowStart * d) - vPixels,
//           d: dimension,
//           dDistance: dimensionD,
//           columnStart: columnStart,
//           columnEnd: math.min(
//             ((hPixels + viewportSize.width) / dimension).ceil(),
//             maxColumnIndex,
//           ),
//           rowStart: rowStart,
//           rowEnd: math.min(
//             ((vPixels + viewportSize.height) / dimension).ceil(),
//             maxRowIndex,
//           ),
//           listener: listener,
//         );
//       },
//     );
//   }
// }
//
// class _Viewport2D extends TwoDimensionalViewport {
//   final Viewport2DConfiguration configuration;
//
//   _Viewport2D({
//     required this.configuration,
//     required Viewport2DSetting setting,
//   }) : super(
//           delegate: configuration.delegate,
//           mainAxis: setting.mainAxis,
//           verticalOffset: setting.verticalOffset,
//           verticalAxisDirection: setting.verticalAxisDirection,
//           horizontalOffset: setting.horizontalOffset,
//           horizontalAxisDirection: setting.horizontalAxisDirection,
//           cacheExtent: setting.cacheExtent,
//           clipBehavior: setting.clipBehavior,
//         );
//
//   @override
//   RenderTwoDimensionalViewport createRenderObject(BuildContext context) =>
//       _Viewport2DRender(
//         configuration: configuration,
//         setting: Viewport2DSetting._(
//           mainAxis: mainAxis,
//           verticalOffset: verticalOffset,
//           verticalAxisDirection: verticalAxisDirection,
//           horizontalOffset: horizontalOffset,
//           horizontalAxisDirection: horizontalAxisDirection,
//           cacheExtent: cacheExtent,
//           clipBehavior: clipBehavior,
//         ),
//         childManager: context as TwoDimensionalChildManager,
//       );
//
//   @override
//   void updateRenderObject(
//     BuildContext context,
//     _Viewport2DRender renderObject,
//   ) =>
//       renderObject
//         ..configuration = configuration
//         ..delegate = delegate
//         ..mainAxis = mainAxis
//         ..horizontalOffset = horizontalOffset
//         ..horizontalAxisDirection = horizontalAxisDirection
//         ..verticalOffset = verticalOffset
//         ..verticalAxisDirection = verticalAxisDirection
//         ..cacheExtent = cacheExtent
//         ..clipBehavior = clipBehavior;
// }
//
// class _Viewport2DRender extends RenderTwoDimensionalViewport {
//   Viewport2DConfiguration configuration;
//
//   _Viewport2DRender({
//     required this.configuration,
//     required Viewport2DSetting setting,
//     required super.childManager,
//   }) : super(
//           delegate: configuration.delegate,
//           mainAxis: setting.mainAxis,
//           verticalOffset: setting.verticalOffset,
//           verticalAxisDirection: setting.verticalAxisDirection,
//           horizontalOffset: setting.horizontalOffset,
//           horizontalAxisDirection: setting.horizontalAxisDirection,
//           cacheExtent: setting.cacheExtent,
//           clipBehavior: setting.clipBehavior,
//         );
//
//   TwoDimensionalItemListener listenerOf(BoxConstraints constraints) =>
//       (column, row, x, y) {
//         final renderBox = buildOrObtainChildFor(
//           ChildVicinity(xIndex: column, yIndex: row),
//         )!;
//         renderBox.layout(constraints);
//         parentDataOf(renderBox).layoutOffset = Offset(x, y);
//       };
//
//   @override
//   void layoutChildSequence() {
//     configuration._sequenceBy(
//       verticalOffset,
//       horizontalOffset,
//       viewportDimension + Offset(cacheExtent, cacheExtent),
//       listenerOf(configuration.itemConstraints(constraints)),
//     );
//
//     final extent = configuration.extent;
//     verticalOffset.applyContentDimensions(
//       0.0,
//       (extent.height - viewportDimension.height).clampPositive,
//     );
//     horizontalOffset.applyContentDimensions(
//       0.0,
//       (extent.width - viewportDimension.width).clampPositive,
//     );
//   }
// }
//
// ///
// /// [forTable]
// /// [forTableDistanced]
// /// [forTableSquare]
// /// [forTableSquareDistanced]
// ///
// ///
// extension FLoop on Object {
//   static void forTable(
//     double xStart,
//     double yStart, {
//     required double dx,
//     required double dy,
//     required int columnStart,
//     required int columnEnd,
//     required int rowStart,
//     required int rowEnd,
//     required TwoDimensionalItemListener listener,
//   }) {
//     double x = xStart;
//     for (int column = columnStart; column <= columnEnd; column++) {
//       double y = yStart;
//       for (int row = rowStart; row <= rowEnd; row++) {
//         listener(column, row, x, y);
//         y += dy;
//       }
//       x += dx;
//     }
//   }
//
//   static void forTableDistanced(
//     double xStart,
//     double yStart, {
//     required double dx,
//     required double dy,
//     required double distanceX,
//     required double distanceY,
//     required int columnStart,
//     required int columnEnd,
//     required int rowStart,
//     required int rowEnd,
//     required TwoDimensionalItemListener listener,
//   }) {
//     final columnInterval = columnEnd - columnStart;
//     final rowInterval = rowEnd - rowStart;
//     final columnMax = columnEnd + columnInterval;
//     final rowMax = rowEnd + rowInterval;
//
//     // if columns/row are in odd -> should skip column in even
//     // if columns/row are in even -> should skip column in odd
//     final columnShouldSkip = FMapper.oddOrEvenCheckerOpposite(columnStart);
//     final rowShouldSkip = FMapper.oddOrEvenCheckerOpposite(rowStart);
//
//     double x = xStart;
//     int columnDistanceCount = 0;
//     for (int column = columnStart; column <= columnMax; column++) {
//       if (columnShouldSkip(column)) {
//         columnDistanceCount++;
//         x += distanceX;
//         continue;
//       }
//
//       double y = yStart;
//       int rowDistanceCount = 0;
//       for (int row = rowStart; row <= rowMax; row++) {
//         if (rowShouldSkip(row)) {
//           rowDistanceCount++;
//           y += distanceY;
//           continue;
//         }
//
//         listener(column - columnDistanceCount, row - rowDistanceCount, x, y);
//         y += dy;
//       }
//       x += dx;
//     }
//   }
//
//   static void forTableSquare(
//     double xStart,
//     double yStart, {
//     required double d,
//     required int columnStart,
//     required int columnEnd,
//     required int rowStart,
//     required int rowEnd,
//     required TwoDimensionalItemListener listener,
//   }) =>
//       forTable(
//         xStart,
//         yStart,
//         dx: d,
//         dy: d,
//         columnStart: columnStart,
//         columnEnd: columnEnd,
//         rowStart: rowStart,
//         rowEnd: rowEnd,
//         listener: listener,
//       );
//
//   static void forTableSquareDistanced(
//     double xStart,
//     double yStart, {
//     required double d,
//     required double dDistance,
//     required int columnStart,
//     required int columnEnd,
//     required int rowStart,
//     required int rowEnd,
//     required TwoDimensionalItemListener listener,
//   }) =>
//       forTableDistanced(
//         xStart,
//         yStart,
//         dx: d,
//         dy: d,
//         distanceX: dDistance,
//         distanceY: dDistance,
//         columnStart: columnStart,
//         columnEnd: columnEnd,
//         rowStart: rowStart,
//         rowEnd: rowEnd,
//         listener: listener,
//       );
// }
//
// extension _TwoDimensionalChildBuilderDelegateExtension
//     on TwoDimensionalChildBuilderDelegate {
//   int get xLength {
//     final x = maxXIndex;
//     return x == null ? 0 : x + 1;
//   }
//
//   int get yLength {
//     final y = maxYIndex;
//     return y == null ? 0 : y + 1;
//   }
//
//   Size extent(Offset dimension) => Size(
//         dimension.dx * xLength,
//         dimension.dy * yLength,
//       );
//
//   Size extentWithDistance(Offset dimension, Offset dimensionD) {
//     final xLength = this.xLength;
//     final yLength = this.yLength;
//     return Size(
//       dimension.dx * xLength + dimensionD.dx * (xLength - 1),
//       dimension.dy * yLength + dimensionD.dy * (yLength - 1),
//     );
//   }
// }
