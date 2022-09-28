import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';
import 'package:quiz_ui/src/common/extensions/int_extensions.dart';
import 'package:quiz_ui/src/common/widgets/count_timer.dart';

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Stack(
        children: [
          Positioned(
            right: 1,
            bottom: 1,
            child: SizedBox(
              width: 45,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35.5),
                                bottomLeft: Radius.circular(35.5),
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Lottie.asset(
                            'assets/json/timer.json',
                            height: 45,
                            width: 45,
                          ),
                        ),
                        Countdown(
                          duration: 2.minutes,
                          onFinish: () {
                            debugPrint('finished!');
                          },
                          builder: (_, remaining) {
                            return Text('${remaining.inMinutes}:${remaining.inSeconds}');
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
