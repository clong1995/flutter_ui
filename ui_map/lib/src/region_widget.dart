import 'dart:collection';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pinyin/pinyin.dart';

import '../region.dart' show Region;

class RegionWidget extends StatefulWidget {
  final String? region;
  final Future<String?> Function()? location;

  const RegionWidget({super.key, this.region, this.location});

  @override
  State<RegionWidget> createState() => _RegionWidgetState();
}

class _RegionWidgetState extends State<RegionWidget> {
  //使用link来存储省份和城市因为有重复
  List<String> link = []; //大写首拼音_地区名_编号
  String currCode = "";
  String jumpCode = ""; //用来高亮跳转到的

  LinkedHashSet<String> region = LinkedHashSet<String>();
  LinkedHashSet<String> code = LinkedHashSet<String>();

  LinkedHashSet<String> symbols = LinkedHashSet<String>();

  //{S:[S_山东省_156370000,S_山西省_156370000,],H:[H_湖南省_156370000,H_湖北省_156370000,],}
  Map<String, List<String>> data = {};

  bool canPop = true;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    readCsv().then((_) {
      if (widget.region != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          jumpTo(widget.region!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle bodyMedium =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle(fontSize: 13);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) {
        if (!didPop) {
          onBackTap();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading:
              canPop
                  ? TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "取消",
                      style: bodyMedium.copyWith(color: Colors.red),
                    ),
                  )
                  : TextButton(
                    onPressed: onBackTap,
                    child: Text(
                      "返回上级",
                      style: bodyMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
          actions:
              widget.location == null
                  ? null
                  : [
                    TextButton(
                      onPressed: onLocationPressed,
                      child: const Row(
                        children: [
                          Icon(Icons.location_searching, size: 14),
                          Text("定位"),
                        ],
                      ),
                    ),
                  ],
          title: Text(
            region.isEmpty ? "城市选择器" : "已选: ${region.join("/")}",
            style: bodyMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: AlphabetListView(
            scrollController: scrollController,
            items: data.entries.map(
              (e) => AlphabetListViewItemGroup(
                tag: e.key,
                children: e.value.asMap().entries.map((entry) {
                  List<String> arr = entry.value.split("_");
                  bool first = entry.key == 0;
                  bool last = entry.key == e.value.length - 1;
                  bool jump =
                      jumpCode.isNotEmpty && entry.value.endsWith(jumpCode);
                  return InkWell(
                    onTap: () {
                      onTap(arr[1], arr[2]);
                    },
                    child: Container(
                      color:
                          jump
                              ? Theme.of(context).primaryColor.withAlpha(20)
                              : null,
                      padding: EdgeInsets.fromLTRB(
                        10,
                        first ? 10 : 5,
                        0,
                        last ? 10 : 5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: RichText(
                          text: TextSpan(
                            text: arr[1],
                            style:
                                jump
                                    ? bodyMedium.apply(
                                      color: Theme.of(context).primaryColor,
                                    )
                                    : bodyMedium,
                            children:
                                _pm[arr[1]] == null
                                    ? null
                                    : <TextSpan>[
                                      TextSpan(
                                        text: " · ${_pm[arr[1]]}",
                                        style: bodyMedium.copyWith(
                                          color: const Color(0xFF9E9E9E),
                                          fontSize:
                                              (bodyMedium.fontSize ?? 13) - 1,
                                        ),
                                      ),
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
                listHeaderBuilder:
                    (BuildContext context, String symbol) => Container(
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
                symbolBuilder: (
                  BuildContext context,
                  String symbol,
                  AlphabetScrollbarItemState state,
                ) {
                  //active
                  TextStyle activeTxtStyle = bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  );
                  TextStyle inActiveTextStyle = bodyMedium.copyWith(
                    color: const Color(0xFF9E9E9E),
                  );
                  return Center(
                    child: Text(
                      symbol,
                      style:
                          state == AlphabetScrollbarItemState.active
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
          currCode ==
              "156310000" //上海
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
    if (data.isEmpty) {
      //最后一级
      return;
    }
    canPop = (currCode == "");
    setState(() {});
  }

  Future<void> readCsv() async {
    String content = await rootBundle.loadString(
      'packages/ui_map/csv/AdminCode.csv',
    );
    List<String> lines = content.split('\n');
    for (String row in lines) {
      if (row.startsWith("中国")) {
        continue;
      }
      List<String> arr = row.split(",-,");
      if (arr.length == 2) {
        String firstLetter = PinyinHelper.getFirstWordPinyin(arr[0]);
        link.add(
          "${firstLetter[0].trim().toUpperCase()}_${arr[0].trim()}_${arr[1].trim()}",
        );
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

  String getCode(String name) {
    return "";
  }

  void onTap(String name, String code) {
    if (code == currCode) {
      return;
    }
    loadUiData(name, code);
    if (data.isEmpty) {
      List<Region> list = [];
      for (var i = 0; i < region.length; i++) {
        list.add(
          Region()
            ..code = this.code.elementAt(i)
            ..name = region.elementAt(i),
        );
      }
      canPop = true;
      Navigator.pop<List<Region>>(context, list);
      return;
    }
  }

  void loadUiData(String name, String code) {
    currCode = code;
    region.add(name);
    this.code.add(code);
    loadData();
  }

  void onBackTap() {
    if (code.isEmpty) {
      return;
    }
    code.remove(code.last);
    region.remove(region.last);

    if (code.isNotEmpty) {
      currCode = code.last;
    } else {
      currCode = "";
    }
    loadData();
  }

  Future<void> onLocationPressed() async {
    if (widget.location == null) {
      return;
    }
    final region = await widget.location!();
    if (region == null) {
      return;
    }
    jumpTo(region);
  }

  void jumpTo(String region) {
    if (region.isEmpty) {
      return;
    }
    final arr = region.split("/");
    if (arr.isEmpty) {
      return;
    }

    String tempCode = "";
    for (var v in arr) {
      for (var v1 in link) {
        final brr = v1.split("_");
        if (brr.length != 3) {
          return;
        }
        final name = brr[1];
        final code = brr[2];
        if (v == name) {
          if (tempCode.isNotEmpty) {
            if (code.startsWith(tempCode)) {
              tempCode = code.replaceAll(RegExp(r'0+$'), '');
              //高亮
              jumpCode = code;
              loadUiData(name, code);
              continue;
            }
          } else {
            tempCode = code.replaceAll(RegExp(r'0+$'), '');
            loadUiData(name, code);
            continue;
          }
        }
      }
    }
    //退一级
    onBackTap();
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
