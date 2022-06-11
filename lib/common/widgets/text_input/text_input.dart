import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class TextInput extends StatelessWidget {
  final FieldState fieldState;
  final String? label;
  final Widget? prefix;
  final String? hint;
  final void Function(String)? onChange;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final EdgeInsets? contentPadding;

  const TextInput({
    Key? key,
    required this.fieldState,
    this.label,
    this.prefix,
    this.hint,
    this.onChange,
    this.border,
    this.focusedBorder,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: StatelessTextEditingControllerWrapper(
        value: fieldState.value,
        child: _buildTextFromField,
      ),
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
        prefixIcon: prefix,
        hintText: hint,
        border: focusedBorder,
        enabledBorder: focusedBorder,
        focusedBorder: focusedBorder,
        contentPadding: contentPadding,

      ),
    );
  }
}
