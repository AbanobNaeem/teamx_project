import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamx_project/creat_account/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance ;
  final FirebaseFirestore firestore = FirebaseFirestore.instance ;
  void register({
    required email ,
    required password
  })
  {

    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          firebaseAuth.signOut() ;
          emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterFailureState(errorMessage: error.toString()));
    });
  }

  void addUserDataOnFireStore({
    required email ,
    required password,
    required phone ,
    required firstName,
    required lastName,
  }) {
    String userId = firebaseAuth.currentUser!.uid;
    Map<String, dynamic> data = {
      "id": userId,
      "phone": phone,
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
    firestore.collection("userData").doc(userId).set(data).then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterFailureState(errorMessage: error.toString()));
    });
  }

}