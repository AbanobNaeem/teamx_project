
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/app_buttons_design/button_component.dart';
import 'package:teamx_project/component/designs_ovarall/wave_clipper_component.dart';
import 'package:teamx_project/component/user_profile_component/user_data_component.dart';
import 'package:teamx_project/users_screens/user_profile/cuibt/user_profile_cubit.dart';

class UserProfileScreenNew extends StatefulWidget {
  const UserProfileScreenNew({super.key});

  @override
  State<UserProfileScreenNew> createState() => _UserProfileScreenNewState();
}

class _UserProfileScreenNewState extends State<UserProfileScreenNew> {
  String defaultImageUrl = "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png";
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final cubit = UserProfileCubit();

  @override
  void initState() {
    cubit.getDataFromFireStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit..getDataFromFireStore(),
      child: BlocBuilder<UserProfileCubit, UserProfileStates>(
        builder: (context, state) {
          if (state is GetUserDataFromFireStoreSuccessState) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                width: double.infinity,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 35.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Opacity(
                              opacity: 1,
                              child: ClipPath(
                                clipper: WaveClipper(),
                                child: Container(
                                  color: Colors.red[800],
                                  height: 57.sp,

                                ),
                              ),
                            ),
                            ClipPath(
                              clipper: WaveClipper(),
                              child: Container(
                                color: Colors.red[900],
                                height: 55.sp,

                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.sp),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Center(
                                    child:CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 38.sp,
                                    ),
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: (){
                                        pickImage() ;
                                      },
                                      child: CircleAvatar(
                                        radius: 35.sp,
                                        backgroundImage: cubit.data['imageUrl'] == null
                                            ? NetworkImage(defaultImageUrl)
                                            : NetworkImage(
                                            "${cubit.data['imageUrl']}"),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.sp,),
                        Text(
                          "${cubit.data["firstName"]}${cubit.data["lastName"]}",
                          style: TextStyle(
                              color: Colors.red[900],
                              fontSize: 26
                          ),),
                        Text("${cubit.data["email"]}",
                          style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 16
                          ),),
                        SizedBox(height: 33.sp,),
                        UserDataComponent(
                            labelText: "Phone Number ",
                            userData: "${cubit.data["phone"]}",
                            icon: Icons.phone),
                        const SizedBox(height: 20,),
                        UserDataComponent(
                            labelText: "Subscriber Id",
                            userData: "${cubit.data["subscriberId"]}",
                            icon: Icons.person),
                        const SizedBox(height: 20,),
                        const UserDataComponent(
                          labelText: "Package Details",
                          userData: "Basic",
                          icon: Icons.monetization_on,),
                        const Spacer(),
                        CustomButton(
                            width: 200,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: "Back")


                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }


  void pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      imageFile = File(image.path);
      setState(() {});
      uploadFile();
    }
  }

  void uploadFile() {
    String userId = firebaseAuth.currentUser!.uid;
    firebaseStorage.ref("images/$userId").putFile(imageFile!).then((p0) {
      getImageUrl();
    }).catchError((error) {});
  }

  void getImageUrl() {
    String userId = firebaseAuth.currentUser!.uid;
    firebaseStorage.ref("images/$userId").getDownloadURL().then((imageUrl) {
      saveImageUrlInFireStore(imageUrl);
    }).catchError((error) {});
  }

  void saveImageUrlInFireStore(String imageUrl) {
    String userId = firebaseAuth.currentUser!.uid;
    Map<String, dynamic> data = {
      "imageUrl": imageUrl
    };
    firestore.collection("userData").doc(userId).update(data);
  }



}
