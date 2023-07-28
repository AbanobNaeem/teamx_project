import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamx_project/component/component_of_screen.dart';

import '../login_and_register/forget_password.dart';

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
  String imageUrl =
      "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png";
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  void initState() {
    // TODO: implement initState
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
            height: 200,
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
              padding: const EdgeInsets.only(top: 90, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 80,
                              ),
                              imageFile == null
                                  ? CircleAvatar(
                                      radius: 70,
                                      backgroundImage: NetworkImage(imageUrl),
                                    )
                                  : CircleAvatar(
                                      radius: 70,
                                      backgroundImage: FileImage(imageFile!),
                                    ),
                            ],
                          ),

                          const SizedBox(
                                  width: 10,
                                ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: const Text(
                                        "Change profile picture",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    textFormField(
                        hintTitle: " First Name",
                        controller: firstNameController,
                        obscureText: false,
                        keyType: TextInputType.name,
                        inputAction: TextInputAction.next),
                    const SizedBox(
                      height: 10,
                    ),
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
                        hintTitle: " E-mail",
                        controller: emailController,
                        obscureText: false,
                        keyType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormField(
                        hintTitle: " phone Number",
                        controller: phoneController,
                        obscureText: false,
                        keyType: TextInputType.phone,
                        inputAction: TextInputAction.done),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 60,
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
                            child: const Text(
                              "Save Changes",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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

  void navigatBack() {
    Navigator.pop(context);
  }

  void editUserData() {
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
      if(editedEmail != emailController){
        Navigator.pop(context);
      }else {
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
}
