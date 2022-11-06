import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';

///Get Today Date
Map? deviceInformation;

String getTodayDate() {
  return 'Date:-  ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}\n\n';
}

///Get Current Time
String getCurrentTime() {
  return 'Time:-  ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}\n\n';
}

/// Get Data
Future<Map?> getDeviceInfo() async {
  var deviceInfo = DeviceInfoPlugin();

  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;

    return {
      "IOS Identifier For Vendor:- ": iosDeviceInfo.identifierForVendor,
      "IOS Physical Device:- ": iosDeviceInfo.isPhysicalDevice,
      "IOS Name:- ": iosDeviceInfo.name,
      "IOS Version:- ": iosDeviceInfo.systemVersion,
      "IOS Model:- ": iosDeviceInfo.model,
    }; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;

    debugPrint("Brand:- " + androidDeviceInfo.brand);
    debugPrint("Manufacturer:- ${androidDeviceInfo.manufacturer}");
    // debugPrint("Display:- " + androidDeviceInfo.display);
    debugPrint("Version:- " + androidDeviceInfo.version.release);
    debugPrint("Model:- " + androidDeviceInfo.model);

    return {
      "Android Physical Device:- ": androidDeviceInfo.isPhysicalDevice,
      "Android Id:- ": androidDeviceInfo.id,
      "Android Brand:- ": androidDeviceInfo.brand,
      "Android Manufacturer:- ": androidDeviceInfo.manufacturer,
      "Android Version:- ": androidDeviceInfo.version.release,
      "Android Model:- ": androidDeviceInfo.version.release,
    }; // unique ID on Android
  }
}

///Encryption
encryptData({String? data}) {
  debugPrint("Decrpted Metod call");
  final plainText = data;
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final encrypted = encrypter.encrypt(plainText!, iv: iv);
  print("Encrypted Data:- " + encrypted.base16);
  return encrypted;
  //  print(encrypted.base64); // print(encrypted.base64); //
}

///Decryption
String decryptData({required String encrypted}) {
  debugPrint("Decrpted Metod call");
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt(encrypted as Encrypted, iv: iv);
  // debugPrint("Decrypted Data:- "+decrypted);
  return decrypted; // Lorem ipsum dolor sit amet, consectetur adipiscing elit
}
