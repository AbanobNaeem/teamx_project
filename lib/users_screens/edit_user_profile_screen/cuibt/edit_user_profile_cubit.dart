import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'edit_user_profile_state.dart';

class EditUserProfileCubit extends Cubit<EditUserProfileStates> {
  EditUserProfileCubit() : super(EditUserProfileInitialState());
 final FirebaseAuth firebaseAuth =FirebaseAuth.instance ;
 final FirebaseFirestore firestore = FirebaseFirestore.instance ; 
 Map<String,dynamic> data = {} ; 

}
