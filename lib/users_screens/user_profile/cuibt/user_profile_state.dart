part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileStates {}

class UserProfileInitialState extends UserProfileStates {}

class GetUserDataFromFireStoreSuccessState extends UserProfileStates {}

class GetUserDateFromFireStoreFailureState extends UserProfileStates {
  final String errorMessage ;
  GetUserDateFromFireStoreFailureState({required this.errorMessage});
}