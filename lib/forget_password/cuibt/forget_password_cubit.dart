import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());
final FirebaseAuth firebaseAuth =FirebaseAuth.instance ;
  void sendCodeChangeThePassword({
    required email
}) {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
