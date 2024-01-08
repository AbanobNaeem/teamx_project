import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AnimeSuggestionItem extends StatelessWidget {
  final String name;
  final String image;
  final String numberOfChapters;
  final VoidCallback onTap;

  const AnimeSuggestionItem({
    required this.name,
    required this.image,
    required this.numberOfChapters,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Card(
            shadowColor: Colors.red,
            margin: EdgeInsets.only(
              bottom: 10.sp,
              right: 10.sp,
              left: 10.sp,
              top: 10.sp,
            ),
            color: Colors.black,
            elevation: 10.sp,
            child: Container(
              width: 80.sp,
              child: Row(
                children: [
                  Image.network(
                    image,
                    height: 60.sp,
                    width: 47.sp,
                    alignment: Alignment.center,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.sp, top: 12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            "recommended",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          SizedBox(height: 38.sp),
                          Text(
                            "Name of writer",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ),
                          Text(
                            numberOfChapters,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
