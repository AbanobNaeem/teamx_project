import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates> {
  HomeScreenCubit() : super(HomeScreenInitialState());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String , dynamic> data = {} ;

  getProductsFromFireStore({required String collectionName,
    required List list}) {
    firestore.collection(collectionName).snapshots().listen((event) {
      for (var doc in event.docs) {
        final product = doc.data();
        list.add(product);
      }
      emit(HomeScreenSuccessState());
    }).onError((error) {
       emit(HomeScreenFailureState(errorMessage: error.toString()));
    });
  }

  void getUserDataFromFireStore() {
    String userId = firebaseAuth.currentUser!.uid;
    firestore.collection("userData").doc(userId).snapshots().listen(
          (value) {
        if (value.exists) {
          emit(UpdateUiSuccessState());
          Map<String, dynamic>? userData = value.data();
          if (userData != null) {
            // Handle the non-null case
            data = userData;
          } else {
            // Handle the case when data is null
            emit(UpdateUiFailureState(errorMessage: 'User data is null.'));
          }
        } else {
          // Handle the case when the document doesn't exist
          emit(UpdateUiFailureState(errorMessage: 'Document does not exist.'));
        }
      },
      onError: (error) {
        emit(UpdateUiFailureState(errorMessage: error.toString()));
      },
    );
  }



}