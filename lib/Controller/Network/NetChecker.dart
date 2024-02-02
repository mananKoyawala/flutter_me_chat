import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';
import 'package:me_chat/Packages/Constants.dart';

import '../../Utils/Services/NavigatorServices.dart';

class NetChecker extends GetxController {
  late StreamSubscription subscription;
  var isDeviceConnected = false.obs;
  var isAlertSet = false.obs;

  @override
  void onInit() {
    getConnectivity();
    super.onInit();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected.value =
              await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected.value && isAlertSet.value == false) {
            showDialogBox();
            isAlertSet.value = true;
          } else if (isDeviceConnected.value && isAlertSet.value == true) {
            Nav.pop(); // Close the dialog
            isAlertSet.value = false;
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: ncontext,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connection.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                isAlertSet.value = false;
                isDeviceConnected.value =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected.value && isAlertSet.value == false) {
                  showDialogBox();
                  isAlertSet.value = true;
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      );

  void showBottomSheetDialog() {
    showModalBottomSheet(
      isDismissible: false,
      context: ncontext,
      builder: (BuildContext context) {
        return Container(
          width: DP.infinity(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'No Connection',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please check your internet connection.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context); // Close the bottom sheet
                  isAlertSet.value = false;
                  isDeviceConnected.value =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected.value && isAlertSet.value == false) {
                    showBottomSheetDialog(); // Show the bottom sheet again if needed
                    isAlertSet.value = true;
                  }
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
