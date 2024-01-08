import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_signin_buttons/custom_signin_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/app_buttons_design/button_component.dart';
import 'package:teamx_project/component/app_buttons_design/text_button_component.dart';
import 'package:teamx_project/component/app_buttons_design/text_form_field_component.dart';
import 'package:teamx_project/component/designs_ovarall/snack_bar_component.dart';
import 'package:teamx_project/creat_account/register/cubit/register_cubit.dart';
import 'package:teamx_project/creat_account/register/cubit/register_states.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth firebaseAuth =FirebaseAuth.instance ;
  final cubit = RegisterCubit();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            showSnackBarOnSuccess();
            addUserDataOnFireStore();
          }else{
            showSnackBarOnError();
          }

        },
        child: Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding:  EdgeInsets.only(top: 15.sp, left: 15.sp, right: 15.sp),
              child: Column(
                children: [
                  Image.asset("assets/images/teamx_logo.jpg"),
                  SizedBox(height: 20.sp),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                            controller: firstNameController,
                            hintTitle: "First Name",
                            obscureText: false,
                            keyType: TextInputType.name,
                            inputAction: TextInputAction.next),
                      ),
                      SizedBox(width: 12.sp,),
                      Expanded(
                        child: CustomTextFormField(
                            controller: lastNameController,
                            hintTitle: "Last Name ",
                            obscureText: false,
                            keyType: TextInputType.name,
                            inputAction: TextInputAction.next),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.sp,),
                  CustomTextFormField(
                      controller: phoneController,
                      hintTitle: "Phone Number ",
                      obscureText: false,
                      keyType: TextInputType.phone,
                      inputAction: TextInputAction.next),
                  SizedBox(height: 15.sp,),

                  CustomTextFormField(
                      controller: emailController,
                      hintTitle: "Email",
                      obscureText: false,
                      keyType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next),

                  SizedBox(height: 15.sp),

                  CustomTextFormField(
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              obscureText =! obscureText ;
                            });
                          }, icon: obscureText == true ?
                         const  Icon(Icons.visibility_outlined,color: Colors.black,):
                         const  Icon(Icons.visibility_off_outlined,color: Colors.black,)
                      ),
                      controller: passwordController,
                      hintTitle: "Password",
                      obscureText: obscureText,
                      keyType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.next),
                  SizedBox(height: 20.sp),
                  CustomButton(
                      onPressed: (){
                        register();
                      }, text: "Sign Up"),

                  SizedBox(height: 5.sp),
                  CustomTextButton(
                      onPressed: (){
                        navigateToLoginScreen();
                      }, text: "I already have an account"),

                  SizedBox(height: 10.sp,),
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
                        "Or With",
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
    );
  }

  void navigateToLoginScreen() {
    Navigator.pop(context);
  }

  void register() {
    String email = emailController.text;
    String password = passwordController.text;
    cubit.register(email: email, password: password);
  }

  void addUserDataOnFireStore() {
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    cubit.addUserDataOnFireStore(
        email: email,
        password: password,
        phone: phone,
        firstName: firstName,
        lastName: lastName,
    );
    Navigator.pop(context);
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
  }

  void showSnackBarOnError(){
    CustomSnackBar.show(
        context: context,
        title: "OH SORRY!",
        contentTyp: ContentType.failure,
        message: (
            emailController.text.isEmpty ||
            passwordController.text.isEmpty ||
            firstNameController.text.isEmpty ||
            lastNameController.text.isEmpty ?
            "You Should Write All Your Information " :
            "That Information Not Correct, Please Try Again"
        )
    );
  }
  void showSnackBarOnSuccess(){
    CustomSnackBar.show(
      context: context,
      title: "SUCCESS",
      message: "Email Created Successfully",
      contentTyp: ContentType.success,
    );
  }
}
