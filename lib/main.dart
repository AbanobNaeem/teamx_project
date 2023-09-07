import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/home_screen/screen/home_screen.dart';
import 'package:teamx_project/login/screen/login_screen.dart';



final FirebaseAuth firebaseAuth =FirebaseAuth.instance ;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   ResponsiveSizer(builder: (p0, p1, p2) {

     return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: firebaseAuth.currentUser == null ? LoginScreen() : HomeScreen()
        //  home: AddDataInDataBase()


      );
    },);


  }

  }