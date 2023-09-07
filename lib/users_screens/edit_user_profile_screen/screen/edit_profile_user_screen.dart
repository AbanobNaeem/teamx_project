import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/component_of_screen.dart';



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
    getDataFromFireStore();


  }
  @override
  Widget build(BuildContext context) {
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
                                  backgroundImage: NetworkImage(imageUrl),
                                )
                                    : CircleAvatar(
                                  radius: 33.sp,
                                  backgroundImage: FileImage(imageFile!),
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
                      SizedBox(height: 10.sp),
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
                      SizedBox(height: 10.sp),
                      textFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email required";
                            }
                            if (!value.contains("@") ||
                                !value.contains(".")) {
                              return "Email invalid";
                            }
                            return null;
                          },
                          hintTitle: " E-mail",
                          controller: emailController,
                          obscureText: false,
                          keyType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next),
                      SizedBox(height: 10.sp),
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
                          hintTitle: " phone Number",
                          controller: phoneController,
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
                                editUserData();
                              },
                              child: Text(
                                "Save Changes",
                                style:
                                TextStyle(
                                    color: Colors.white, fontSize: 20.sp),
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
    Map<String, dynamic> data = {"imageUrl": imageUrl};

    firestore.collection("userData").doc(userId).update(data);
  }

  void navigatBack() {
    Navigator.pop(context);
  }

  void editUserData() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final userId = firebaseAuth.currentUser!.uid;
    String editedFirstName = firstNameController.text;
    String editedLastName = lastNameController.text;
    String editedEmail = emailController.text;
    String editedPhone = phoneController.text;

    Map<String, dynamic> data = {
      "firstName": editedFirstName,
      "lastName": editedLastName,
      "email": editedEmail,
      "phone": editedPhone,
    };

    firestore.collection("userData").doc(userId).update(data).then((value) {
      if (editedEmail != emailController) {
        Navigator.pop(context);
      } else {
        updateEmail(editedEmail);
      }
    }).catchError((error) {
      print('error when update data in ${error}');
    });
  }

  void updateEmail(String newEmail) async {
    try {
      final userId = FirebaseAuth.instance.currentUser;

      if (userId != null) {
        await userId.updateEmail(newEmail);
        await userId.sendEmailVerification();
        print("Email updated successfully!");
      } else {
        print("User is not signed in.");
      }
    } catch (e) {
      print("Error updating email: $e");
    }
  }

  void getDataFromFireStore() async {
    String userId = firebaseAuth.currentUser!.uid;
    await firestore.collection("userData").doc(userId).get().then((value) {
      updateUi(value.data());
    }).catchError((error) {
      print(error);
    });
  }

  void updateUi(Map<String, dynamic>? data) {
    setState(() {
      firstNameController.text = data?["firstName"];
      lastNameController.text = data?["lastName"];
      emailController.text = data?["email"];
      phoneController.text = data?["phone"];
      if (data!.containsKey("imageUrl")) {
        imageUrl = data["imageUrl"];
      }
    });
  }


}
