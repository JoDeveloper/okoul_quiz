import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_ui/src/constants/api.dart';
import 'package:quiz_ui/src/features/home/data/questions.dart';

import '../../../core/services/dio/dio_http_service.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref: ref);
});

final compitionStatusProvider = StateProvider<CompitionStatus>((ref) {
  return CompitionStatus.none;
});

final getQuestionsProvider = FutureProvider<List<Question>>((ref) async {
  return ref.watch(homeRepositoryProvider).getQuestions();
});

enum CompitionStatus {
  none,
  active,
  timerStarted,
  completed,
}

class HomeRepository {
  final ProviderRef ref;
  HomeRepository({
    required this.ref,
  });

  void startCompition() {
    ref.watch(compitionStatusProvider.state).update((state) => CompitionStatus.active);
  }

  Future<List<Question>> getQuestions() async {
    final response = await ref.read(httpServiceProvider).get(Api.questions);
    return response.when(
      (data) {
        final questions = questionFromJson(json.encode(data));
        ref.watch(compitionStatusProvider.state).update((state) => CompitionStatus.timerStarted);
        return questions;
      },
      (error) => [],
    );
  }
}
