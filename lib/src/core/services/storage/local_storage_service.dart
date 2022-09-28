import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quiz_ui/src/features/authentication/data/user_model.dart';

final loacalStorageProvider = Provider<LocalStorage>((ref) {
  return LocalStorage();
});

class LocalStorage {
  late final GetStorage _box;
  bool? _isFirstLaunch;

  LocalStorage() {
    _init().then(
      (_) => {
        _box.listenKey(_Keys.token, (value) {
          log('token change $value');
        }),
      },
    );
  }

  Future<void> _init() async {
    _box = GetStorage('local_storage');
    await _box.initStorage.then((_) {
      _isFirstLaunch = _box.read(_Keys.firstLaunch) ?? true;
      if (_isFirstLaunch!) {
        _box.write(_Keys.firstLaunch, false);
      }
    });
  }

  bool get firstLaunch => _isFirstLaunch ?? false;

  bool get isLoggedIn => _box.read(_Keys.token) != null;

  void setToken(String? token) => _box.write(_Keys.token, token);

  String? getToken() => _box.read(_Keys.token);

  void saveUser(User? user) => _box.write(_Keys.user, jsonEncode(user?.toJson()));

  User? getUser() => _box.read(_Keys.user) == null ? null : User.fromJson(jsonDecode(_box.read(_Keys.user)));
}

abstract class _Keys {
  static const String firstLaunch = 'first_launch';
  static const String token = 'token';
  static String user = 'user';
}
