import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/home_screen/screen/home_screen.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/forget_password/screen/forget_password.dart';
import 'package:teamx_project/login/cubit/login_cubit.dart';
import 'package:teamx_project/login/cubit/login_states.dart';
import 'package:teamx_project/register/screen/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
final cubit = LoginCubit();

final formKey = GlobalKey<FormState>();

bool obscure = true;
bool chickBox = false;

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<LoginCubit,LoginStates>(
        listener: (context, state) {

          if(state is LoginSuccessState){
            navigateToHomeScreen();
          }
          if(state is LoginFailureState){
            print('error is ${state.errorMessage}');
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: EdgeInsets.only(top: 20.sp, left: 15.sp, right: 15.sp),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset("assets/images/teamx_logo.jpg"),
                      SizedBox(
                        height: 20.sp,
                      ),
                      textFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email required";
                            }
                            if (!value.contains("@") || !value.contains(".")) {
                              return "Email invalid";
                            }
                            return null;
                          },
                          keyType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          hintTitle: " E-mail",
                          controller: emailController,
                          obscureText: false),
                      SizedBox(
                          height: 10.sp
                      ),
                      textFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password required ";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },
                        keyType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.done,
                        hintTitle: " password",
                        controller: passwordController,
                        obscureText: obscure,),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Transform.scale(
                            scale: 3.5.sp,
                            child: Checkbox(
                                side: const BorderSide(color: Colors.red),
                                activeColor: Colors.red,
                                value: chickBox,
                                onChanged: (value) {
                                  chickBox = !chickBox;
                                  obscure = !obscure;
                                  setState(() {});
                                }),
                          ),
                          Text(
                            "Show password",
                            style: TextStyle(
                                color: Colors.red, fontSize: 17.sp),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Container(
                          height: 30.sp,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                              onPressed: () {
                                login();
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
                              ))),
                      TextButton(
                        onPressed: () {
                          navigateToForgetPasswordScreen();
                        },
                        child: Text(
                          "Forget your password!",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17.sp
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                                color: Colors.red,
                                height: 10.sp,
                              )),
                          SizedBox(
                            width: 20.sp,
                          ),
                          Text(
                            "Sign up with",
                            style: TextStyle(color: Colors.red,
                                fontSize: 16.sp),
                          ),
                          SizedBox(
                            width: 20.sp,
                          ),
                          Expanded(
                              child: Divider(
                                color: Colors.red,
                                height: 10.sp,
                              )),
                        ],
                      ),
                      SizedBox(height: 20.sp,),
                      Container(
                        width: double.infinity,
                        height: 30.sp,
                        child: OutlinedButton(
                          onPressed: () {
                            navigatToRegisterScreen();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(color: Colors.red)),
                          ),
                          child: Text(
                            "Register",
                            style:
                            TextStyle(color: Colors.red, fontSize: 20.sp),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigatToRegisterScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const RegisterScreen();
    }));
  }
  void navigateToForgetPasswordScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()
        ));
  }
  void navigateToHomeScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HomeScreen()
        ));
  }
  void login() {
    String email = emailController.text;
    String password =passwordController.text ;
    if(!formKey.currentState!.validate()){
      return;
    }
    cubit.login(email: email, password: password);
    emailController.clear();
    passwordController.clear();
  }
}
