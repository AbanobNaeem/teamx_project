import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/login/screen/login_screen.dart';
import 'package:teamx_project/users_screens/edit_user_profile_screen/screen/edit_profile_user_screen.dart';
import 'package:teamx_project/users_screens/user_profile/cuibt/user_profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {

  final ImagePicker picker = ImagePicker();
  File? imageFile;
  String? firstName ;
  String? lastName ;
  String?  email ;
  String?  phone ;
  final FirebaseFirestore firestore = FirebaseFirestore.instance ;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance ;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance ;
  String imageUrl = "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit.getDataFromFireStore() ;


  }
  final cubit = UserProfileCubit();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => cubit..getDataFromFireStore(),
  child: BlocBuilder<UserProfileCubit,UserProfileStates>(
  builder: (context, state) {
    return BlocListener<UserProfileCubit, UserProfileStates>(
  listener: (context, state) {

  },
  child: Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: 50.sp,
            width: double.infinity,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.red.shade800, Colors.red.shade600, Colors.red.shade300],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 17.sp,right: 12.sp),
            child: InkWell(
              onTap: (){
                logout();
              },
              child: Row(
                children: [
                  Spacer(),
                  Text("Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp
                  ),),
                       SizedBox(width: 10.sp,),
                       Icon(
                          Icons.logout,
                        color: Colors.white,
                         size: 18.sp,
                      )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding:  EdgeInsets.only(top:30.sp,left: 10.sp,right: 10.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                     Padding(
                       padding:  EdgeInsets.only(left: 20.sp),
                       child: Row(
                         children: [
                           Stack(
                             alignment: Alignment.center,
                             children: [
                               CircleAvatar(
                                 backgroundColor: Colors.black,
                                 radius: 35.sp,
                               ),
                             imageFile == null ?
                             CircleAvatar(
                                radius: 33.sp,
                                backgroundImage: NetworkImage(cubit.data["imageUrl"]),
                              ):
                             CircleAvatar(
                                 radius: 33.sp,
                                 backgroundImage: FileImage(imageFile!),
                               ),
                             ],
                           ),
                           const SizedBox(width: 32,),
                          InkWell(
                            onTap: (){
                              navigatToEditUserScreen();
                            },
                            child: Row(
                              children: [
                                   Text(
                                  "Edit profile",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 20.sp
                                 ),),
                                 SizedBox(width: 10.sp,),
                                Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                size: 20.sp,)
                              ],
                            ),
                          ),
                         ],
                       ),
                     ),
                  SizedBox(height: 18.sp,),
                  userDataComponent(
                      name: "First Name / ${cubit.data["firstName"]} ",
                      icon: Icons.person),
                    userDataComponent(
                        name: "Last Name / ${cubit.data["lastName"]}",
                        icon: Icons.person),
                    userDataComponent(
                        name: "Email / ${cubit.data["email"]}",
                        icon: Icons.email_outlined),
                    userDataComponent(
                        name: "Phone / ${cubit.data["phone"]}",
                        icon: Icons.phone_outlined),
                    SizedBox(height: 15.sp,),
                    Container(
                        height: 33.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.red.shade800, Colors.red.shade600, Colors.red.shade300],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextButton(
                            onPressed: () {
                              navigateBack();
                            },
                            child: Text(
                              "Return Back",
                              style: TextStyle(color: Colors.white, fontSize: 20.sp),
                            ))),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
);
  },
),
);
  }


  void navigateBack() {
    Navigator.pop(context);
  }

  void navigatToEditUserScreen() {
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return EditProfile();
    }));
  }

  void logout() {
    firebaseAuth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}

