import 'package:flutter/material.dart';

class MultiSelectWidget extends StatelessWidget {
  final List<String> options;
  final List<String> selected;
  final void Function(List<String>) onChanged;

  const MultiSelectWidget({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        final isSelected = selected.contains(option);
        return CheckboxListTile(
          title: Text(option),
          value: isSelected,
          onChanged: (_) {
            final updated = List<String>.from(selected);
            if (isSelected) {
              updated.remove(option);
            } else {
              updated.add(option);
            }
            onChanged(updated);
          },
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
        );
      }).toList(),
    );
  }
}
