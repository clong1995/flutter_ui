import 'dart:async';

import 'package:flutter/material.dart';

import '../address.dart';

class AddressWidget extends StatefulWidget {
  final Future<List<Address>> Function(String keyword) datasource;

  const AddressWidget({
    super.key,
    required this.datasource,
  });

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final BorderSide borderSide = const BorderSide(color: Colors.grey);
  final double height = 40;
  TextEditingController controller = TextEditingController();

  List<Address> list = [];
  Timer? debounce;
  int lastRequestTime = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(onInputChanged);
  }

  @override
  void dispose() {
    debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("搜索地址"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: height,
              child: TextField(
                controller: controller,
                cursorHeight: height - 8 * 2,
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: height,
                    minWidth: height,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: borderSide.copyWith(
                        color: borderSide.color.withAlpha(124)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: borderSide,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  suffixIcon: IconButton(
                    onPressed: controller.clear,
                    icon: Icon(
                      Icons.clear,
                      color: const Color(0xFF9E9E9E),
                      size: height / 2,
                    ),
                  ),
                  fillColor: Colors.white,
                  hoverColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "输入名称或地址",
                  hintStyle: TextStyle(
                    color: const Color.fromRGBO(153, 153, 153, 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  Address address = list[index];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 8),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 10, 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: Text("${index + 1}"),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  address.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  address.address,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            address.typeName,
                            style: TextStyle(
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onInputChanged(){
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(Duration(milliseconds: 300), () async {
      String text = controller.text.trim();
      if (text.isNotEmpty) {
        int currentRequestTime = DateTime.now().millisecondsSinceEpoch;
        lastRequestTime = currentRequestTime;
        List<Address> l = await widget.datasource(text);
        if (lastRequestTime == currentRequestTime) {
          setState(() {
            list = l;
          });
        }
      }
    });
  }
}
