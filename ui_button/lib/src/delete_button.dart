import 'package:flutter/material.dart';

class DeleteButton<T> extends StatelessWidget {
  const DeleteButton({
    required this.title,
    required this.value,
    super.key,
    this.onTap,
  });

  final String title;
  final T value;
  final void Function(T)? onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final Widget child = Container(
      constraints: const BoxConstraints(minHeight: 24),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          Text(title, style: TextStyle(color: color)),
          const SizedBox(width: 5),
          IconButton(
            onPressed: onTap == null ? null : () => onTap!(value),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
    return onTap == null ? Opacity(opacity: .5, child: child) : child;
  }
}
