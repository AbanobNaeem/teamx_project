
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/forget_password/cuibt/forget_password_cubit.dart';
import 'package:teamx_project/forget_password/cuibt/forget_password_state.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});


  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

bool bottomSendCode = false;

final emailController = TextEditingController();
final formKey = GlobalKey<FormState>();
final cubit = ForgetPasswordCubit();

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (context, state) {
          if(
          state is ForgetPasswordSendEmailSuccess){
          }
        },
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Container(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                              child: IconButton(onPressed: () {
                                backToLoginScreen();
                              },
                                  icon: Icon(Icons.arrow_back_ios_outlined,
                                    color: Colors.white,
                                    size: 20.sp,)),
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
                        child: textFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email required";
                              }
                              if (!value.contains("@") ||
                                  !value.contains(".")) {
                                return "Email invalid";
                              }
                              return null;
                            },
                            hintTitle: "E-mail",
                            controller: emailController,
                            obscureText: false,
                            keyType: TextInputType.emailAddress,
                            inputAction: TextInputAction.done),
                      ),
                      SizedBox(height: 20.sp,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Container(
                            height: 30.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  sendEmail();

                                },
                                child: Text(
                                  "Send A Code",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                ))),
                      ),


                    ],

                  ),
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
    String email = emailController.text ;
    cubit.sendCodeChangeThePassword(email: email);
  }
}
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.55, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(
        size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
  

