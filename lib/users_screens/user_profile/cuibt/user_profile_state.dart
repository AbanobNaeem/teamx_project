part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileStates {}

class UserProfileInitialState extends UserProfileStates {}

class UserProfileSuccessState extends UserProfileStates {}

class UserProfileFailureState extends UserProfileStates {
  final String errorMessage ;
  UserProfileFailureState({required this.errorMessage});
}