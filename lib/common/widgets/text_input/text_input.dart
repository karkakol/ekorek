import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class TextInput extends StatelessWidget {
  final FieldState fieldState;
  final String? label;
  final Widget? prefix;

  const TextInput({
    Key? key,
    required this.fieldState,
    this.label,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      value: fieldState.value,
      child: _buildTextFromField,
    );
  }

  Widget _buildTextFromField(TextEditingController controller) {
    return TextFormField(
      onChanged: fieldState.onChanged,
      decoration: InputDecoration(labelText: label, prefix:prefix ),
    );
  }
}
