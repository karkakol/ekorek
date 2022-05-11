import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool isLoading;
  final bool enabled;

  const Button({
    Key? key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled ? Colors.blueAccent : Colors.blueGrey,
      elevation: 2,
      child: InkWell(
        onTap: isLoading || !enabled ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading ? _buildLoader() : _buildText(),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildLoader() {
    return SizedBox.square(
      dimension: 15,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
  }
}
