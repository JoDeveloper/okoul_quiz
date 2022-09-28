import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_ui/src/constants/api.dart';
import 'package:quiz_ui/src/features/home/data/questions.dart';

import '../../../core/services/dio/dio_http_service.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref: ref);
});

final compitionStartedProvider = StateProvider<bool>((ref) {
  return false;
});
final timerStartedProvider = StateProvider<bool>((ref) {
  return false;
});

final getQuestionsProvider = FutureProvider<List<Question>>((ref) async {
  return ref.watch(homeRepositoryProvider).getQuestions();
});

class HomeRepository {
  final ProviderRef ref;
  HomeRepository({
    required this.ref,
  });

  void startCompition() {
    ref.watch(compitionStartedProvider.state).update((state) => true);
  }

  Future<List<Question>> getQuestions() async {
    final response = await ref.read(httpServiceProvider).get(Api.questions);
    return response.when(
      (data) {
        final questions = questionFromJson(json.encode(data));
        ref.watch(timerStartedProvider.state).update((state) => true);
        return questions;
      },
      (error) => [],
    );
  }
}
