import 'dart:async';
import 'package:customer/core/view/auth_view.dart';
import 'package:customer/core/view/location_view.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  LatLng? targetPosition;
  double zoom = 16;

  late AuthView authView;
  late LocationView locationView;

  Future<void> _onMapCreated(GoogleMapController controller) async {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    _controller = controller;
    String value = await DefaultAssetBundle.of(context).loadString(
        brightness == Brightness.light
            ? 'assets/map.json'
            : 'assets/mapdark.json');
    _controller.setMapStyle(value);
  }

  @override
  Widget build(BuildContext context) {
    locationView = Provider.of<LocationView>(context);
    authView = Provider.of<AuthView>(context);

    if (locationView.locationProcess == LocationProcess.busy ||
        locationView.currentPosition == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    targetPosition = LatLng(
      locationView.currentPosition!.latitude,
      locationView.currentPosition!.longitude,
    );

    if (locationView.permission == false) {
      return const Center(
        child: Text("you must allow location services"),
      );
    }

    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              locationView.currentPosition!.latitude,
              locationView.currentPosition!.longitude,
            ),
            zoom: 16,
          ),
          onCameraMove: (CameraPosition position) {
            targetPosition = position.target;
            zoom = -0.25 * position.zoom + 5.75;
          },
          onCameraIdle: () {
            authView.getNearVendor(
                targetPosition!.latitude, targetPosition!.longitude, zoom, 30);
          },
          markers: authView.markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
        ),
        authView.authProcess == AuthProcess.busy
            ? const Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                left: 0,
                child: Center(child: CircularProgressIndicator(),),
              )
            : Container(),
      ],
    );
  }
}
