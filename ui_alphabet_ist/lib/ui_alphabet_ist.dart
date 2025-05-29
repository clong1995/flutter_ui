import 'dart:collection';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:pinyin/pinyin.dart';

class UiAlphabetList<T> extends StatefulWidget {
  final Map<String, T> data; //key会作为排序的依据，仅支持数字、字母、汉字
  final Widget Function(T) builder;

  const UiAlphabetList({super.key, required this.data, required this.builder});

  @override
  State<UiAlphabetList<T>> createState() => _UiAlphabetListState<T>();
}

class _UiAlphabetListState<T> extends State<UiAlphabetList<T>> {
  @override
  Widget build(BuildContext context) {
    TextStyle bodyMedium =
        Theme.of(context).textTheme.bodyMedium ?? const TextStyle(fontSize: 13);
    if (widget.data.isEmpty) {
      return const SizedBox.shrink();
    }
    SplayTreeMap<String, List<T>> data = loadData();
    return AlphabetListView(
      items: data.keys.map(
            (e) => AlphabetListViewItemGroup(
          tag: e,
          children: (data[e] ?? [])
              .map((T e) => widget.builder(e))
              .toList(growable: false),
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
          symbols: data.keys,
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
    );
  }

  SplayTreeMap<String, List<T>> loadData() {
    SplayTreeMap<String, T> sortedMap = SplayTreeMap();
    widget.data.forEach((String key, T value) {
      String str = PinyinHelper.getShortPinyin(key);
      sortedMap[str] = value;
    });

    SplayTreeMap<String, List<T>> data = SplayTreeMap();
    sortedMap.forEach((String key, T value) {
      String k = key[0];
      k = k.toUpperCase();
      data.putIfAbsent(k, () => []);
      data[k]!.add(value);
    });
    return data;
  }
}
