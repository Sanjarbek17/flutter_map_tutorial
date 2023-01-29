import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:geojson/geojson.dart';
import 'package:latlong2/latlong.dart';

import 'geo_json.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var geo = GeoJsonParser(
        defaultPolygonBorderColor: Colors.white,
        defaultPolygonFillColor: Colors.blue);
    var myFile = File('assets/my_data.geojson').readAsStringSync();
    geo.parseGeoJson(jsonDecode(myFile));
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(children: [
            DrawerHeader(child: Text('Header')),
            Text('child'),
          ]),
        ),
        appBar: AppBar(
          title: Text('openstreetmap'),
        ),
        body: SafeArea(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(39.6531163453585, 66.96392089492956),
              zoom: 15.2,
              onTap: (tapPosition, point) {
                getData();
              },
            ),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(39.6531163453585, 66.96392089492956),
                    width: 80,
                    height: 80,
                    builder: (context) => const Icon(
                      Icons.place,
                      size: 50,
                    ),
                  ),
                ],
              ),
              PolygonLayer(
                polygonCulling: false,
                polygons: geo.polygons,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
