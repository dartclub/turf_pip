import 'package:pip/pip.dart';
import 'package:test/test.dart';
import 'package:turf/helpers.dart';

main() {
  group('', () {
    const switzerland = loadJsonFile.sync(
        path.join(__dirname, 'fixtures', 'simple', 'switzerland.geojson'));
    const switzCoords = switzerland.geometry.coordinates;

    test('is inside', () {
      expect(
          pip(Point(coordinates: Position.of([8, 46.5])), switzCoords), true);
    });

    test('is outside', () {
      expect(pip(Point(coordinates: Position.of([8, 44])), switzCoords), false);
    });

    const switzerlandKinked = loadJsonFile.sync(path.join(
        __dirname, 'fixtures', 'notSimple', 'switzerlandKinked.geojson'));
    const switzKinkedCoords = switzerlandKinked.geometry.coordinates;

    test('is inside kinked', () {
      expect(pip(Point(coordinates: Position.of([8, 46.5])), switzKinkedCoords),
          true);
    });

    test('is outside kinked', () {
      expect(pip(Point(coordinates: Position.of([8, 44])), switzKinkedCoords),
          false);
    });
  });
}
