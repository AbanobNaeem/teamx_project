import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DrawerButtons extends StatelessWidget {
  final Function() onTap;
  final String title;
  final IconData icon;

  const DrawerButtons({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20.sp),
          SizedBox(width: 10.sp),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 19.sp),
          ),
        ],
      ),
    );
  }
}
