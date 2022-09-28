import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_number/phone_number.dart';
import 'package:quiz_ui/src/constants/constants.dart';
import 'package:quiz_ui/src/core/services/dio/dio_http_service.dart';
import 'package:quiz_ui/src/core/services/storage/local_storage_service.dart';
import 'package:quiz_ui/src/features/authentication/data/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref: ref);
});

class AuthRepository {
  final ProviderRef ref;
  final LocalStorage localStorage;
  final DioHttpService httpService;

  AuthRepository({
    required this.ref,
  })  : localStorage = ref.watch(loacalStorageProvider),
        httpService = ref.watch(dioHttpProvider);

  User? _user;

  String? userName;

  bool get isLoggedIn => localStorage.getToken() != null;

  User? get currentUser => localStorage.isLoggedIn ? localStorage.getUser() : null;

  void userNameChanged(String value) {
    userName = value;
  }

  Future<void> login({
    required String mobileNumber,
    required void Function(String) onError,
    required void Function(User) onSuccess,
  }) async {
    final phoneUtil = PhoneNumberUtil();
    PhoneNumber? parsedNumber;
    try {
      parsedNumber = await phoneUtil.parse(mobileNumber);
    } on Exception catch (e) {
      onError(e.toString());
    }

    final result = await httpService.post('/Login', queryParameters: {
      'mobile': parsedNumber?.national,
      'OTP': Constants.otp,
    });

    result.when(
      (data) {
        localStorage.setToken(data["token"]);
        _user = User.fromJson(data);
        localStorage.saveUser(_user);
        onSuccess(_user!);
      },
      (error) => onError.call(error.message!),
    );
  }

  Future<void> saveUserName({
    required void Function(String) onError,
    required void Function(String) onSuccess,
  }) async {
    if (userName == null) return;

    final reponse = await httpService.post(
      '/Name',
      queryParameters: {'name': userName},
      additionalHeaders: {'Authorization': 'Bearer ${localStorage.getToken()}'},
    );

    reponse.when(
      (data) {
        _user = _user?.copyWith(name: userName);
        localStorage.saveUser(_user);
        onSuccess(data["message"]);
      },
      (error) => onError.call(error.message!),
    );
  }
}
