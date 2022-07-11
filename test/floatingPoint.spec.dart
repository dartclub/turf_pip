// Inspiration drawn from TurfJS issue
// https://github.com/Turfjs/turf/issues/1597

import 'package:turf_pip/turf_pip.dart';
import 'package:test/test.dart';
import 'package:turf/helpers.dart';

main() {
  group(
    'floating point',
    () {
      var polygon = Polygon(
        coordinates: [
          [
            Position.of([-115.1752628, 36.0873974]),
            Position.of([-115.1752969, 36.0873974]),
            Position.of([-115.1752969, 36.0874526]),
            Position.of([-115.1752628, 36.0874526]),
            Position.of([-115.1752628, 36.0873974])
          ]
        ],
      );

      test(
        'is on edge poly',
        () {
          expect(
              pip(Point(coordinates: Position.of([-115.1752799, 36.0874526])),
                  polygon),
              0); // is
        },
      );

      test(
        'is on other edge poly',
        () {
          expect(
              pip(Point(coordinates: Position.of([-115.1752799, 36.0873974])),
                  polygon),
              0); // is
        },
      );

      var shiftedPoly = Polygon(
        coordinates: [
          [
            Position.of([-115.1752628, 36.0873974]),
            Position.of([-115.1752969, 36.0873974]),
            Position.of([-115.1752969, 36.0874528]),
            Position.of([-115.1752628, 36.0874528]),
            Position.of([-115.1752628, 36.0873974])
          ]
        ],
      );

      test(
        'is on edge slightly tweaked poly',
        () {
          expect(
              pip(Point(coordinates: Position.of([-115.1752799, 36.0874528])),
                  shiftedPoly),
              0); // is
        },
      );

      test(
        'is on other edge slightly tweaked poly',
        () {
          expect(
              pip(Point(coordinates: Position.of([-115.1752799, 36.0873974])),
                  shiftedPoly),
              0); // is
        },
      );
    },
  );
}
