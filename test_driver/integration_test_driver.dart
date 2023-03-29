import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

import 'dart:io';
import 'package:path/path.dart';


Future<void> main() async {
  String? adbPath = join("C:/Users/Karri/AppData/Local/Android/Sdk",
    'platform-tools',
    Platform.isWindows ? 'adb.exe' : 'adb',
  );

  await Process.run(
    adbPath,
    [
      'shell',
      'pm',
      'grant',
      'app.heryerpark.customer',
      'android.permission.ACCESS_FINE_LOCATION'
    ],
  );
  await Process.run(
    adbPath,
    [
      'shell',
      'pm',
      'grant',
      'app.heryerpark.customer', // TODO: Update this
      'android.permission.ACCESS_COARSE_LOCATION'
    ],
  );
  await Process.run(
    adbPath,
    [
      'shell',
      'pm',
      'grant',
      'app.heryerpark.customer', // TODO: Update this
      'android.permission.INTERNET'
    ],
  );

  await integrationDriver();
}
