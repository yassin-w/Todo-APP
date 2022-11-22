// ignore_for_file: prefer_interpolation_to_compose_strings, unused_element, prefer_const_constructors, prefer_const_declarations, unused_local_variable, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/todo_controller.dart';

class MyLocationPage extends StatefulWidget {
  const MyLocationPage({Key? key}) : super(key: key);

  @override
  State<MyLocationPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyLocationPage> {
  final Completer<GoogleMapController> _controller = Completer();
  var latitude = 31.947351;
  var longitude = 35.227163;

  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(31.947351, 35.227163),
    zoom: 14.4746,
  );

  // on below line we have created the list of markers
  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
        init: TodoController(),
        initState: (_) {},
        builder: (todoController) {
          todoController.getData(AuthController.instance.auth.currentUser!.uid);
          for (var i = 0; i < todoController.todos.length; i++) {
            _markers.add(Marker(
                markerId: MarkerId(i.toString()),
                position: LatLng(
                    todoController.todos[i].lat, todoController.todos[i].long),
                infoWindow: InfoWindow(
                  title: todoController.todos[i].name,
                )));
          }

          return Scaffold(
            body: SafeArea(
              child: GoogleMap(
                initialCameraPosition: _kGoogle,
                markers: Set<Marker>.of(_markers),
                mapType: MapType.hybrid,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),

            // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }
}
