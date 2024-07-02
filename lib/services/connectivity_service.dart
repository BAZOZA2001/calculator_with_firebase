import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityService {
  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      _showConnectivityToast(result);
    });
  }

  void _showConnectivityToast(ConnectivityResult result) {
    String message;
    if (result == ConnectivityResult.mobile) {
      message = "Connected to Mobile Network";
    } else if (result == ConnectivityResult.wifi) {
      message = "Connected to WiFi";
    } else {
      message = "No Internet Connection";
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
