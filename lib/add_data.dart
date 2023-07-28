import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teamx_project/component/component_of_screen.dart';

class AddDataInDataBase extends StatefulWidget {
  const AddDataInDataBase({super.key});

  @override
  State<AddDataInDataBase> createState() => _AddDataInDataBaseState();
}

class _AddDataInDataBaseState extends State<AddDataInDataBase> {
  final ImagePicker picker = ImagePicker();
  File? imageFile;
 final enimeTitleController = TextEditingController();
 final numberOfChapterController = TextEditingController();
 final enimeImageController = TextEditingController();
 FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 FirebaseFirestore firestore =FirebaseFirestore.instance ;
 FirebaseStorage firebaseStorage = FirebaseStorage.instance ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 40,left: 10,right: 10),
        child: Column(
          children: [
            textFormField(
                hintTitle:"enime title",
                controller: enimeTitleController,
                obscureText: false,
                keyType: TextInputType.text,
                inputAction: TextInputAction.next),
           const  SizedBox(height: 20,),
            textFormField(
                hintTitle:"number of chapter",
                controller: numberOfChapterController,
                obscureText: false,
                keyType: TextInputType.text,
                inputAction: TextInputAction.next),
            const  SizedBox(height: 20,),
            textFormField(
                hintTitle:"enime image",
                controller: enimeImageController,
                obscureText: false,
                keyType: TextInputType.text,
                inputAction: TextInputAction.done),
           const  SizedBox(height: 30,),
            Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                    onPressed: () {
                      addDataInDataBase();
                    },
                    child: const Text(
                      "Add Data ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))),
          ],
        ),
      ),

    );
  }

 void addDataInDataBase() {
   String enimeTitle= enimeTitleController.text;
   String numberOfChapter = numberOfChapterController.text;
   String enimeImage = enimeImageController.text;

   Map<String , dynamic> data = {
     "id" : "${DateTime.now().millisecondsSinceEpoch}",
     "enimeTitle": enimeTitle,
     "numberOfChapter":numberOfChapter,
     "image": enimeImage
   };
   firestore.collection("enimeItemData").doc(data["id"]).set(data).then((value){

   }).catchError((error){
     print('error when add data in {$error}');
    });


 }


}
