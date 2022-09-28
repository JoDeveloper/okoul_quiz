import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_ui/src/constants/api.dart';
import 'package:quiz_ui/src/core/services/dio/dio_http_service.dart';
import 'package:quiz_ui/src/features/leaderboard/data/score.dart';

final leadershipRepositoryProvider = Provider<LeadershipRepository>((ref) {
  return LeadershipRepository(ref);
});

final getScoresProvider = FutureProvider<List<Score>>((ref) async {
  return ref.watch(leadershipRepositoryProvider).getTopScores();
});

class LeadershipRepository {
  final ProviderRef ref;

  LeadershipRepository(this.ref);

  Future<List<Score>> getTopScores() async {
    List<Score> scores = [];
    final response = await ref.read(httpServiceProvider).post(Api.topScore);

    response.when((data) {
      scores = scoresFromJson(jsonDecode(data));
    }, (error) {
      log(error.message!);
    });

    return scores;
  }
}
