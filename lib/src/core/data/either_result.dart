// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@sealed
abstract class Either<S, E> {
  const Either();

  dynamic get();

  S? getSuccess();

  E? getError();

  bool get isError;

  bool get isSuccess;

  W when<W>(
    W Function(S data) whenSuccess,
    W Function(E error) whenError,
  );
}

@immutable
class Success<S, E> implements Either<S, E> {
  const Success(
    this._success,
  );

  final S _success;

  @override
  S get() {
    return _success;
  }

  @override
  bool get isError => false;

  @override
  bool get isSuccess => true;

  @override
  int get hashCode => _success.hashCode;

  @override
  bool operator ==(Object other) => other is Success && other._success == _success;

  @override
  W when<W>(
    W Function(S data) whenSuccess,
    W Function(E error) whenError,
  ) {
    return whenSuccess(_success);
  }

  @override
  E? getError() => null;

  @override
  S? getSuccess() => _success;
}

@immutable
class Error<S, E> implements Either<S, E> {
  const Error(this._error);

  final E _error;

  @override
  E get() {
    return _error;
  }

  @override
  bool get isError => true;

  @override
  bool get isSuccess => false;

  @override
  int get hashCode => _error.hashCode;

  @override
  bool operator ==(Object other) => other is Error && other._error == _error;

  @override
  W when<W>(
    W Function(S data) whenSuccess,
    W Function(E error) whenError,
  ) {
    return whenError(_error);
  }

  @override
  E? getError() => _error;

  @override
  S? getSuccess() => null;
}
