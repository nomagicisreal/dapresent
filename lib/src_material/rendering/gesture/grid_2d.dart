part of '../rendering.dart';

// ///
// /// this file contains,
// ///
// /// class, enum:
// /// [GraphData]
// /// [GraphFormat]
// /// [GraphConfiguration]
// ///
// /// typedefs:
// /// [GridItemBuilder]
// /// [GridItemDistanceBuilder]
// /// [GridItemCornerBuilder]
// ///
// ///
//
// /// graph data is a class that help creating [Graph]
// class GraphData {
//   final GraphFormat format;
//   final GraphConfiguration configuration;
//
//   /// [gridItemsBoundary] must be in, be positive, for example
//   ///
//   /// gridItemsBoundary = 1 means (1 * 1) map
//   /// gridItemsBoundary = 2 means (2 * 2) map
//   /// gridItemsBoundary = 3 means (3 * 3) map
//   /// ...
//   ///
//   final Point3? gridItemsBoundary;
//
//   /// [gridMapBorder] = [] mAmBmCmD = [] ABCD * 4
//   ///
//   /// mA---------------mB
//   /// |        \        |
//   /// |     A--\--B     |
//   /// |     |  \  |     |
//   /// ---------O--------|
//   /// |     |  \  |     |
//   /// |     C--\--D     |
//   /// |        \        |
//   /// mC---------------mD
//   ///
//   /// if there is no more functions on map,
//   /// the additional border can be used to ensure displaying background color after slide transition; for example,
//   /// clicking MapItem that stay at A point will trigger slide transition,
//   /// 1. D to mD
//   /// 2. O to D
//   /// 3. A to O
//   ///
//   Point3? get gridMapBorder => _gridBorderIsItemBorder
//       ? GraphConfiguration.grid._mapBorder(
//           gridItemsBoundary: gridItemsBoundary,
//           gridItemBorder: _gridBorder,
//           gridItemDistance: gridItemDistance)
//       : _gridBorder;
//
//   ///  [gridItemBorder], [gridItemDistance]
//   ///
//   ///  -------------------------------------------
//   ///  |                    gridItemBorder.x    |
//   ///  |   gridItemBorder.y        V            |
//   ///  |    |    ---------     ---------         |
//   ///  |    |    |       |     |       |         |
//   ///  |    ---->| itemA |     | itemB |         |
//   ///  |         |       |     |       |         |
//   ///  |         ---------     ---------         |
//   ///  |                                 <------------ gridItemDistance.y
//   ///  |         ---------     ---------         |
//   ///  |         |       |     |       |         |
//   ///  |         | itemC |     | itemD |         |
//   ///  |         |       |     |       |         |
//   ///  |         ---------     ---------         |
//   ///  |                    ^                <------------ gridItemCorner
//   ///  -------------------- | --------------------
//   ///                       |
//   ///               gridItemDistance.x
//   ///
//   /// [_gridBorder] and [_gridBorderIsItemBorder] simplify the map creation, see [MapData.grid]
//   ///
//   final Point3? _gridBorder;
//   final bool _gridBorderIsItemBorder;
//   final Point3? gridItemDistance;
//
//   Point3? get gridItemBorder => _gridBorderIsItemBorder
//       ? _gridBorder
//       : GraphConfiguration.grid._itemBorder(
//           gridItemsBoundary: gridItemsBoundary,
//           gridMapBorder: _gridBorder,
//           gridItemDistance: gridItemDistance);
//
//   final GridItemBuilder? gridItemsBuilder;
//   final GridItemDistanceBuilder? gridItemDistanceBuilder;
//   final GridItemCornerBuilder? gridItemCornerBuilder;
//
//   const GraphData.grid({
//     required Point3 gridBorder,
//     required bool gridBorderIsItemBorder,
//     required Point3 this.gridItemsBoundary,
//     required Point3 this.gridItemDistance,
//     required GridItemBuilder this.gridItemsBuilder,
//     required GridItemDistanceBuilder this.gridItemDistanceBuilder,
//     required GridItemCornerBuilder this.gridItemCornerBuilder,
//   })  : format = GraphFormat.animatedContainer,
//         configuration = GraphConfiguration.grid,
//         _gridBorder = gridBorder,
//         _gridBorderIsItemBorder = gridBorderIsItemBorder;
//
//   ///
//   /// validate all the builders,
//   ///
//   /// because that come from other [StatefulWidget]
//   ///
//   Widget validate(Widget widget) {
//     if (configuration == GraphConfiguration.grid) {
//       assert(true);
//     }
//
//     return widget;
//   }
// }
//
// class Graph extends StatelessWidget {
//   const Graph({
//     super.key,
//     required this.data,
//   });
//
//   final GraphData data;
//
//   @override
//   Widget build(BuildContext context) {
//     switch (data.configuration) {
//       case GraphConfiguration.grid:
//         // Point3s
//         final graphBorder = data.gridMapBorder!;
//         final itemsBoundary = data.gridItemsBoundary!;
//         final itemBorder = data.gridItemBorder!;
//         final distance = data.gridItemDistance!;
//
//         // builders
//         final itemBuilder = data.gridItemsBuilder!;
//         final distanceBuilder = data.gridItemDistanceBuilder!;
//         final cornerBuilder = data.gridItemCornerBuilder!;
//
//         final itemConstraint = BoxConstraints.tightFor(
//           height: itemBorder.y,
//           width: itemBorder.x,
//         );
//         final distanceConstraintHorizontal = BoxConstraints.tightFor(
//           height: itemBorder.y,
//           width: distance.x,
//         );
//         final distanceConstraintVertical = BoxConstraints.tightFor(
//           height: distance.y,
//           width: distance.x,
//         );
//
//         // final cornerConstraint = BoxConstraints.tightFor(
//         //   height: distance.y,
//         //   width: distance.x,
//         // );
//
//         return SizedBox(
//           width: graphBorder.x,
//           height: graphBorder.y,
//           child: Column(
//             children: WSizedBox.sandwich(
//               // breadConstraints: BoxConstraints.tightFor(
//               //   width: graphBorder.x,
//               //   height: itemBorder.y,
//               // ),
//               // meatConstraints: BoxConstraints.tightFor(
//               //   width: graphBorder.x,
//               //   height: distance.y,
//               // ),
//               breadCount: itemsBoundary.y.toInt(),
//               bread: (y) => Row(
//                 children: WWidgetBuilder.sandwich(
//                   // breadConstraints: itemConstraint,
//                   // meatConstraints: distanceConstraintHorizontal,
//                   breadCount: itemsBoundary.x.toInt(),
//                   bread: (x) => data.validate(itemBuilder(
//                     itemConstraint,
//                     Offset((x + 1), (y + 1)),
//                   )),
//                   meat: (x) => data.validate(distanceBuilder(
//                     distanceConstraintHorizontal,
//                     Offset((x + 1), (y + 1)),
//                     Offset((x + 2), (y + 1)),
//                   )),
//                 ),
//               ),
//               meat: (y) => Row(
//                 children: WWidgetBuilder.sandwich(
//                   // breadConstraints: distanceConstraintVertical,
//                   // meatConstraints: cornerConstraint,
//                   breadCount: itemsBoundary.x.toInt(),
//                   bread: (x) => data.validate(distanceBuilder(
//                     distanceConstraintVertical,
//                     Offset((x + 1), (y + 1)),
//                     Offset((x + 1), (y + 2)),
//                   )),
//                   meat: (x) => data.validate(cornerBuilder(
//                     distanceConstraintVertical,
//                     Offset((x + 1), (y + 1)),
//                     Offset((x + 1), (y + 2)),
//                     Offset((x + 2), (y + 1)),
//                     Offset((x + 2), (y + 2)),
//                   )),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//   }
// }
//
// /// graph format
// ///
// /// [PlaneConfiguration] is difference from [PlanesFormat];
// /// this represent the "graph style", while that focus on the items configuration on each graph
// ///
// enum GraphFormat {
//   animatedContainer,
// }
//
// /// graph configuration
// ///
// /// [GraphFormat] is difference from [GraphConfiguration];
// /// this focus on the items configuration on each graph, while that represent the "graph style"
// ///
// enum GraphConfiguration {
//   grid;
//
//   Point3 _mapBorder({
//     required Point3? gridItemsBoundary,
//     required Point3? gridItemBorder,
//     required Point3? gridItemDistance,
//   }) {
//     switch (this) {
//       // grid
//       case GraphConfiguration.grid:
//         assert(gridItemsBoundary != null &&
//             gridItemBorder != null &&
//             gridItemDistance != null);
//
//         double calculate(double boundary, double item, double distance) =>
//             (item + distance) * boundary - distance;
//
//         return Point3(
//           calculate(
//             gridItemsBoundary!.x,
//             gridItemBorder!.x,
//             gridItemDistance!.x,
//           ),
//           calculate(
//             gridItemsBoundary.y,
//             gridItemBorder.y,
//             gridItemDistance.y,
//           ),
//           calculate(
//             gridItemsBoundary.z,
//             gridItemBorder.z,
//             gridItemDistance.z,
//           ),
//         );
//     }
//   }
//
//   Point3 _itemBorder({
//     required Point3? gridItemsBoundary,
//     required Point3? gridMapBorder,
//     required Point3? gridItemDistance,
//   }) {
//     switch (this) {
//       // grid
//       case GraphConfiguration.grid:
//         assert(gridItemsBoundary != null &&
//             gridMapBorder != null &&
//             gridItemDistance != null);
//
//         double calculate(double map, double boundary, double distance) =>
//             (map + distance) / boundary - distance;
//
//         return Point3(
//           calculate(
//               gridMapBorder!.x, gridItemsBoundary!.x, gridItemDistance!.x),
//           calculate(
//               gridMapBorder.y, gridItemsBoundary.y, gridItemDistance.y),
//           calculate(
//               gridMapBorder.z, gridItemsBoundary.z, gridItemDistance.z),
//         );
//     }
//   }
// }
//
// /// builders
// typedef GridItemBuilder = Widget Function(
//   BoxConstraints constraints,
//   Offset position,
// );
//
// typedef GridItemDistanceBuilder = Widget Function(
//   BoxConstraints constraints,
//   Offset nearByItemPositionA,
//   Offset nearByItemPositionB,
// );
// typedef GridItemCornerBuilder = Widget Function(
//   BoxConstraints constraints,
//   Offset nearByItemPositionA,
//   Offset nearByItemPositionB,
//   Offset nearByItemPositionC,
//   Offset nearByItemPositionD,
// );
