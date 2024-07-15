import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class Guid {
  static String _id = "";
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static Future<String> get id async {
    if (_id.isNotEmpty) {
      return _id;
    }
    String input = "";
    if (defaultTargetPlatform == TargetPlatform.windows) {
      WindowsDeviceInfo deviceInfo = await _deviceInfo.windowsInfo;
      input =
      "${deviceInfo.computerName}${deviceInfo.numberOfCores}${deviceInfo.systemMemoryInMegabytes}${deviceInfo.platformId}${deviceInfo.editionId}${deviceInfo.installDate}${deviceInfo.deviceId}${deviceInfo.userName}${deviceInfo.majorVersion}${deviceInfo.csdVersion}${deviceInfo.servicePackMajor}${deviceInfo.servicePackMinor}${deviceInfo.suitMask}${base64Encode(deviceInfo.digitalProductId)}${deviceInfo.productId}${deviceInfo.productName}${deviceInfo.registeredOwner}";
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      LinuxDeviceInfo deviceInfo = await _deviceInfo.linuxInfo;
      input =
      "${deviceInfo.name}${deviceInfo.id}${deviceInfo.idLike?.join(",") ?? ""}${deviceInfo.prettyName}${deviceInfo.variant}${deviceInfo.variantId}${deviceInfo.machineId ?? ""}";
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      MacOsDeviceInfo macOsInfo = await _deviceInfo.macOsInfo;
      input =
      "${macOsInfo.computerName}${macOsInfo.hostName}${macOsInfo.arch}${macOsInfo.model}${macOsInfo.activeCPUs}${macOsInfo.memorySize}${macOsInfo.cpuFrequency}${macOsInfo.systemGUID ?? ""}${macOsInfo.majorVersion}";
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      input =
      "${androidInfo.board}${androidInfo.bootloader}${androidInfo.brand}${androidInfo.device}${androidInfo.fingerprint}${androidInfo.hardware}${androidInfo.host}${androidInfo.id}${androidInfo.manufacturer}${androidInfo.model}${androidInfo.product}${androidInfo.supported32BitAbis.join(",")}${androidInfo.supported64BitAbis.join(",")}${androidInfo.supportedAbis.join(",")}${androidInfo.isPhysicalDevice}${androidInfo.serialNumber}";
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      input =
      "${iosInfo.name}${iosInfo.systemName}${iosInfo.model}${iosInfo.localizedModel}${iosInfo.identifierForVendor ?? ""}${iosInfo.isPhysicalDevice}";
    }

    if (input.isEmpty) {
      throw "no guid";
    }
    input += defaultTargetPlatform.name;

    List<int> bytes = md5.convert(utf8.encode(input)).bytes;
    _id = base64.encode(bytes);
    return _id;
  }
}
