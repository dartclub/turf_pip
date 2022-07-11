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
                  pip(Point(coordinates: Position.of([8, 46.5])), switzCoords),
                  1);
            },
          );

          test(
            'is outside',
            () {
              expect(pip(Point(coordinates: Position.of([8, 44])), switzCoords),
                  -1);
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
                  pip(Point(coordinates: Position.of([8, 46.5])),
                      switzerlandKinked),
                  1);
            },
          );

          test(
            'is outside kinked',
            () {
              expect(
                  pip(Point(coordinates: Position.of([8, 44])),
                      switzerlandKinked),
                  -1);
            },
          );
        }
      }
    },
  );
}
