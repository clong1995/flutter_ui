import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:picker/def.dart';
import 'package:picker/file.dart' as picker_file;
import 'package:picker/image.dart' as picker_image;
import 'package:picker/video.dart' as picker_video;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //image
  PickerFile? cameraPickerImage;
  PickerFile? gallerySinglePickerImage;
  List<PickerFile> galleryMultiplePickerImage = [];

  //video
  PickerFile? cameraPickerVideo;
  PickerFile? gallerySinglePickerVideo;

  //file
  PickerFile? fileSinglePicker;
  List<PickerFile> fileMultiplePicker = [];
  String? fileDirPicker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("相册图片操作："),
            // 通过拍照选取
            FilledButton.icon(
              icon: Icon(Icons.camera_alt_outlined),
              label: Text("通过拍照选取"),
              onPressed: () async {
                cameraPickerImage = await picker_image.camera();
              },
            ),
            if (cameraPickerImage != null) Text(cameraPickerImage!.path),
            // 单选: 选择相册图片
            FilledButton.icon(
              icon: Icon(Icons.image_outlined),
              label: Text("单选: 选择相册图片"),
              onPressed: () async {
                gallerySinglePickerImage = await picker_image.single();
              },
            ),
            if (gallerySinglePickerImage != null)
              Text(gallerySinglePickerImage!.path),
            // 多选: 选择相册图片
            FilledButton.icon(
              icon: Icon(Icons.photo_library_outlined),
              label: Text("多选: 选择相册图片"),
              onPressed: () async {
                galleryMultiplePickerImage = await picker_image.multiple();
              },
            ),
            for (int i = 0; i < galleryMultiplePickerImage.length; i++)
              Text(galleryMultiplePickerImage[i].path),
            // 保存图片到相册
            FilledButton.icon(
              icon: Icon(Icons.save),
              label: Text("保存图片到相册"),
              onPressed: () async {
                await picker_image.save(bytes: Uint8List(0));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text("相册视频操作："),
            // 通过录像选取
            FilledButton.icon(
              icon: Icon(Icons.video_camera_back_outlined),
              label: Text("通过录像选取"),
              onPressed: () async {
                cameraPickerVideo = await picker_video.camera();
              },
            ),
            if (cameraPickerVideo != null) Text(cameraPickerVideo!.path),

            // 单选: 选择相册视频
            FilledButton.icon(
              icon: Icon(Icons.video_file_outlined),
              label: Text("单选: 选择相册视频"),
              onPressed: () async {
                gallerySinglePickerVideo = await picker_video.single();
              },
            ),
            if (gallerySinglePickerVideo != null)
              Text(gallerySinglePickerVideo!.path),
            // 保存视频到相册
            FilledButton.icon(
              icon: Icon(Icons.save),
              label: Text("保存视频到相册"),
              onPressed: () async {
                await picker_video.save(bytes: Uint8List(0));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text("任意文件操作："),
            //单选: 选择任意文件
            FilledButton.icon(
              icon: Icon(Icons.description_outlined),
              label: Text("单选: 选择任意文件"),
              onPressed: () {
                picker_file.single().then((PickerFile? file) {
                  setState(() {
                    fileSinglePicker = file;
                  });
                });
              },
            ),
            if (fileSinglePicker != null) Text(fileSinglePicker!.path),
            //多选: 选择任意文件
            FilledButton.icon(
              icon: Icon(Icons.file_copy_outlined),
              label: Text("多选: 选择任意文件"),
              onPressed: () {
                picker_file.multiple().then((List<PickerFile> list) {
                  setState(() {
                    fileMultiplePicker = list;
                  });
                });
              },
            ),
            for (int i = 0; i < fileMultiplePicker.length; i++)
              Text(fileMultiplePicker[i].path),
            // 选择目录
            FilledButton.icon(
              icon: Icon(Icons.folder_open),
              label: Text("选择目录"),
              onPressed: () {
                picker_file.dir().then((String? p) {
                  setState(() {
                    fileDirPicker = p;
                  });
                });
              },
            ),
            if (fileDirPicker != null) Text(fileDirPicker!),
            //保存文件
            FilledButton.icon(
              icon: Icon(Icons.save),
              label: Text("保存文件"),
              onPressed: () {
                picker_file.save(bytes: Uint8List(0));
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
