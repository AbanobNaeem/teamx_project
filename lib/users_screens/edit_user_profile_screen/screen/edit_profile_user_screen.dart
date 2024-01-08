import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/app_buttons_design/text_form_field_component.dart';
import 'package:teamx_project/users_screens/edit_user_profile_screen/cuibt/edit_user_profile_cubit.dart';




class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker picker = ImagePicker();
  File? imageFile;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String imageUrl =
      "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png";
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    cubit.getDataFromFireStore();
  }

  final cubit = EditUserProfileCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<EditUserProfileCubit, EditUserProfileStates>(
        builder: (context, state) {
          if (state is GetDataFromFireStoreSuccessState || state is UpdateUserImageSuccessState) {
            String firstName = cubit.data["firstName"];
            String lastName = cubit.data["lastName"];
            String email = cubit.data["email"];
            String phoneNumber = cubit.data["phone"];
            return Scaffold(
              backgroundColor: Colors.black,
              body: Stack(
                children: [
                  Container(
                    height: 51.sp,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.red.shade800,
                          Colors.red.shade600,
                          Colors.red.shade300
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(top: 32.sp, right: 12.sp),
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20.sp),
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.black,
                                          radius: 35.sp,
                                        ),
                                        imageFile == null
                                            ? CircleAvatar(
                                          radius: 33.sp,
                                          backgroundImage: NetworkImage(
                                              cubit.data["imageUrl"]),
                                        )
                                            : CircleAvatar(
                                          radius: 33.sp,
                                          backgroundImage: FileImage(
                                              imageFile!),
                                        ),
                                      ],
                                    ),

                                    SizedBox(width: 10.sp),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            pickImage();
                                          },
                                          child: Text(
                                            "Change profile picture",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                        SizedBox(width: 10.sp),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.sp),
                              CustomTextFormField(
                              controller: firstNameController,
                              hintTitle: firstName,
                              obscureText: false,
                              keyType: TextInputType.name,
                              inputAction: TextInputAction.next),

                              SizedBox(height: 10.sp),
                              CustomTextFormField(
                                  controller: lastNameController,
                                  hintTitle: lastName,
                                  obscureText: false,
                                  keyType: TextInputType.name,
                                  inputAction: TextInputAction.next),

                              SizedBox(height: 10.sp),
                              CustomTextFormField(
                                  controller: emailController,
                                  hintTitle:  email,
                                  obscureText: false,
                                  keyType: TextInputType.emailAddress,
                                  inputAction: TextInputAction.next),

                              SizedBox(height: 10.sp),
                              CustomTextFormField(
                                  controller: phoneController,
                                  hintTitle: phoneNumber,
                                  obscureText: false,
                                  keyType: TextInputType.phone,
                                  inputAction: TextInputAction.done),
                              SizedBox(height: 20.sp),
                              Container(
                                  height: 30.sp,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.red.shade800,
                                        Colors.red.shade600,
                                        Colors.red.shade300
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                      onPressed: () {
                                        updateUserData(
                                            firstName: firstName,
                                            lastName: lastName,
                                            phoneNumber: phoneNumber,
                                            email: email);
                                      },
                                      child: Text(
                                        "Save Changes",
                                        style:
                                        TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
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
      cubit.uploadFile(imageFile: imageFile);
    }
  }


  void navigatBack() {
    Navigator.pop(context);
  }

  void updateUserData({
    required firstName,
    required lastName,
    required phoneNumber,
    required email
  }) {
    cubit.editUserData(
        firstName: firstNameController.text == ""
            ? firstName
            : firstNameController.text,
        lastName: lastNameController.text == "" ? lastName : lastNameController
            .text,
        email: emailController.text == "" ? email : emailController.text,
        phone: phoneController.text == "" ? phoneNumber : phoneController.text);
    Navigator.pop(context);
  }

}


