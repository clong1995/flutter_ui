import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/foundation.dart';

class Guid {
  static String _id = '';
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> get id async {
    if (_id.isNotEmpty) {
      return _id;
    }
    final bytes = utf8.encode(await info);
    final digest = md5.convert(bytes);
    final md5Hash = digest.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < md5Hash.length; i++) {
      buffer.write(md5Hash[i]);
      if ((i + 1) % 4 == 0 && i != md5Hash.length - 1) {
        buffer.write('-');
      }
    }
    return _id = buffer.toString();
  }

  static Future<String> get info async {
    var input = '';
    if (Platform.isWindows) {
      final deviceInfo = await _deviceInfo.windowsInfo;
      input =
          '${deviceInfo.computerName}'
          '${deviceInfo.numberOfCores}'
          '${deviceInfo.systemMemoryInMegabytes}'
          '${deviceInfo.platformId}'
          '${deviceInfo.editionId}'
          '${deviceInfo.installDate}'
          '${deviceInfo.deviceId}'
          '${deviceInfo.userName}'
          '${deviceInfo.majorVersion}'
          '${deviceInfo.csdVersion}'
          '${deviceInfo.servicePackMajor}'
          '${deviceInfo.servicePackMinor}'
          '${deviceInfo.suitMask}'
          '${deviceInfo.productId}'
          '${deviceInfo.productName}'
          '${deviceInfo.registeredOwner}';
    } else if (Platform.isLinux) {
      final deviceInfo = await _deviceInfo.linuxInfo;
      input =
          '${deviceInfo.name}'
          '${deviceInfo.id}'
          '${deviceInfo.idLike?.join(',') ?? ''}'
          '${deviceInfo.prettyName}'
          '${deviceInfo.variant}'
          '${deviceInfo.variantId}'
          '${deviceInfo.machineId ?? ''}';
    } else if (Platform.isMacOS) {
      final macOsInfo = await _deviceInfo.macOsInfo;
      input =
          '${macOsInfo.computerName}'
          '${macOsInfo.hostName}'
          '${macOsInfo.arch}'
          '${macOsInfo.model}'
          '${macOsInfo.activeCPUs}'
          '${macOsInfo.memorySize}'
          '${macOsInfo.cpuFrequency}'
          '${macOsInfo.systemGUID ?? ''}'
          '${macOsInfo.majorVersion}';
    } else if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      input =
          '${androidInfo.board}'
          '${androidInfo.bootloader}'
          '${androidInfo.brand}'
          '${androidInfo.device}'
          '${androidInfo.fingerprint}'
          '${androidInfo.hardware}'
          '${androidInfo.host}'
          '${androidInfo.id}'
          '${androidInfo.manufacturer}'
          '${androidInfo.model}'
          '${androidInfo.product}'
          '${androidInfo.supported32BitAbis.join(',')}'
          '${androidInfo.supported64BitAbis.join(',')}'
          '${androidInfo.supportedAbis.join(',')}'
          '${androidInfo.isPhysicalDevice}'
          //'${androidInfo.serialNumber}'
          ;
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      input =
          '${iosInfo.name}'
          '${iosInfo.systemName}'
          '${iosInfo.model}'
          '${iosInfo.localizedModel}'
          '${iosInfo.identifierForVendor ?? ''}'
          '${iosInfo.isPhysicalDevice}';
    }
    if (input.isEmpty) {
      throw Exception('no guid');
    }
    //input +;
    return input += Platform.localeName;
  }
}
