import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;


  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0.sp,
      width: width,
      decoration: BoxDecoration(
        color: Colors.red.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 19.0.sp),
        ),
      ),
    );
  }
}
