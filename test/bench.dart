const Benchmark = require('benchmark')
const pipHao = require('../dist/pointInPolygon.js')
const inside = require('point-in-polygon')
const turfPip = require('@turf/boolean-point-in-polygon').default
const robustPip = require('robust-point-in-polygon')

const loadJsonFile = require('load-json-file')
const path = require('path')

const insideSuite = new Benchmark.Suite();

const polygon = [[1, 1], [1, 2], [2, 2], [2, 1]];
const polywrapped = [[[1, 1], [1, 2], [2, 2], [2, 1], [1, 1]]];
const point = {type: 'Point', coordinates: [1.5, 1.5]}
const geojsonPoly = {type: 'Polygon', coordinates: polywrapped}


insideSuite
    .add('point-in-poly-hao', () {
        pipHao([1.5, 1.5], polywrapped)
    })
    .add('turf-point-in-polygon', () {
        turfPip(point, geojsonPoly)
    })
    .add('point-in-polygon', () {
        inside([1.5, 1.5], polygon)
    })
    .add('robust-point-in-polygon', () {
        robustPip(polygon, [1.5, 1.5])
    })
    .on('cycle', (event) {
        console.log(String(event.target))
    })
    .on('complete', () {
        console.log('Fastest is ' + this.filter('fastest').map('name'));
    })
    .run()

const largePolySuite = new Benchmark.Suite();

const switzerland = loadJsonFile.sync(path.join(__dirname, 'fixtures', 'simple', 'switzerland.geojson'))
const switzCoords = switzerland.geometry.coordinates
const mainSwissRing = switzCoords[0]
const point2 = {type: 'Point', coordinates: [8, 46.5]}


largePolySuite
    .add('point-in-poly-hao', () {
        pipHao([8, 46.5], switzCoords)
    })
    .add('turf-point-in-polygon', () {
        turfPip(point2, switzerland)
    })
    .add('point-in-polygon', () {
        inside([8, 46.5], mainSwissRing)
    })
    .add('robust-point-in-polygon', () {
        robustPip(mainSwissRing, [8, 46.5])
    })
    .on('cycle', (event) {
        console.log(String(event.target))
    })
    .on('complete', () {
        console.log('Fastest is ' + this.filter('fastest').map('name'));
    })
    .run()

