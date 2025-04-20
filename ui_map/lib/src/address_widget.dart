import 'dart:async';

import 'package:flutter/material.dart';
import '../distance.dart';

import '../address.dart';

class AddressWidget extends StatefulWidget {
  final Future<List<Address>> Function(String keyword) datasource;
  final Future<List<double>?> Function()? location;

  const AddressWidget({super.key, required this.datasource, this.location});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  final BorderSide borderSide = const BorderSide(color: Colors.grey);
  final double height = 40;
  TextEditingController controller = TextEditingController();

  List<Address> list = [];
  List<double>? lonLat;
  Timer? debounce;
  int lastRequestTime = 0;

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      widget.location!().then((value) {
        lonLat = value;
      });
    }
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
      appBar: AppBar(title: const Text("搜索地址")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: height,
              child: TextField(
                controller: controller,
                cursorHeight: height - 8 * 2,
                maxLines: 1,
                autofocus: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  prefixIconConstraints: BoxConstraints(
                    maxWidth: height,
                    minWidth: height,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: borderSide.copyWith(
                      color: borderSide.color.withAlpha(124),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(borderSide: borderSide),
                  contentPadding: const EdgeInsets.symmetric(
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
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(153, 153, 153, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  Address address = list[index];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => onAddressTap(address),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 10, 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Center(child: Text("${index + 1}")),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        address.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      if (widget.location != null)
                                        const Icon(
                                          Icons.route,
                                          size: 14,
                                          color: Color(0xFF757575),
                                        ),
                                      if (widget.location != null)
                                        Text(
                                          "${getDistance(address.lonLat)} km",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF757575),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(address.address),
                                ],
                              ),
                            ),
                            Text(
                              address.typeName,
                              style: const TextStyle(color: Color(0xFF9E9E9E)),
                            ),
                          ],
                        ),
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

  void onInputChanged() {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 300), () async {
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

  String getDistance(List<double> lonLat) {
    if (this.lonLat == null) {
      return "";
    }
    return (distance(this.lonLat!, lonLat) / 1000).toStringAsFixed(2);
  }

  void onAddressTap(Address address) {
    Navigator.pop<Address?>(context, address);
  }
}
