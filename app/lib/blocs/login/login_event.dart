abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  @override
  String toString() => 'LoginButtonPressed';
}
