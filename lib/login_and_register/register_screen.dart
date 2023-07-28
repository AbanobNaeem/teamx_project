
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/login_and_register/login_screen.dart';


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



class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("images/teamx_logo.jpg"),
                const SizedBox(height: 25,),
                textFormField(
                    hintTitle: " First Name",
                    controller: firstNameController,
                    obscureText: false,
                    keyType: TextInputType.name,
                    inputAction: TextInputAction.next),
                const SizedBox(height: 10,),
                textFormField(
                    hintTitle: " Last Name",
                    controller: lastNameController,
                    obscureText: false,
                    keyType: TextInputType.name,
                    inputAction: TextInputAction.next),
                const SizedBox(
                  height: 10,
                ),
                textFormField(
                    hintTitle: " Phone Number",
                    controller: phoneController,
                    obscureText: false,
                    keyType: TextInputType.phone,
                    inputAction: TextInputAction.next),
                const SizedBox(
                  height: 10,
                ),
                textFormField(
                    hintTitle: " E-mail",
                    controller: emailController,
                    obscureText: false,
                    keyType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next),
                const SizedBox(
                  height: 10,
                ),
                textFormField(
                    hintTitle: " Password",
                    controller: passwordController,
                    obscureText: true,
                    keyType: TextInputType.visiblePassword,
                    inputAction: TextInputAction.done),
                const SizedBox(
                  height: 20,
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
                      register();
                    },
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                TextButton(
                    onPressed: (){
                      navigateToLoginScreen();
                    },
                    child: const Text(
                      "I Already Have An Account",
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ))
              ],
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
    String password= passwordController.text;
    firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
          addUserDataOnFireStore();
          Navigator.pop(context ,MaterialPageRoute(builder: (context){
            return const LoginScreen();
          }));
          emailController.clear();
          passwordController.clear() ;
          firstNameController.clear() ;
          lastNameController.clear();
          phoneController.clear();

    }).catchError((error){
      print('error in register is ${error}');
    });

  }
  void addUserDataOnFireStore(){
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneController.text;
    String firstName  = firstNameController.text ;
    String lastName =lastNameController.text;
    String userId = firebaseAuth.currentUser!.uid;
    Map<String ,dynamic> data ={
      "id" : userId,
      "phone"  : phone,
      "email" : email,
      "password": password,
      "firstName" : firstName,
      "lastName":lastName,

    };
    firestore.collection("userData").doc(userId).set(data).then((value){
      Navigator.pop(context);
    }).catchError((error){
      print('error is ${error}');
    });


  }
}
