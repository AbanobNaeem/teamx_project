part of 'home_screen_cubit.dart';

@immutable
abstract class HomeScreenStates {}

class HomeScreenInitialState extends HomeScreenStates {}

class HomeScreenSuccessState extends HomeScreenStates {}

class HomeScreenFailureState extends HomeScreenStates {
  final String errorMessage ;
  HomeScreenFailureState({required this.errorMessage});
}

class UpdateUiSuccessState extends HomeScreenStates {}

class UpdateUiFailureState extends HomeScreenStates {
  final String errorMessage ;
  UpdateUiFailureState({required this.errorMessage});
}