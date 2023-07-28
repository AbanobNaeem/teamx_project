import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teamx_project/component/component_of_screen.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
final emailController = TextEditingController();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child:SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children:[
                  Opacity(
                      opacity: 1,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: Colors.red[800],
                        height: 240,

                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.red[900],
                      height: 220,

                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45,right: 45),
                      child: Row(
                        children:  [
                          Expanded(
                            flex:1,
                            child: IconButton(onPressed: (){
                              backToLoginScreen();

                            },
                                icon:const Icon(Icons.arrow_back_ios_outlined,
                                color: Colors.white,)),
                          ),
                      const SizedBox(width: 5,),
                        const Expanded(
                            flex: 2,
                            child: Text("Forget Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25
                            ),),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            const  SizedBox(height: 20,),
             const  Text("Mail Address Here",
              style: TextStyle(
                color: Colors.red,
                fontSize: 25
              ),),
              const  SizedBox(height: 10,),
              const Text(
                "Enter the email address associated with your account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
                  textAlign: TextAlign.center,
              ),
             const  SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: textFormField(
                    hintTitle:"E-mail",
                    controller: emailController,
                    obscureText: false,
                    keyType: TextInputType.emailAddress,
                    inputAction:TextInputAction.done),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:15),
                child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                        onPressed: () {
                          sendCodeChangeThePassword();

                        },
                        child: const Text(
                          "Send A Code",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))),
              ),


            ],

          ),
        ),
      )

    );
  }

  void backToLoginScreen() {
    Navigator.pop(context);
  }

  void sendCodeChangeThePassword() {
    String email = emailController.text ;
    firebaseAuth.sendPasswordResetEmail(email: email);
    Navigator.pop(context);
    emailController.clear();

  }
  


}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    var firstStart = Offset(size.width/5,size.height );
    var firstEnd = Offset(size.width/2.55,size.height-50.0 );
    path.quadraticBezierTo(firstStart.dx, firstStart.dy,firstEnd.dx, firstEnd.dy);

   var secondStart = Offset(size.width-(size.width/3.24), size.height-105);
    var secondEnd = Offset(size.width,size.height-10);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy,secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
  

