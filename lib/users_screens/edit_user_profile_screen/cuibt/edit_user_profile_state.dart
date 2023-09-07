part of 'edit_user_profile_cubit.dart';

@immutable
abstract class EditUserProfileStates {}

class EditUserProfileInitialState extends EditUserProfileStates {}

class EditUserProfileSuccessState extends EditUserProfileStates {}

class EditUserProfileFailureState extends EditUserProfileStates {
  final String errorMessage ;
  EditUserProfileFailureState({required this.errorMessage});

}