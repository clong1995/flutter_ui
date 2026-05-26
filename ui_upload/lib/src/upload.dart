//import 'package:kit/kit.dart';
import 'package:ui_pick_file/ui_pick_file.dart';
import 'package:ui_upload/src/image_size.dart';
import 'package:ui_upload/src/sign_url.dart';
import 'package:ui_upload/src/upload_file.dart';

class Upload {
  //相机 type : video / photo
  static Future<String?> camera({
    required String type,
    required Future<List<SignUrl>> Function(List<String> fileName) signUrl,
    //required String path,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    final pf = await UiPickImage.camera(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
    );
    if (pf != null) {
      //获取文件内容
      String fileName;
      if (type == 'photo') {
        final size = await imageSizeFromPath(pf.path);
        fileName = '_s_${size.width}x${size.height}.${pf.extension}';
      } else {
        fileName = '.${pf.extension}';
      }

      //签名地址
      final signList = await signUrl([fileName]);
      if (signList.isEmpty) {
        return null;
      }

      final su = signList.first;

      //开始上传
      final flag = await uploadFile(
        signUrl: su.upload,
        bytes: await pf.bytes(),
      );

      if (!flag) {
        return null;
      }

      return su.download;
    }
    return null;
  }

  //相机 type : video / photo
  static Future<List<String>?> gallery({
    required String type,
    required Future<List<SignUrl>> Function(List<String> fileName) signUrl,

    // required String path,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    int? limit,
    void Function(String download)? uploadStep,
  }) async {
    if (type == 'video') {
      //视频
      final pf = await UiPickVideo.gallery();
      if (pf == null) {
        return null;
      }

      final signList = await signUrl(['.${pf.extension}']);
      if (signList.isEmpty) {
        return null;
      }

      final sign = signList.first;

      //开始上传
      final flag = await uploadFile(
        signUrl: sign.upload,
        bytes: await pf.bytes(),
      );

      if (!flag) {
        return null;
      }
      uploadStep?.call(sign.download);
      return [sign.download];
    } else {
      //图片
      final pfs = await UiPickImage.multiple(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality,
        limit: limit,
      );
      if (pfs == null || pfs.isEmpty) {
        return null;
      }

      final fileList = <String>[];
      for (var i = 0; i < pfs.length; i++) {
        final pf = pfs[i];
        final size = await imageSizeFromPath(pf.path);
        final fileName = '_${i}_s_${size.width}x${size.height}.${pf.extension}';
        fileList.add(fileName);
      }

      //批量获取签名地址
      final signList = await signUrl(fileList);
      if (signList.isEmpty) {
        return null;
      }

      final download = <String>[];
      for (var i = 0; i < signList.length; i++) {
        final sign = signList[i];

        final flag = await uploadFile(
          signUrl: sign.upload,
          bytes: await pfs[i].bytes(),
        );
        if (!flag) {
          break;
        }

        uploadStep?.call(sign.download);
        download.add(sign.download);
      }

      return download;
    }
  }

  static Future<List<String>?> file({
    required String path,
    required Future<List<SignUrl>> Function(List<String> fileName) signUrl,
    List<String>? allowedExtensions,
    int? limit,
    void Function(String download)? uploadStep,
  }) async {
    final pfs = await UiPickFile.multiple(
      limit: limit,
      allowedExtensions: allowedExtensions,
    );
    if (pfs == null || pfs.isEmpty) {
      return null;
    }

    /*final l = <String>[];
    final fileMap = <String, Future<Uint8List> Function()>{};
    var i = 0;*/

    final fileList = <String>[];
    for (var i = 0; i < pfs.length; i++) {
      final pf = pfs[i];
      final fileName = '_$i.${pf.extension}';
      fileList.add(fileName);
    }

    //批量获取签名地址
    final signList = await signUrl(fileList);
    if (signList.isEmpty) {
      return null;
    }

    final download = <String>[];
    for (var i = 0; i < signList.length; i++) {
      final sign = signList[i];

      final flag = await uploadFile(
        signUrl: sign.upload,
        bytes: await pfs[i].bytes(),
      );
      if (!flag) {
        break;
      }
      uploadStep?.call(sign.download);
      download.add(sign.download);
    }

    return download;
  }
}
