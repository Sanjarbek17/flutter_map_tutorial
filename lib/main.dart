import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
              zoom: 9.2,
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
            children: [
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
                    builder: (context) => Icon(
                      Icons.place,
                      size: 50,
                    ),
                  ),
                ],
              ),
              PolygonLayer(
                polygonCulling: false,
                polygons: [
                  Polygon(
                    borderStrokeWidth: 5,
                    points: [
                      LatLng(40.6531163453585, 66.96392089492956),
                      LatLng(39.6531163453585, 67.96392089492956),
                      LatLng(39.6531163453585, 66.96392089492956),
                    ],
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
