import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle textStyle;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle = const TextStyle(color: Colors.red, fontSize: 17.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
