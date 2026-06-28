import 'package:flutter/material.dart';

class LongTextWidget extends StatelessWidget {
  final String? value;
  final void Function(String) onChanged;

  const LongTextWidget({super.key, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: 'Type your answer here',
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
