import 'package:flutter/material.dart';
import 'package:quiz_ui/src/constants/app_sizes.dart';
import 'package:quiz_ui/src/features/home/data/questions.dart';
import 'package:quiz_ui/src/features/home/presentation/widgets/option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context).textTheme.headline6,
          ),
          gapW12,
          ...List.generate(
            question.options.length,
            (index) => Option(
              index: index,
              text: question.options[index],
              press: () {},
            ),
          ),
        ],
      ),
    );
  }
}
