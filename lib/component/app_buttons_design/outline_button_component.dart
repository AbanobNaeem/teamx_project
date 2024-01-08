import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30.0.sp,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: Colors.red),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.red, fontSize: 19.0.sp),
        ),
      ),
    );
  }
}
