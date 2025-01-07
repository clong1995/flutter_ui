import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:picker/def.dart';
import 'package:picker/file.dart' as file;

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
  PickerFile? singleFile;
  List<PickerFile> multipleFile = [];
  String? pickerDir;
  String? saveOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("图片 和 任意文件选择器"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.icon(
              icon: Icon(Icons.image_outlined),
              label: Text("拍照"),
              onPressed: () {},
            ),
            FilledButton.icon(
              icon: Icon(Icons.image_outlined),
              label: Text("单选: 选择相册图片"),
              onPressed: () {},
            ),
            FilledButton.icon(
              icon: Icon(Icons.image_outlined),
              label: Text("多选: 选择相册图片"),
              onPressed: () {},
            ),
            FilledButton.icon(
              icon: Icon(Icons.save),
              label: Text("保存图片到相册"),
              onPressed: () {

              },
            ),
            FilledButton.icon(
              icon: Icon(Icons.description_outlined),
              label: Text("单选: 选择任意文件"),
              onPressed: () {
                file.single().then((PickerFile? file) {
                  setState(() {
                    singleFile = file;
                  });
                });
              },
            ),
            if (singleFile != null) Text(singleFile!.name),
            FilledButton.icon(
              icon: Icon(Icons.file_copy_outlined),
              label: Text("多选: 选择任意文件"),
              onPressed: () {
                file.multiple().then((List<PickerFile> list) {
                  setState(() {
                    multipleFile = list;
                  });
                });
              },
            ),
            for (int i = 0; i < multipleFile.length; i++)
              Text(multipleFile[i].name),
            FilledButton.icon(
              icon: Icon(Icons.folder_open),
              label: Text("选择目录"),
              onPressed: () {
                file.dir().then((String? p) {
                  setState(() {
                    pickerDir = p;
                  });
                });
              },
            ),
            if (pickerDir != null) Text(pickerDir!),
            FilledButton.icon(
              icon: Icon(Icons.save),
              label: Text("保存文件"),
              onPressed: () {
                file.save(bytes: Uint8List(0)).then((String? out) {
                  setState(() {
                    saveOut = out;
                  });
                });
              },
            ),
            if (saveOut != null) Text(saveOut!),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
