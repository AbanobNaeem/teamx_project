import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintTitle;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyType;
  final TextInputAction inputAction;
  final GestureTapCallback? tap;
  final FormFieldValidator<String>? validator;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon ;

  const CustomTextFormField({
    Key? key,
    required this.hintTitle,
    this.controller,
    required this.obscureText,
    required this.keyType,
    required this.inputAction,
    this.suffixIcon,
    this.tap,
    this.validator,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      onChanged: onChanged,
      initialValue: initialValue,
      keyboardType: keyType,
      textInputAction: inputAction,
      obscureText: obscureText,
      controller: controller,
      cursorColor: Colors.red,
       decoration:InputDecoration(
         suffixIcon: suffixIcon,
         contentPadding:  EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
         fillColor: Colors.white,
         filled: true,
         hintText: hintTitle,
         hintStyle: const TextStyle(
               color: Colors.grey,
               fontSize: 18.0,
          ),

         focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(25.0),
           borderSide: const BorderSide(
             color: Colors.red,
           ),
         ),
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(25.0),
           borderSide: const BorderSide(
             color: Colors.black,
             width: 2.0,
           ),
         ),
       ),






      validator: validator,
    );
  }
}
