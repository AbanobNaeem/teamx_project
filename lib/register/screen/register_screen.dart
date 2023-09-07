import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/register/cubit/register_cubit.dart';
import 'package:teamx_project/register/cubit/register_states.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final phoneController = TextEditingController();
final emailController = TextEditingController();
final passwordController = TextEditingController();
final formKey = GlobalKey<FormState>();
final cubit = RegisterCubit();
final FirebaseAuth firebaseAuth =FirebaseAuth.instance ;

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocListener<RegisterCubit,RegisterStates>(
        listener: (context, state) {
          if(state is RegisterSuccessState){
            addUserDataOnFireStore();

          }
          if(state is RegisterFailureState){
            print('error in register in ${state.errorMessage}');
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset("assets/images/teamx_logo.jpg"),
                      SizedBox(
                        height: 15.sp,
                      ),
                      textFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            if (value.contains(RegExp(r'[0-9]'))) {
                              return 'Name should not contain numbers';
                            }
                            return null;
                          },
                          hintTitle: " First Name",
                          controller: firstNameController,
                          obscureText: false,
                          keyType: TextInputType.name,
                          inputAction: TextInputAction.next),
                      SizedBox(
                        height: 10.sp,
                      ),
                      textFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                            if (value.contains(RegExp(r'[0-9]'))) {
                              return 'Name should not contain numbers';
                            }
                            return null;
                          },
                          hintTitle: " Last Name",
                          controller: lastNameController,
                          obscureText: false,
                          keyType: TextInputType.name,
                          inputAction: TextInputAction.next),
                      SizedBox(
                        height: 10.sp,
                      ),
                      textFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          hintTitle: " Phone Number",
                          controller: phoneController,
                          obscureText: false,
                          keyType: TextInputType.phone,
                          inputAction: TextInputAction.next),
                      SizedBox(
                        height: 10.sp,
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
                          hintTitle: " E-mail",
                          controller: emailController,
                          obscureText: false,
                          keyType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next),
                      SizedBox(
                        height: 10.sp,
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
                          hintTitle: " Password",
                          controller: passwordController,
                          obscureText: true,
                          keyType: TextInputType.visiblePassword,
                          inputAction: TextInputAction.done),
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
                            register();
                          },
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.sp),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      TextButton(
                          onPressed: () {
                            navigateToLoginScreen();
                          },
                          child: Text(
                            "I Already Have An Account",
                            style: TextStyle(color: Colors.red,
                                fontSize: 17.sp),
                          ))
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

  void navigateToLoginScreen() {
    Navigator.pop(context);
  }

  void register() {
    if (!formKey.currentState!.validate()) {
      return;
    }
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
      lastName: lastName);
    Navigator.pop(context);
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
  }

}
