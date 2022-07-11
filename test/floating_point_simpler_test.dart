import 'package:turf_pip/turf_pip.dart';
import 'package:test/test.dart';
import 'package:turf/helpers.dart';

main() {
  group(
    'floating point simple',
    () {
      var polygon = Polygon(coordinates: [
        [
          Position.of([1.111111111111, 1.111111111111]),
          Position.of([1.111111111111, 2.111111111111]),
          Position.of([2.111111111111, 2.111111111111]),
          Position.of([2.111111111111, 1.111111111111]),
          Position.of([1.111111111111, 1.111111111111])
        ]
      ]);

      _toPoint(List<num> list) => Point(coordinates: Position.of(list));
      test(
        'is on bottom edge poly',
        () {
          expect(
            pointInPolygon(_toPoint([1.511111111111, 1.111111111111]), polygon),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'is on top edge poly',
        () {
          expect(
            pointInPolygon(_toPoint([1.511111111111, 2.111111111111]), polygon),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'is on left edge poly',
        () {
          expect(
            pointInPolygon(_toPoint([1.111111111111, 1.511111111111]), polygon),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'is on right edge poly',
        () {
          expect(
            pointInPolygon(_toPoint([2.111111111111, 1.511111111111]), polygon),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'is just inside left edge',
        () {
          expect(
            pointInPolygon(
                _toPoint([1.1111111111111, 1.511111111111]), polygon),
            PointInPolygonResult.isInside,
          );
        },
      );

      test(
        'is just outside left edge',
        () {
          expect(
            pointInPolygon(_toPoint([1.111111111110, 1.511111111111]), polygon),
            PointInPolygonResult.isOutside,
          );
        },
      );
    },
  );
}
