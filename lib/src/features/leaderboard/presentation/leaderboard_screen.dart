import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';
import 'package:quiz_ui/src/constants/app_sizes.dart';
import 'package:quiz_ui/src/features/leaderboard/data/score.dart';
import 'package:quiz_ui/src/features/leaderboard/repositories/leadership_repository.dart';

class LeaderBoardScreen extends ConsumerWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topScores = ref.watch(getScoresProvider);

    return topScores.when(
      data: (scores) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Scores',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                  ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: scores.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final score = scores[index];
                return SizedBox(
                  height: context.height * 0.19,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 220,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(height: 5),
                            Expanded(
                              child: _Info(score: score),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      error: (error, s) => Scaffold(
          body: Center(
        child: Text(error.toString()),
      )),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final Score score;
  const _Info({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/okoul.png", height: 40),
        gapH8,
        Text(
          score.name,
          style: Theme.of(context).textTheme.headline5,
        ),
        gapH8,
        Text(
          '${score.score}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
