import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/app_buttons_design/button_component.dart';
import 'package:teamx_project/component/app_buttons_design/text_form_field_component.dart';
import 'package:teamx_project/component/designs_ovarall/wave_clipper_component.dart';
import 'package:teamx_project/component/designs_ovarall/snack_bar_component.dart';
import 'package:teamx_project/creat_account/forget_password/cuibt/forget_password_cubit.dart';
import 'package:teamx_project/creat_account/forget_password/cuibt/forget_password_state.dart';




class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}




class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailController = TextEditingController();
  final cubit = ForgetPasswordCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if (state is ForgetPasswordSendEmailSuccess) {
            snackBarSuccess();
          } else {
            snackBarOnError();
          }
        },
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: 1,
                          child: ClipPath(
                            clipper: WaveClipper(),
                            child: Container(
                              color: Colors.red[800],
                              height: 55.sp,

                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            color: Colors.red[900],
                            height: 52.sp,

                          ),
                        ),
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.sp,
                                left: 10.sp,
                                right: 10.sp),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                               const  CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.black,
                                ),
                                IconButton(
                                    onPressed: () {
                                  backToLoginScreen();
                                },
                                    icon: Icon(Icons.arrow_back_ios_outlined,
                                      color: Colors.red,
                                      size: 20.sp,)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.sp,),
                    Text("Mail Address Here",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 25.sp
                      ),),
                    SizedBox(height: 10.sp,),
                    Text(
                      "Enter the email address associated with your account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21.sp
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.sp,),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: CustomTextFormField(
                            controller: emailController,
                            hintTitle: "Email",
                            obscureText: false,
                            keyType: TextInputType.emailAddress,
                            inputAction: TextInputAction.done)
                    ),
                    SizedBox(height: 20.sp,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: CustomButton(
                          onPressed: () {
                            sendEmail();
                          }, text: "Send Code"),
                    )

                  ],

                ),
              ),
            )

        ),
      ),
    );
  }

  void backToLoginScreen() {
    Navigator.pop(context);
    emailController.clear();
  }

  void sendEmail() {
    String email = emailController.text;
    cubit.sendCodeChangeThePassword(email: email);
  }

  void snackBarOnError() {
    CustomSnackBar.show(
      context: context,
      title: 'OH SORRY!',
      message: 'Your Email Address Not Correct',
      contentTyp: ContentType.failure
    );
  }
   void snackBarSuccess(){
    CustomSnackBar.show(
        context: context,
        title: "SUCCESS",
        message: "Check Your Email",
        contentTyp: ContentType.success,
    );
   }

}

