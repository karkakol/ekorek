import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class TextInput extends StatelessWidget {
  final FieldState fieldState;
  final String? label;
  final Widget? prefix;
  final String? hint;
  final void Function(String)? onChange;

  const TextInput({
    Key? key,
    required this.fieldState,
    this.label,
    this.prefix,
    this.hint,
    this.onChange,
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
      onChanged: (value) {
        fieldState.onChanged(value);
        onChange?.call(value);
      },
      decoration: InputDecoration(
        labelText: label,
        prefix: prefix,
        hintText: hint,
      ),
    );
  }
}
