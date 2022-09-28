import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_ui/src/common/extensions/int_extensions.dart';
import 'package:quiz_ui/src/common/widgets/count_timer.dart';

class Counter extends StatelessWidget {
  final VoidCallback onComplete;
  const Counter({
    Key? key,
    required this.onComplete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Lottie.asset('assets/json/timer.json'),
        ),
        Countdown(
          duration: 2.minutes,
          onFinish: onComplete,
          builder: (_, remaining) {
            return Text(
              '0${remaining.inMinutes.remainder(60)}:${remaining.inSeconds.remainder(60)}',
              style: Theme.of(context).textTheme.headline6,
            );
          },
        )
      ],
    );
  }
}
