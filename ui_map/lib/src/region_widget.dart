import 'dart:collection';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pinyin/pinyin.dart';

import '../region.dart' show Region;

class RegionWidget extends StatefulWidget {
  const RegionWidget({super.key});

  @override
  State<RegionWidget> createState() => _RegionWidgetState();
}

class _RegionWidgetState extends State<RegionWidget> {
  //使用link来存储省份和城市因为有重复
  List<String> link = [];
  String currCode = "";

  LinkedHashSet<String> regin = LinkedHashSet<String>();
  LinkedHashSet<String> code = LinkedHashSet<String>();

  LinkedHashSet<String> symbols = LinkedHashSet<String>();

  //{S:[S_山东省_156370000,S_山西省_156370000,],H:[H_湖南省_156370000,H_湖北省_156370000,],}
  Map<String, List<String>> data = {};

  @override
  void initState() {
    super.initState();

    readCsv();
  }

  bool canPop = true;

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyMedium =
        Theme.of(context).textTheme.bodyMedium ?? TextStyle(fontSize: 13);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 90,
          leading: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              if (canPop)
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                )
              else ...[
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: onBackTap,
                  child: Text(
                    "返回上级",
                    style: bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ],
          ),
          title: Text(
            "城市选择器",
            style: bodyMedium,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: AlphabetListView(
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: RichText(
                          text: TextSpan(
                            text: arr[1],
                            style: bodyMedium,
                            children: _pm[arr[1]] == null
                                ? null
                                : <TextSpan>[
                                    TextSpan(
                                      text: " · ${_pm[arr[1]]}",
                                      style: bodyMedium.copyWith(
                                        color: Color(0xFF9E9E9E),
                                        fontSize:
                                            (bodyMedium.fontSize ?? 13) - 1,
                                      ),
                                    )
                                  ],
                          ),
                        ),
                      ),
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
                    style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              scrollbarOptions: ScrollbarOptions(
                symbols: symbols,
                symbolBuilder: (BuildContext context, String symbol,
                    AlphabetScrollbarItemState state) {
                  //active
                  TextStyle activeTxtStyle = bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  );
                  TextStyle inActiveTextStyle = bodyMedium.copyWith(
                    color: Color(0xFF9E9E9E),
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
      Match? match = regex.firstMatch(currCode);
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
      if (currCode == "156110000" || //北京
              currCode == "156120000" || //天津
              currCode == "156810000" || //香港
              currCode == "156310000" //上海
          ) {
        searchEnd = "";
      } else if (end == "0000") {
        //省
        searchEnd = "00";
      } else if (end == "00") {
        //市
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
            code_ != currCode) {
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
    canPop = (currCode == "");
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
    if (code == currCode) {
      return;
    }
    currCode = code;
    regin.add(name);
    this.code.add(code);
    if (!code.endsWith("0") || //最后一级行政区
            code == "156820000" || //特殊处理澳门
            (code.startsWith("15671") && !code.endsWith("0000")) //特殊处理台湾下的行政区
        ) {
      List<Region> list = [];
      for (var i = 0; i < regin.length; i++) {
        list.add(Region()
          ..code = this.code.elementAt(i)
          ..name = regin.elementAt(i));
      }
      canPop = true;
      Navigator.pop<List<Region>>(context, list);
      return;
    }
    loadData();
  }

  void onBackTap() {
    if (code.isEmpty) {
      return;
    }
    code.remove(code.last);
    regin.remove(regin.last);

    if (code.isNotEmpty) {
      currCode = code.last;
    } else {
      currCode = "";
    }
    loadData();
  }
}

Map<String, String> _pm = {
  "北京市": "京",
  "天津市": "津",
  "山西省": "晋",
  "湖南省": "湘",
  "江西省": "赣",
  "上海市": "沪",
  "重庆市": "渝",
  "河北省": "冀",
  "台湾省": "台",
  "辽宁省": "辽",
  "吉林省": "吉",
  "黑龙江省": "黑",
  "江苏省": "苏",
  "浙江省": "浙",
  "安徽省": "皖",
  "福建省": "闽",
  "山东省": "鲁",
  "河南省": "豫",
  "湖北省": "鄂",
  "青海省": "青",
  "广东省": "粤",
  "海南省": "琼",
  "四川省": "川/蜀",
  "贵州省": "黔/贵",
  "云南省": "滇/云",
  "陕西省": "陕/秦",
  "甘肃省": "甘/陇",
  "西藏自治区": "藏",
  "广西壮族自治区": "桂",
  "内蒙古自治区": "内蒙古",
  "宁夏回族自治区": "宁",
  "新疆维吾尔自治区": "新",
  "香港特别行政区": "港",
  "澳门特别行政区": "澳",
};
