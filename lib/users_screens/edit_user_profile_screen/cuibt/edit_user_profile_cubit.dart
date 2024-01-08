
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'edit_user_profile_state.dart';

class EditUserProfileCubit extends Cubit<EditUserProfileStates> {
  EditUserProfileCubit() : super(EditUserProfileInitialState());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseStorage firebaseStorage =FirebaseStorage.instance ;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> data = {};

  void getDataFromFireStore() {
    String userId = firebaseAuth.currentUser!.uid;
    firestore.collection("userData").doc(userId).snapshots().listen((value) {
      data = value.data()!;

      emit(GetDataFromFireStoreSuccessState());
    }).onError((error) {
      emit(GetDataFromFireStoreFailureState(errorMessage: error.toString()));
    });
  }
  void editUserData({
    required firstName ,
    required lastName ,
    required email ,
    required phone
}) {
    final userId = firebaseAuth.currentUser!.uid;
    String editedFirstName = firstName;
    String editedLastName = lastName;
    String editedEmail = email;
    String editedPhone = phone;

    Map<String, dynamic> data = {
      "firstName": editedFirstName,
      "lastName": editedLastName,
      "email": editedEmail,
      "phone": editedPhone,
    };

    firestore.collection("userData").doc(userId).update(data).then((value) {
      emit(UpdateUserDataSuccessState());
    }).catchError((error) {
      UpdateUserDataFailureState(error.toString());
    });
  }


  void uploadFile({
    required imageFile
}) {
    String userId = firebaseAuth.currentUser!.uid;
    firebaseStorage.ref("images/$userId").putFile(imageFile!).then((p0) {
      getImageUrl();
    }).catchError((error) {});
  }

  void getImageUrl() async {
    String userId = firebaseAuth.currentUser!.uid;
   await firebaseStorage.ref("images/$userId").getDownloadURL().then((imageUrl) {
      saveImageUrlInFireStore(imageUrl);
    }).catchError((error) {});
  }

  void saveImageUrlInFireStore(String imageUrl) async {
    String userId = firebaseAuth.currentUser!.uid;
    Map<String, dynamic> data = {"imageUrl": imageUrl};
    await firestore.collection("userData").doc(userId).update(data).then((value){
      emit(UpdateUserImageSuccessState());
    }).catchError((error){
      emit(UpdateUserImageFailureState(error.toString()));
    });
  }
}
