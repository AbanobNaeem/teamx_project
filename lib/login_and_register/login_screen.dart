import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teamx_project/app_screen/home_screen.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/login_and_register/forget_password.dart';
import 'package:teamx_project/login_and_register/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final emailController = TextEditingController();
final passwordController = TextEditingController();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance ;
bool obscure = true;
bool chickBox = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top:50,left: 15,right: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset("images/teamx_logo.jpg"),
                const SizedBox(
                  height: 20,
                ),
                textFormField(
                    keyType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    hintTitle: " E-mail",
                    controller: emailController,
                    obscureText: false),
                const SizedBox(
                  height: 10,
                ),
                textFormField(
                    keyType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done,
                    hintTitle: " password",
                    controller: passwordController,
                    obscureText: obscure),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        side: const BorderSide(color: Colors.red),
                        activeColor: Colors.red,
                        value: chickBox,
                        onChanged: (value) {
                          chickBox = !chickBox;
                          obscure = !obscure;
                          setState(() {});
                        }),
                    const Text(
                      "Show password",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                        onPressed: () {
                          login();
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))),
                TextButton(
                  onPressed: () {
                    navigateToForgetPasswordScreen();
                  },
                  child: const Text(
                    "Forget your password!",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
               const  SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Expanded(
                        child: Divider(
                      color: Colors.red,
                      height: 10,
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Sign up with",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Divider(
                      color: Colors.red,
                      height: 10,
                    )),
                  ],
                ),
               const  SizedBox(height: 20,),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
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
                          child: const Text(
                            "Register",
                            style:
                            TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                   const  SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: OutlinedButton(
                          onPressed: () {

                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(color: Colors.red)),
                          ),
                          child: const Text(
                            "Gmail",
                            style:
                            TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigatToRegisterScreen() {
    Navigator.push(context,MaterialPageRoute(builder:(context){
      return const RegisterScreen();
    }));
  }

  void login(){
    String email = emailController.text ;
    String password  = passwordController.text ;
    firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password).then((value){
          Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){
         return    HomeScreen();
          }));
          emailController.clear();
          passwordController.clear();

    }).catchError((error){
      print("error in login is ${error}");
    });
  }

  void navigateToForgetPasswordScreen() {
    Navigator.push(context,MaterialPageRoute(builder: (context)=> const ForgetPasswordScreen()
    ));
  }
}
