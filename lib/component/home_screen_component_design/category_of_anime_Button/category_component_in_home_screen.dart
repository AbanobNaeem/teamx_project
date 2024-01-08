import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryOfAnime extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CategoryOfAnime({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.sp,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        children: [
          SizedBox(width: 10.sp),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  "Show all",
                  style: TextStyle(color: Colors.red, fontSize: 17.sp),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                  size: 22.sp,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
