import 'package:ekorek/common/widgets/dropdown/use_dropdown_state.dart';
import 'package:flutter/material.dart';

class Dropdown<T> extends StatelessWidget {
  final DropdownState<T> state;
  final Widget Function(T)? itemBuilder;
  final String? label;

  const Dropdown({
    Key? key,
    required this.state,
    this.itemBuilder,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) Text(label!),
          DropdownButton<T>(
            value: state.value,
            icon: const Icon(Icons.arrow_drop_down_rounded),
            elevation: 4,
            onChanged: (value) => value != null ? state.onChanged(value) : null,
            items: state.items.map((e) => _buildItem(e)).toList(),
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<T> _buildItem(T item) {
    return DropdownMenuItem<T>(
      value: item,
      child: itemBuilder != null ? itemBuilder!(item) : Text(item.toString()),
    );
  }
}
