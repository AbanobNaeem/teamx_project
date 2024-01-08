part of 'edit_user_profile_cubit.dart';

@immutable
abstract class EditUserProfileStates {}

class EditUserProfileInitialState extends EditUserProfileStates {}

class GetDataFromFireStoreSuccessState extends EditUserProfileStates {}

class GetDataFromFireStoreFailureState extends EditUserProfileStates {
  final String errorMessage ;
  GetDataFromFireStoreFailureState({required this.errorMessage});

}


class UpdateUserDataSuccessState extends EditUserProfileStates{}

class UpdateUserDataFailureState extends EditUserProfileStates {
  final String errorMessage ;
  UpdateUserDataFailureState(this.errorMessage);


}
class UpdateUserImageSuccessState extends EditUserProfileStates{}

class UpdateUserImageFailureState extends EditUserProfileStates {
  final String errorMessage ;
  UpdateUserImageFailureState(this.errorMessage);


}




