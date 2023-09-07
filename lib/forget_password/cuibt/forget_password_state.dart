
abstract class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordSendEmailSuccess extends ForgetPasswordStates {}

class ForgetPasswordSendEmailFailure extends ForgetPasswordStates {
  final String errorMessage ;
  ForgetPasswordSendEmailFailure({required this.errorMessage});
}
