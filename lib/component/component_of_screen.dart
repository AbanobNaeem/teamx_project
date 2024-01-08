import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';






Widget userDataComponent({
  required String name,
  required IconData icon ,
  
}){
  return Padding(
    padding: EdgeInsets.only(left: 10.sp,right: 10.sp,bottom: 20.sp),
    child: Container(
      height: 35.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red.shade800, Colors.red.shade600, Colors.red.shade300],
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.only(right: 15.sp),
        child: Row(
          children: [
            SizedBox(width: 10.sp,),
            Expanded(
              child: Text(name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp
                ),),
            ),
            Icon(icon,
              color: Colors.white,
            size: 20.sp,)


          ],
        ),
      ),
    ),
  );
}
