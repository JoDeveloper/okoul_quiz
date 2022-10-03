import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.init() = Init;
  const factory AuthState.loading() = Loading;
  const factory AuthState.loggedIn() = LoggedIn;
  const factory AuthState.login({required String phone}) = Login;
  factory AuthState.error([String? message]) = Error;
}
