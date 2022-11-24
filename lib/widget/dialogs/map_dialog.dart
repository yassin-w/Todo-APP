// ignore_for_file: prefer_interpolation_to_compose_strings, unused_element, prefer_const_constructors, prefer_const_declarations, unused_local_variable, unused_field, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocationDialog extends StatefulWidget {
  const MyLocationDialog({Key? key}) : super(key: key);

  @override
  State<MyLocationDialog> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyLocationDialog> {
  Position? _position;
  late LatLng _locatonPoint;
  void _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  List<Marker> _markers = [];

  @override
  initState() {
    _getCurrentLocation();

    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(31.947351, 35.227163),
    zoom: 14.4746,
  );

  // on below line we have created the list of markers

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _locatonPoint);
            },
            child: Text("Save".tr))
      ],
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: _kGoogle,
          markers: Set<Marker>.of(_markers),
          mapType: MapType.hybrid,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          onTap: _handleTap,

          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      _markers = [];
      _markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
      _locatonPoint = tappedPoint;
    });
  }
}
