import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pinyin/pinyin.dart';

class RegionWidget extends StatefulWidget {
  const RegionWidget({super.key});

  @override
  State<RegionWidget> createState() => _RegionWidgetState();
}

class _RegionWidgetState extends State<RegionWidget> {
  //使用link来存储省份和城市因为有重复
  List<String> link = [];

  List<String> regin = [];
  String code = "";

  List<String> symbols = [];
  Map<String, List<String>> data = {};

  @override
  void initState() {
    super.initState();
    readCsv();
  }

  //山东省,-,156370000
  //青岛市,-,156370200
  //黄岛区,-,156370211

  //北京市,-,156110000
  //丰台区,-,156110106
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("城市选择器"),
      ),
      body: AlphabetListView(
        items: data.entries.map(
          (e) => AlphabetListViewItemGroup(
            tag: e.key,
            children: e.value.map((v) {
              return Text(v);
            }),
          ),
        ),
        options: AlphabetListViewOptions(
          listOptions: ListOptions(),
          scrollbarOptions: ScrollbarOptions(
            symbols: symbols,
          ),
        ),
      ),
    );
  }

  void loadData() {
    symbols.clear();
    data.clear();
    for (String e in link) {
      if (code.isEmpty) {
        if (e.contains("0000")) {
          String tag = e[0];
          symbols.add(tag);
          if (data[tag] == null) {
            data[tag] = [e];
          } else {
            data[tag]!.add(e);
          }
        }
      }
    }
    setState(() {});
  }

  Future<void> readCsv() async {
    String content =
        await rootBundle.loadString('packages/ui_map/csv/AdminCode.csv');
    List<String> lines = content.split('\n');
    for (String row in lines) {
      if (row.startsWith("中国")) {
        continue;
      }
      List<String> arr = row.split(",-,");
      if (arr.length == 2) {
        String firstLetter = PinyinHelper.getFirstWordPinyin(arr[0]);
        link.add("${firstLetter[0].toUpperCase()}_${arr[0]}-${arr[1]}");
      }
    }
    RegExp regExp = RegExp(r'(\d+)');
    link.sort((a, b) {
      // 提取首字母并转为大写
      String firstLetterA = a[0];
      String firstLetterB = b[0];

      // 如果首字母不同，按首字母排序
      if (firstLetterA != firstLetterB) {
        return firstLetterA.compareTo(firstLetterB);
      }

      // 如果首字母相同，按数字排序
      int numA = int.parse(regExp.firstMatch(a)!.group(0)!);
      int numB = int.parse(regExp.firstMatch(b)!.group(0)!);
      return numA.compareTo(numB);
    });
    loadData();
  }
}
