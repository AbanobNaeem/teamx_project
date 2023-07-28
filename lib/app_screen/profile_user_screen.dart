import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamx_project/app_screen/edit_profile_user_screen.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/login_and_register/forget_password.dart';

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
  String imageUrl = "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromFireStore();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.red.shade800, Colors.red.shade600, Colors.red.shade300],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top:90,left: 10,right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                     Padding(
                       padding: const EdgeInsets.only(left: 20),
                       child: Row(
                         children: [
                           Stack(
                             alignment: Alignment.center,
                             children: [
                             const   CircleAvatar(
                                 backgroundColor: Colors.black,
                                 radius: 80,
                               ),
                             imageFile == null ?
                             CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(imageUrl),
                              ):
                             CircleAvatar(
                                 radius: 70,
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
                              children: const [
                                   Text(
                                  "Edit profile",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 20
                                 ),),
                                 SizedBox(width: 10,),
                                Icon(
                                  Icons.edit,color: Colors.white,)
                              ],
                            ),
                          ),
                         ],
                       ),
                     ),
                 const SizedBox(height: 30,),
                  userDataComponent(
                      name: "First Name / ${firstName} ",
                      icon: Icons.person),
                    userDataComponent(
                        name: "Last Name / ${lastName}",
                        icon: Icons.person),
                    userDataComponent(
                        name: "Email / ${email}",
                        icon: Icons.email_outlined),
                    userDataComponent(
                        name: "Phone / ${phone}",
                        icon: Icons.phone_outlined),
                    SizedBox(height: 15,),
                    Container(
                        height: 60,
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
                            child: const Text(
                              "Return Back",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ))),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }










  void getDataFromFireStore() async {
    String userId = firebaseAuth.currentUser!.uid;
   await firestore.collection("userData").doc(userId).snapshots().listen((value) {
     updateUi(value.data());
   });
  }
  void updateUi(Map<String, dynamic>? data) {
    setState(() {
      if (data!.containsKey("imageUrl")){
        imageUrl = data["imageUrl"];
      }
      if (data.containsKey("firstName")){
        firstName= data["firstName"];
      }
      if (data.containsKey("lastName")){
        lastName= data["lastName"];
      }
      if (data.containsKey("email")){
        email = data["email"];
      }
      if (data.containsKey("phone")){
        phone = data["phone"];
      }

    });


  }


  void navigateBack() {
    Navigator.pop(context);
  }

  void navigatToEditUserScreen() {
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return EditProfile();
    }));
  }
}

