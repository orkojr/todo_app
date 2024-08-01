import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

Future<bool> isNetworkAvailable() async{
  FlutterNetworkConnectivity flutterNetworkConnectivity =
    FlutterNetworkConnectivity(
	  isContinousLookUp: true,  
	  lookUpDuration: const Duration(seconds: 5), 
	  lookUpUrl: 'example.com',  
	);
  bool isNetworkAvailableOnCall = await flutterNetworkConnectivity.isInternetConnectionAvailable();
  return isNetworkAvailableOnCall;
}