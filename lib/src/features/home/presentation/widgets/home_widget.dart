import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';
import 'package:quiz_ui/src/common/extensions/enum_extensios.dart';
import 'package:quiz_ui/src/common/extensions/int_extensions.dart';
import 'package:quiz_ui/src/common/widgets/toast.dart';
import 'package:quiz_ui/src/constants/app_sizes.dart';
import 'package:quiz_ui/src/constants/constants.dart';
import 'package:quiz_ui/src/constants/questions.dart';
import 'package:quiz_ui/src/features/authentication/repositories/auth_repository.dart';
import 'package:quiz_ui/src/features/home/presentation/widgets/counter_widget.dart';
import 'package:quiz_ui/src/features/home/presentation/widgets/question_card.dart';
import 'package:quiz_ui/src/features/home/repositories/home_repository.dart';

class HomeWidget extends ConsumerStatefulWidget {
  const HomeWidget({super.key});

  @override
  ConsumerState<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends ConsumerState<HomeWidget> {
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) => _checkUserName());

    final homeRepo = ref.watch(homeRepositoryProvider);
    final competitionStatus = ref.watch(compitionStatusProvider);
    final getQuestions = ref.watch(getQuestionsProvider);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: context.height * 0.18,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Image.asset(
                      'assets/images/okoul.png',
                      width: context.width * 0.16,
                      height: context.width * 0.16,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: 1.seconds,
                child: competitionStatus.isCountingDown
                    ? Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 150,
                          width: context.width / 5,
                          child: Counter(onComplete: () {}),
                        ),
                      )
                    : Lottie.asset(
                        'assets/json/start-quiz.json',
                      ),
              ),
              gapW24,
              Visibility(
                visible: competitionStatus.isNone,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: Constants.quizQoute),
                            TextSpan(text: Constants.quizQoute2),
                            TextSpan(
                              text: Constants.quizQoute3,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: context.height * .019),
                    SizedBox(
                      width: context.width / 3,
                      child: OutlinedButton(
                        onPressed: homeRepo.startCompition,
                        child: const Text('Let\'s Go'),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: competitionStatus.isActive,
                child: Column(
                  children: [
                    getQuestions.when(
                      data: (questions) {
                        return SizedBox(
                          height: context.width / 1.09,
                          child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: pageController,
                            onPageChanged: (index) {},
                            itemCount: questionsData.length,
                            itemBuilder: (context, index) => QuestionCard(
                              question: questionsData[index],
                            ),
                          ),
                        );
                      },
                      error: (error, s) => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    gapH4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: context.width / 4,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Skip'),
                          ),
                        ),
                        gapW24,
                        SizedBox(
                          width: context.width / 3,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Next'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkUserName() {
    final authRepository = ref.read(authRepositoryProvider);
    if (authRepository.currentUser?.name == null) {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('please Enter you name '),
              gapH24,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  cursorHeight: 20,
                  autofocus: false,
                  onChanged: authRepository.userNameChanged,
                  onSubmitted: authRepository.userNameChanged,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                ),
              ),
              gapH24,
              OutlinedButton(
                onPressed: () {
                  final navigator = Navigator.of(context);
                  authRepository.saveUserName(
                    onSuccess: (message) async {
                      await flash.successFlash(context, message: message);
                      navigator.pop();
                    },
                    onError: (error) => flash.errorFlash(context, error: error),
                  );
                },
                child: const Text(
                  'save',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
