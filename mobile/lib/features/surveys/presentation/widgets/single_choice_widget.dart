import 'package:flutter/material.dart';

class SingleChoiceWidget extends StatelessWidget {
  final List<String> options;
  final String? selected;
  final void Function(String?) onChanged;

  const SingleChoiceWidget({
    super.key,
    required this.options,
    this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        return RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: selected,
          onChanged: onChanged,
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }
}
