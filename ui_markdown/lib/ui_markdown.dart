import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class UiMarkdown extends StatelessWidget {
  final String data;

  const UiMarkdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) => GptMarkdown(data);
}
