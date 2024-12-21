import 'package:permission_handler/permission_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> checkPermissions() async {

  //Check Location Permission
  var status = await Permission.location.status;
  if (!status.isGranted) {
    await Permission.location.request();
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}