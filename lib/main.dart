import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teamx_project/app_screen/home_screen.dart';

import 'package:teamx_project/login_and_register/login_screen.dart';



final FirebaseAuth firebaseAuth =FirebaseAuth.instance ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
     home:  firebaseAuth.currentUser==null? LoginScreen(): HomeScreen()
     //  home: AddDataInDataBase()



    );
  }
}
