sealed class ViewModelState {}

class IdleState implements ViewModelState {}

class LoadingState implements ViewModelState {
  LoadingState({this.message});

  final String? message;
}

class ErrorState implements ViewModelState {
  ErrorState({this.message});

  final String? message;
}
