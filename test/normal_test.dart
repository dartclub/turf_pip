import 'package:turf_pip/turf_pip.dart';
import 'package:test/test.dart';
import 'package:turf/helpers.dart';

main() {
  group(
    'normal tests',
    () {
      Polygon polygon = Polygon(coordinates: [
        [
          Position.of([1, 1]),
          Position.of([1, 2]),
          Position.of([2, 2]),
          Position.of([2, 1]),
          Position.of([1, 1])
        ]
      ]);

      test('is inside', () {
        expect(
          pointInPolygon(Point(coordinates: Position.of([1.5, 1.5])), polygon),
          PointInPolygonResult.isInside,
        );
      });

      test(
        'input is not modified',
        () {
          pointInPolygon(Point(coordinates: Position.of([2, 1.5])), polygon);
          expect(
            polygon.coordinates,
            [
              [
                Position.of([1, 1]),
                Position.of([1, 2]),
                Position.of([2, 2]),
                Position.of([2, 1]),
                Position.of([1, 1])
              ]
            ],
          );
        },
      );

      test(
        'is outside',
        () {
          expect(
            pointInPolygon(
                Point(coordinates: Position.of([4.9, 1.2])), polygon),
            PointInPolygonResult.isOutside,
          );
        },
      );

      test(
        'is on top edge',
        () {
          expect(
            pointInPolygon(Point(coordinates: Position.of([1.5, 2])), polygon),
            PointInPolygonResult.isOnEdge,
          ); // is
        },
      );

      test(
        'is on bottom edge',
        () {
          expect(
            pointInPolygon(Point(coordinates: Position.of([1.5, 1])), polygon),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'is on left edge',
        () {
          expect(
            pointInPolygon(Point(coordinates: Position.of([1, 1.5])), polygon),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'is on right edge',
        () {
          expect(
            pointInPolygon(Point(coordinates: Position.of([2, 1.5])), polygon),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      Polygon polygonWithHole = Polygon(
        coordinates: [
          [
            Position.of([1, 1]),
            Position.of([1, 2]),
            Position.of([2, 2]),
            Position.of([2, 1]),
            Position.of([1, 1])
          ],
          [
            Position.of([1.5, 1.5]),
            Position.of([1.5, 1.7]),
            Position.of([1.7, 1.7]),
            Position.of([1.7, 1.5]),
            Position.of([1.5, 1.5])
          ]
        ],
      );

      test(
        'is inside with hole',
        () {
          expect(
            pointInPolygon(
                Point(coordinates: Position.of([1.2, 1.2])), polygonWithHole),
            PointInPolygonResult.isInside,
          );
        },
      );

      test(
        'is outside with hole',
        () {
          expect(
            pointInPolygon(
                Point(coordinates: Position.of([4.9, 1.2])), polygonWithHole),
            PointInPolygonResult.isOutside,
          );
        },
      );

      test(
        'is in the hole',
        () {
          expect(
            pointInPolygon(
                Point(coordinates: Position.of([1.6, 1.6])), polygonWithHole),
            PointInPolygonResult.isOutside,
          );
        },
      );

      test(
        'is on edge with hole',
        () {
          expect(
            pointInPolygon(
                Point(coordinates: Position.of([1.5, 1.5])), polygonWithHole),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'is on edge of the outside',
        () {
          expect(
            pointInPolygon(
                Point(coordinates: Position.of([1.2, 1])), polygonWithHole),
            PointInPolygonResult.isOnEdge,
          );
        },
      );

      test(
        'error is thrown when not the same first and last coords',
        () {
          var poly = Polygon(
            coordinates: [
              [
                Position.of([0, 0]),
                Position.of([1, 0]),
                Position.of([1, 1]),
              ],
            ],
          );

          expect(
              () =>
                  pointInPolygon(Point(coordinates: Position.of([1, 1])), poly),
              throwsA(isA<Exception>()));
          // 'First and last coordinates in a ring must be the same');
        },
      );
    },
  );
}
