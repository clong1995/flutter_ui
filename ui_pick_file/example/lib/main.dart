import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:picker/ui_pick_file.dart';

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
  List<PickerFile>? galleryMultiplePickerImage;

  //video
  PickerFile? cameraPickerVideo;
  PickerFile? gallerySinglePickerVideo;

  //file
  PickerFile? fileSinglePicker;
  List<PickerFile>? fileMultiplePicker;
  String? fileDirPicker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("相册图片操作："),
          // 通过拍照选取
          FilledButton.icon(
            icon: Icon(Icons.camera_alt_outlined),
            label: Text("通过拍照选取"),
            onPressed: () async {
              cameraPickerImage = await PickImage.camera();
              setState(() {});
            },
          ),
          if (cameraPickerImage != null) Text(cameraPickerImage!.path),
          // 单选: 选择相册图片
          FilledButton.icon(
            icon: Icon(Icons.image_outlined),
            label: Text("单选: 选择相册图片"),
            onPressed: () async {
              gallerySinglePickerImage = await PickImage.single();
              setState(() {});
            },
          ),
          if (gallerySinglePickerImage != null)
            Text(gallerySinglePickerImage!.path),
          // 多选: 选择相册图片
          FilledButton.icon(
            icon: Icon(Icons.photo_library_outlined),
            label: Text("多选: 选择相册图片"),
            onPressed: () async {
              galleryMultiplePickerImage = await PickImage.multiple();
              setState(() {});
            },
          ),
          if (galleryMultiplePickerImage != null)
            for (int i = 0; i < galleryMultiplePickerImage!.length; i++)
              Text(galleryMultiplePickerImage![i].path),
          // 保存图片到相册
          FilledButton.icon(
            icon: Icon(Icons.save),
            label: Text("保存图片到相册"),
            onPressed: () async {
              await PickImage.save(bytes: Uint8List(0));
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
              cameraPickerVideo = await PickVideo.camera();
              setState(() {});
            },
          ),
          if (cameraPickerVideo != null) Text(cameraPickerVideo!.path),

          // 单选: 选择相册视频
          FilledButton.icon(
            icon: Icon(Icons.video_file_outlined),
            label: Text("单选: 选择相册视频"),
            onPressed: () async {
              gallerySinglePickerVideo = await PickVideo.gallery();
              setState(() {});
            },
          ),
          if (gallerySinglePickerVideo != null)
            Text(gallerySinglePickerVideo!.path),
          // 保存视频到相册
          FilledButton.icon(
            icon: Icon(Icons.save),
            label: Text("保存视频到相册"),
            onPressed: () async {
              await PickVideo.save(bytes: Uint8List(0));
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
              PickFile.single().then((PickerFile? file) {
                fileSinglePicker = file;
                setState(() {});
              });
            },
          ),
          if (fileSinglePicker != null) Text(fileSinglePicker!.path),
          //多选: 选择任意文件
          FilledButton.icon(
            icon: Icon(Icons.file_copy_outlined),
            label: Text("多选: 选择任意文件"),
            onPressed: () {
              PickFile.multiple().then((List<PickerFile>? list) {
                fileMultiplePicker = list;
                setState(() {});
              });
            },
          ),
          if (fileMultiplePicker != null)
            for (int i = 0; i < fileMultiplePicker!.length; i++)
              Text(fileMultiplePicker![i].path),
          // 选择目录
          FilledButton.icon(
            icon: Icon(Icons.folder_open),
            label: Text("选择目录"),
            onPressed: () {
              PickFile.dir().then((String? p) {
                fileDirPicker = p;
                setState(() {});
              });
            },
          ),
          if (fileDirPicker != null) Text(fileDirPicker!),
          //保存文件
          FilledButton.icon(
            icon: Icon(Icons.save),
            label: Text("保存文件"),
            onPressed: () {
              PickFile.save(bytes: Uint8List(0));
            },
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
