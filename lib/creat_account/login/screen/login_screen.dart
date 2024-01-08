import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:custom_signin_buttons/custom_signin_buttons.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/app_buttons_design/button_component.dart';
import 'package:teamx_project/component/app_buttons_design/outline_button_component.dart';
import 'package:teamx_project/component/app_buttons_design/text_button_component.dart';
import 'package:teamx_project/component/app_buttons_design/text_form_field_component.dart';
import 'package:teamx_project/component/designs_ovarall/snack_bar_component.dart';
import 'package:teamx_project/creat_account/forget_password/screen/forget_password.dart';
import 'package:teamx_project/creat_account/login/cubit/login_cubit.dart';
import 'package:teamx_project/creat_account/login/cubit/login_states.dart';
import 'package:teamx_project/creat_account/register/screen/register_screen.dart';
import 'package:teamx_project/home_screen/screen/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


final emailController = TextEditingController();
final passwordController = TextEditingController();
final cubit = LoginCubit();
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
          }else{
           showSnackBarOnError() ;
          }

        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: EdgeInsets.only(top: 20.sp, left: 15.sp, right: 15.sp),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset("assets/images/teamx_logo.jpg"),
                    SizedBox(height: 25.sp,),

                    CustomTextFormField(
                        controller: emailController,
                        hintTitle: "Email",
                        obscureText: false,
                        keyType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next),

                    SizedBox(height: 15.sp),

                   CustomTextFormField(
                       controller: passwordController,
                       hintTitle: "Password",
                       obscureText: obscure,
                       keyType: TextInputType.visiblePassword,
                       inputAction: TextInputAction.done),

                    SizedBox(height: 10.sp,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 4.sp,
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
                              color: Colors.red, fontSize: 17.5.sp),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.sp,),

                    CustomButton(
                        onPressed:(){
                          login() ;
                        },
                        text: "Login" ),
                    CustomTextButton(onPressed: (){
                      navigateToForgetPasswordScreen();
                    }, text: "Forget your password!"),

                    SizedBox(height: 12.sp,),
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
                    CustomOutlinedButton(
                        onPressed: (){
                          navigatToRegisterScreen();
                        }, text: "Register"),

                    SizedBox(height: 25.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SignInButton(
                          onPressed: () {},
                          height: 30.sp,
                          iconSize:25.sp,
                          button: Button.Facebook,
                          text: "Facebook",
                          textSize: 18.sp,
                          borderRadius: 20.sp,
                        ),
                        SizedBox(width: 12.sp,),
                        SignInButton(
                          onPressed: () {},
                          height: 30.sp,
                          iconSize:25.sp,
                          button: Button.Apple,
                          text: "Apple",
                          textSize: 18.sp,
                          borderRadius: 20.sp,
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigatToRegisterScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()
    ));
  }
  void navigateToForgetPasswordScreen() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()
        ));
  }
  void navigateToHomeScreen(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()
    ));
  }
  void showSnackBarOnError(){
    CustomSnackBar.show(
        context: context,
        title:"OH SORRY!" ,
        message:emailController.text.isEmpty || passwordController.text.isEmpty ?
        "You Should Write Your Information!" :
        "That Information Not Correct, Please Try Again ",
        contentTyp:ContentType.failure) ;
  }
  void login() {
    String email = emailController.text;
    String password =passwordController.text ;
    cubit.login(email: email, password: password);

  }

}
