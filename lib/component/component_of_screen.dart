import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


Widget suggestionsItem(BuildContext context ,
    { required numberOfChapters,required  name,required image, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Row(
      children: [
        Card(
          shadowColor: Colors.red,
          margin:  EdgeInsets.only( bottom: 10.sp, right: 10.sp, left: 10.sp,top: 10.sp),
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
                    padding:  EdgeInsets.only(left: 10.sp, top: 12.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        ),
                        Text(
                          "recommended",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp),
                        ),
                         SizedBox(height: 38.sp,),
                         Text(
                          "Name of writer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp),
                        ),
                        Text(
                          numberOfChapters,
                          maxLines: 1,
                          style:  TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp),
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

Widget animeItem(BuildContext context ,
    { required numberOfChapters,required  name,required image, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding:  EdgeInsets.only(top: 10.sp, bottom: 10.sp, right: 5.sp, left: 5.sp),
      child: Card(
        shadowColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        elevation: 10,
        child: Container(
          width: 50.sp,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Image.network(
                  image,
                  width: 50.sp,
                  height: 55.sp,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 6.sp, top: 5.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white, fontSize: 18.sp),
                    ),
                    Text(
                      numberOfChapters,
                      style: TextStyle(
                          color: Colors.grey[300], fontSize: 15.sp),
                    ),
                     SizedBox(height: 10.sp,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                           Icon(
                            Icons.star_border_outlined,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                          SizedBox(width: 5.sp,),
                           Text(
                            "3.9",
                            style: TextStyle(color: Colors.white,
                            fontSize: 15.sp),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    ),
  );
}



Widget textFormField({
  required String hintTitle,
  required TextEditingController controller,
  required bool obscureText,
  required TextInputType keyType,
  required TextInputAction inputAction,
  GestureTapCallback? tap,
   required FormFieldValidator<String>? validator

}
){
  return Padding(
    padding:  EdgeInsets.only(left:10.sp,right: 10.sp),
    child: TextFormField(
      keyboardType: keyType,
      textInputAction: inputAction,
      obscureText: obscureText,
      controller: controller,
      cursorColor: Colors.red,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          borderSide:const  BorderSide(
            color: Colors.white
          )),

          contentPadding:  EdgeInsets.symmetric(vertical: 22.sp, horizontal: 10.0.sp),
          fillColor: Colors.white,
          filled: true,
          hintText: hintTitle,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white
            )
          ),
          hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 18.sp
          )
      ),
      validator: validator,
    ),

  );


}
Widget drawerComponent({
  required VoidCallback tap ,
  required String  title ,
  required IconData icons,
}){
  return InkWell(
    onTap: tap,
    child: Row(
      children:  [
        Expanded(
          child: Text(title,
            style:  TextStyle(
                color: Colors.white,
                fontSize: 19.sp,
                fontWeight: FontWeight.bold
            ),),
        ),
        Icon(icons,
          color: Colors.white,
          size: 18.sp,)

      ],
    ),
  );
}


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
