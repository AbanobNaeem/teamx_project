import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileStates> {
  UserProfileCubit() : super(UserProfileInitialState());

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance ;
  final FirebaseFirestore firestore = FirebaseFirestore.instance ;
  Map<String , dynamic> data = {};


   void getDataFromFireStore() async {
    String userId = firebaseAuth.currentUser!.uid;
      firestore.collection("userData").doc(userId).snapshots().listen((value) {
       data = value.data()! ;
       emit(GetUserDataFromFireStoreSuccessState());
     }).onError(
          (error){emit(GetUserDateFromFireStoreFailureState(errorMessage: error.toString()));}
     );
  }

}
