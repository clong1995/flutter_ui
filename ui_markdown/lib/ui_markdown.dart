import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class UiMarkdown extends StatelessWidget {

  const UiMarkdown(this.data, {super.key});
  final String data;

  @override
  Widget build(BuildContext context) => GptMarkdown(data);
}
