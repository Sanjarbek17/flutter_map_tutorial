import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MapController _mapController = MapController();
  LocationData? _locationData;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _locationData = currentLocation;
      });
    });
    _locationData = await location.getLocation();
    print(_locationData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Map Example'),
        ),
        body: FlutterMap(
          options: MapOptions(
            center: _locationData != null
                ? LatLng(_locationData!.latitude!, _locationData!.longitude!)
                : LatLng(39.6548, 66.9597),
            zoom: 10.0,
            // plugins: [LocationPlugin()],
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: _locationData != null
                  ? [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(_locationData!.latitude!,
                            _locationData!.longitude!),
                        builder: (ctx) => const Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                          size: 50,
                        ),
                      ),
                    ]
                  : [],
            ),
            // Locations(
            //   onLocationChanged: (LocationData ld) {
            //     _mapController.move(
            //       LatLng(ld.latitude!, ld.longitude!),
            //       _mapController.zoom,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
