import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeRepositoryProvider = StateProvider<HomeRepository>((ref) {
  return HomeRepository();
});

class HomeRepository {
  bool competitionStarted = false;
}
