import 'dart:collection';

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

  LinkedHashSet<String> regin = LinkedHashSet<String>();
  String code = "";

  LinkedHashSet<String> symbols = LinkedHashSet<String>();

  //{S:[S_山东省_156370000,S_山西省_156370000,],H:[H_湖南省_156370000,H_湖北省_156370000,],}
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
            children: e.value.asMap().entries.map((entry) {
              List<String> arr = entry.value.split("_");
              bool first = entry.key == 0;
              bool last = entry.key == e.value.length - 1;
              return InkWell(
                onTap: () {
                  onTap(arr[1], arr[2]);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    10,
                    first ? 10 : 5,
                    0,
                    last ? 10 : 5,
                  ),
                  child: Text(arr[1]),
                ),
              );
            }),
          ),
        ),
        options: AlphabetListViewOptions(
          listOptions: ListOptions(
            listHeaderBuilder: (BuildContext context, String symbol) =>
                Container(
              padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
              color: const Color(0xFFEEEEEE),
              child: Text(
                symbol,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          scrollbarOptions: ScrollbarOptions(
            symbols: symbols,
            symbolBuilder: (BuildContext context, String symbol,
                AlphabetScrollbarItemState state) {
              //active
              TextStyle activeTxtStyle = TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              );
              TextStyle inActiveTextStyle = TextStyle(
                color: Colors.grey,
              );
              return Center(
                child: Text(
                  symbol,
                  style: state == AlphabetScrollbarItemState.active
                      ? activeTxtStyle
                      : inActiveTextStyle,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void loadData() {
    symbols.clear();
    data.clear();
    if (code.isEmpty) {
      for (String e in link) {
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
    } else {
      RegExp regex = RegExp(r'(\d+?)(0+)$');
      Match? match = regex.firstMatch(code);
      if (match == null || match.groupCount != 2) {
        return;
      }
      String? start = match.group(1);
      String? end = match.group(2);
      if (start == null || end == null) {
        return;
      }

      String searchEnd = "";
      //特殊省
      if (code == "156110000" || //北京
              code == "156120000" || //天津
              code == "156810000" || //香港
              code == "156310000" //上海
          ) {
        searchEnd = "";
      } else if (end == "0000") { //省
        searchEnd = "00";
      } else if (end == "00") { //市
        searchEnd = "";
      } else {
        //最后一级
        return;
      }
      for (String e in link) {
        List<String> arr = e.split("_");
        String code_ = arr[2];
        if (code_.startsWith(start) &&
            code_.endsWith(searchEnd) &&
            code_ != code) {
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
        link.add(
            "${firstLetter[0].trim().toUpperCase()}_${arr[0].trim()}_${arr[1].trim()}");
      }
    }
    RegExp regex = RegExp(r'(\d+)');
    link.sort((a, b) {
      // 提取首字母
      String firstLetterA = a[0];
      String firstLetterB = b[0];

      // 如果首字母不同，按首字母排序
      if (firstLetterA != firstLetterB) {
        return firstLetterA.compareTo(firstLetterB);
      }

      // 如果首字母相同，按数字排序
      int numA = int.parse(regex.firstMatch(a)!.group(0)!);
      int numB = int.parse(regex.firstMatch(b)!.group(0)!);
      return numA.compareTo(numB);
    });
    loadData();
  }

  void onTap(String name, String code) {
    if(code == this.code){
      return;
    }
    this.code = code;
    regin.add(name);
    if (!code.endsWith("0")) {
      Navigator.pop(context);
      print(regin.join("/"));
      print(code);
      return;
    }
    loadData();
  }
}
//156370300
//156370303
//北京市,-,156110000
//朝阳区,-,156110105
//淄博市,-,156370300
//张店区,-,156370303