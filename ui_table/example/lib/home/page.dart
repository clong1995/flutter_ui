import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';
import 'package:ui_table/ui_table.dart';

import 'widget/cell/cell.dart';
import 'widget/columns.dart';

class HomePage extends StatelessWidget {
  final Object? arg;

  const HomePage({super.key, this.arg});

  @override
  Widget build(BuildContext context) {
    List<double> cellsWidth = [
      90.r,
      120.r,
      100.r,
      100.r,
      100.r,
      300.r,
      300.r,
      300.r,
      300.r,
      120.r,
      280.r,
      280.r,
      280.r,
      100.r,
    ];

    final data = List.generate(50, (row) {
      if (row == 0) {
        return [
          const HeaderCell(content: '姓名'),
          const HeaderCell(content: '学号'),
          const HeaderCell(content: '身高'),
          const HeaderCell(content: '性别'),
          const HeaderCell(content: '身体状况'),
          _buildScoreHeader("第一次月考成绩", ["语文", "数学", "英语", "科学", "总分"]),
          _buildScoreHeader("期中统考成绩", ["语文", "数学", "英语", "科学", "总分"]),
          _buildScoreHeader("第三次月考成绩", ["语文", "数学", "英语", "科学", "总分"]),
          _buildScoreHeader("期末统考成绩", ["语文", "数学", "英语", "科学", "总分"]),
          const HeaderCell(content: '特长生/\n准特长生'),
          _buildAwardsHeader(),
          ComplexHeader(title: '班干履历', subColumns: cadresColumns),
          const HeaderCell(content: '班主任评价'),
          const HeaderCell(content: '操作'),
        ];
      } else {
        return List.generate(14, (col) {
          if (col == 0) return BodyCell(content: "王小明 $row");
          if (col == 1) return _buildStudentNumber();
          if (col == 2) return _buildHeight();
          if (col == 3) return _buildGender();
          if (col == 4) return _buildHealth();
          if (col == 5) {
            return _buildScoreBodyCell();
          } else if (col == 6) {
            return _buildScoreBodyCell();
          } else if (col == 7) {
            return _buildScoreBodyCell();
          } else if (col == 8) {
            return _buildScoreBodyCell();
          }
          if (col == 9) {
            // 特长生，准特长生。
            return _buildSpeciality();
          }
          if (col == 10) {
            return _buildAwardsBody(
                [ColumInfo(title: '类目'), ColumInfo(title: '名称等级', flex: 2)]);
          }
          if (col == 11) {
            return _buildCadresBody();
          }
          if (col == 12) {
            return _buildRemark();
          }
          if (col == 13) {
            return SizedBox(
              width: 30.r,
              height: 20.r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("修改"),
                  ),
                ],
              ),
            );
          }
          return Text("${String.fromCharCode(col + 65)} $row,$col");
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("学生管理"),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: UiTable(
                cellsWidth: cellsWidth,
                headerHeight: 80.r,
                cellHeight: 40,
                data: data,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 获奖header
  Widget _buildAwardsHeader() {
    return ComplexHeader(title: '白名单获奖', subColumns: [
      ColumInfo(title: '类目'),
      ColumInfo(title: '名称等级', flex: 2),
    ]);
  }

  Widget _buildAwardsBody(List<ColumInfo> columns) {
    int r = Random().nextInt(10);
    String category = "";
    String content = "";

    if (r < 3) {
      category = "人文科学";
      content = "全国青少年文化遗产知识大赛-等奖";
    }
    return ComplexBodyCell(columns: columns, values: [category, content]);
  }

  Widget _buildScoreBodyCell() {
    List<int> originScores = [
      Random().nextInt(100),
      Random().nextInt(100),
      Random().nextInt(100),
      Random().nextInt(100),
    ];
    int total = originScores.reduce((a, b) => a + b);
    List<int> scores = originScores.expand((s) => [s, -1]).toList()..add(total);

    return BodyCell(
      child: Row(
        children: [
          ...scores.map((s) {
            if (s == -1) {
              return Container(
                width: .5,
                color: Colors.black87,
              );
            }
            return Flexible(
                flex: 1,
                child: Center(
                  child: Text(s.toString()),
                ));
          })
        ],
      ),
    );
  }

  Widget _buildStudentNumber() {
    return const Center(
      child: Text("1214001013"),
    );
  }

  Widget _buildScoreHeader(
    String title,
    List<String> subjects,
  ) {
    return ComplexHeader(
        title: title,
        subColumns: [...subjects.map((s) => ColumInfo(title: s))]);
  }

  Widget _buildHeight() {
    List<String> heights = ["中等", '偏高', '偏低'];
    List<Color> colors = [Colors.orange, Colors.red, Colors.blue];
    int index = Random().nextInt(3);
    return Center(
        child: Text(heights[index], style: TextStyle(color: colors[index])));
  }

  Widget _buildGender() {
    List<String> gender = ["男", '女'];
    List<MaterialColor> colors = [Colors.blue, Colors.pink];
    List<Icon> genderIcons = [
      Icon(Icons.male, color: colors[0]),
      Icon(Icons.female, color: colors[1])
    ];
    int index = Random().nextInt(2);
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(gender[index], style: TextStyle(color: colors[index])),
        genderIcons[index]
      ],
    ));
  }

  Widget _buildHealth() {
    int index = Random().nextInt(30);
    if (index == 18) {
      return const Center(
          child: Text(
        "体弱",
        style: TextStyle(color: Colors.orange),
      ));
    }
    return const Center(
        child: Text(
      "健康",
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    ));
  }

  Widget _buildSpeciality() {
    int index = Random().nextInt(30);
    if (index < 3) {
      return BodyCell(
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(4.r)),
            padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 5.r),
            child: const Text(
              "体育",
              style: TextStyle(color: Colors.red),
            )),
      );
    } else if (index > 9 && index < 11) {
      return BodyCell(
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.pink),
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(4.r)),
            padding: EdgeInsets.symmetric(vertical: 2.r, horizontal: 5.r),
            child: const Text(
              "音乐",
              style: TextStyle(color: Colors.red),
            )),
      );
    }
    return const BodyCell(
      content: '',
    );
  }

  Widget _buildCadresBody() {
    String yesOrNo = "否";
    String position = "";
    int r = Random().nextInt(20);
    if (r < 5) {
      yesOrNo = "是";
      position = "副班长";
    }
    return ComplexBodyCell(columns: cadresColumns, values: [yesOrNo, position]);
  }

  Widget _buildRemark() {
    final remarks = ['组织力强', '活泼好动，热爱劳动', '音乐天赋'];
    int index = Random().nextInt(3);
    return BodyCell(content: remarks[index]);
  }
}
