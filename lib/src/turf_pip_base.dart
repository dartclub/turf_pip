import 'package:turf/turf.dart';

enum PointInPolygonResult {
  isInsidePolygon,
  isOnLine,
  isOutside,
}

PointInPolygonResult pointInPolygon(Point p, Polygon polygon) {
  int i = 0;
  int ii = 0;
  int k = 0;
  num f = 0;
  num u1 = 0;
  num v1 = 0;
  num u2 = 0;
  num v2 = 0;
  Position currentP;
  Position nextP;

  num x = p.coordinates.lng;
  num y = p.coordinates.lat;

  int numContours = polygon.coordinates.length;
  for (i; i < numContours; i++) {
    ii = 0;
    var contourLen = polygon.coordinates[i].length - 1;
    var contour = polygon.coordinates[i];

    currentP = contour[0];
    if (currentP[0] != contour[contourLen][0] &&
        currentP[1] != contour[contourLen][1]) {
      throw Exception('First and last coordinates in a ring must be the same');
    }

    u1 = currentP.lng - x;
    v1 = currentP.lat - y;

    for (ii; ii < contourLen; ii++) {
      nextP = contour[ii + 1];

      v2 = nextP.lat - y;

      if ((v1 < 0 && v2 < 0) || (v1 > 0 && v2 > 0)) {
        currentP = nextP;
        v1 = v2;
        u1 = currentP.lng - x;
        continue;
      }

      u2 = nextP.lng - p.coordinates.lng;

      if (v2 > 0 && v1 <= 0) {
        f = (u1 * v2) - (u2 * v1);
        if (f > 0) {
          k = k + 1;
        } else if (f == 0) {
          return PointInPolygonResult.isOnLine;
        }
      } else if (v1 > 0 && v2 <= 0) {
        f = (u1 * v2) - (u2 * v1);
        if (f < 0) {
          k = k + 1;
        } else if (f == 0) {
          return PointInPolygonResult.isOnLine;
        }
      } else if (v2 == 0 && v1 < 0) {
        f = (u1 * v2) - (u2 * v1);
        if (f == 0) {
          return PointInPolygonResult.isOnLine;
        }
      } else if (v1 == 0 && v2 < 0) {
        f = u1 * v2 - u2 * v1;
        if (f == 0) return PointInPolygonResult.isOnLine;
      } else if (v1 == 0 && v2 == 0) {
        if (u2 <= 0 && u1 >= 0) {
          return PointInPolygonResult.isOnLine;
        } else if (u1 <= 0 && u2 >= 0) {
          return PointInPolygonResult.isOnLine;
        }
      }
      currentP = nextP;
      v1 = v2;
      u1 = u2;
    }
  }

  if (k % 2 == 0) {
    return PointInPolygonResult.isOutside;
  }
  return PointInPolygonResult.isInsidePolygon;
}
