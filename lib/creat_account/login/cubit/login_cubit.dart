import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamx_project/creat_account/login/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance ;

  void login({
    required email ,
    required password
  }){
    firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password).then((value){
      emit(LoginSuccessState());

    }).catchError((error){
      emit(LoginFailureState(errorMessage: error.toString()));
    });
  }

}