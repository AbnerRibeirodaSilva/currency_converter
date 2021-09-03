import 'package:flutter/material.dart';

import 'package:currency_convert/themes/app_colors.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double buttonWidth;
  final TextStyle? style;
  const LabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.buttonWidth,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: buttonWidth,
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.35),
              spreadRadius: 5,
              blurRadius: 9,
              offset: Offset(0, 3),
            ),
          ]),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              letterSpacing: 1.9,
              fontSize: 17,
            ),
          )),
    );
  }
}
