import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';
import 'package:quiz_ui/src/common/widgets/toast.dart';
import 'package:quiz_ui/src/constants/app_sizes.dart';
import 'package:quiz_ui/src/features/authentication/repositories/auth_repository.dart';
import 'package:quiz_ui/src/features/home/presentation/widgets/know_more.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    SchedulerBinding.instance.addPostFrameCallback((_) => _checkUserName(authRepository, context));

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
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
          body: ListView(
            children: [
              SizedBox(height: context.height * .09),
              const KnowMoreWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _checkUserName(AuthRepository authRepository, BuildContext context) {
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
                    onError: (error) => flash.errorFlash(context, message: error),
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
