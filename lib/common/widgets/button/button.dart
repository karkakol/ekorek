import 'package:ekorek/config/app_colors.dart';
import 'package:ekorek/config/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool isLoading;
  final bool enabled;
  final bool expanded;

  const Button({
    Key? key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
    this.enabled = true,
    this.expanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accentColor,
                    AppColors.primaryColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: InkWell(
                onTap: isLoading || !enabled ? null : onTap,
                child: SizedBox(
                  width: expanded ? double.infinity : null,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: isLoading ? _buildLoader() : _buildText(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      text,
      style: AppText.button,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoader() {
    return SpinKitCircle(
      color: Colors.white,
      size: 30,
    );
  }
}
