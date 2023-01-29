import 'dart:convert';
import 'dart:io';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:geojson/geojson.dart';

void getData() async {
  var geo = GeoJsonParser();
  var myFile = File('assets/my_data.geojson').readAsStringSync();
  geo.parseGeoJson(jsonDecode(myFile));
  print(geo.polygons);
}
