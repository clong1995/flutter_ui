import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';
import 'logic.dart';

class CPage extends StatelessWidget {
  const CPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("列表中的精准刷新"),
      ),
      body: Column(
        children: [
          const Text(
              "列表场景下，每条数据会形成一行UI，每条数据一般都会带有id。\n当列表中行数量发生变化时候，无可避免的要刷新整个列表。\n但当行内变化时候，只刷新本行即可。"),
          const Text("例子："),
          Expanded(
            child: StateWidget(
              logic: CLogic(context),
              builder: (logic) => Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: logic.state.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        Item item = logic.state.list[index];
                        return ListTile(
                          title: Text("姓名：${item.name}，ID：${item.id}"),
                          //======= 精准刷新的组件 ========//
                          subtitle: logic.builder(
                            id: item.id, //业务id可唯一标识这一行UI和这一条数据
                            builder: () => Text("薪水：${item.salary}"),
                          ),
                          //============================//
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //加薪水
                              IconButton(
                                onPressed: () => logic.onModifyPressed(item.id),
                                icon: const Icon(
                                  Icons.add,
                                ),
                              ),
                              //删除
                              IconButton(
                                onPressed: () => logic.onRemovePressed(item.id),
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: logic.onAddPressed,
                    child: const Text("增加一个Tom老师"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
