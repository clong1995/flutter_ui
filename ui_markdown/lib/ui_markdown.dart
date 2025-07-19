import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class UiMarkdown extends StatelessWidget {
  final String data;

  const UiMarkdown(this.data,{super.key});

  @override
  Widget build(BuildContext context) => GptMarkdown(data);
}
