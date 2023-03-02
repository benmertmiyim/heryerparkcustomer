import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:customer/core/base/location_base.dart';
import 'package:customer/core/service/location_service.dart';
import 'package:customer/locator.dart';

enum LocationProcess {
  idle,
  busy,
}

class LocationView with ChangeNotifier implements LocationBase {
  LocationProcess _locationProcess = LocationProcess.idle;
  LocationService locationService = locator<LocationService>();
  Position? currentPosition;
  Position? lastPosition;
  bool? permission;

  LocationProcess get locationProcess => _locationProcess;

  set locationProcess(LocationProcess value) {
    _locationProcess = value;
    notifyListeners();
  }

  LocationView() {
    getLastCustomerLocation();
    getCurrentCustomerLocation();
  }

  @override
  Future<bool> checkPermission() async {
    try {
      locationProcess = LocationProcess.busy;
      permission = await locationService.checkPermission();
      return permission!;
    } catch (e) {
      debugPrint(
        "LocationView - Exception - Check Permission : ${e.toString()}",
      );
    } finally {
      locationProcess = LocationProcess.idle;
    }
    return false;
  }

  @override
  Future<Position?> getCurrentCustomerLocation() async {
    try {
      await checkPermission();
      currentPosition = await locationService.getCurrentCustomerLocation();

      return currentPosition;
    } catch (e) {
      debugPrint(
        "LocationView - Exception - Get Current Customer Location : ${e.toString()}",
      );
    } finally {
      locationProcess = LocationProcess.idle;
    }
    return currentPosition;
  }

  @override
  Future<Position?> getLastCustomerLocation() async {
    try {
      lastPosition = await locationService.getLastCustomerLocation();
      return lastPosition;
    } catch (e) {
      debugPrint(
        "LocationView - Exception - Get Last Customer Location : ${e.toString()}",
      );
    } finally {
      locationProcess = LocationProcess.idle;
    }
    return lastPosition;
  }
}
