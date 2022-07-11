import 'dart:convert';
import 'dart:io';

import 'package:turf_pip/turf_pip.dart';
import 'package:test/test.dart';
import 'package:turf/helpers.dart';

main() {
  group(
    'big geom',
    () {
      var inDir = Directory('./test/fixtures/simple');
      for (var file in inDir.listSync(recursive: true)) {
        if (file is File && file.path.endsWith('.geojson')) {
          Polygon switzCoords =
              (GeoJSONObject.fromJson(jsonDecode(file.readAsStringSync()))
                      as Feature)
                  .geometry as Polygon;
          test(
            'is inside',
            () {
              expect(
                pointInPolygon(
                    Point(coordinates: Position.of([8, 46.5])), switzCoords),
                PointInPolygonResult.isInside,
              );
            },
          );

          test(
            'is outside',
            () {
              expect(
                pointInPolygon(
                    Point(coordinates: Position.of([8, 44])), switzCoords),
                PointInPolygonResult.isOutside,
              );
            },
          );
        }
      }

      inDir = Directory('./test/fixtures/notSimple');
      for (var file in inDir.listSync(recursive: true)) {
        if (file is File && file.path.endsWith('.geojson')) {
          Polygon switzerlandKinked =
              (GeoJSONObject.fromJson(jsonDecode(file.readAsStringSync()))
                      as Feature)
                  .geometry as Polygon;

          test(
            'is inside kinked',
            () {
              expect(
                pointInPolygon(Point(coordinates: Position.of([8, 46.5])),
                    switzerlandKinked),
                PointInPolygonResult.isInside,
              );
            },
          );

          test(
            'is outside kinked',
            () {
              expect(
                  pointInPolygon(Point(coordinates: Position.of([8, 44])),
                      switzerlandKinked),
                  PointInPolygonResult.isOutside);
            },
          );
        }
      }
    },
  );
}
