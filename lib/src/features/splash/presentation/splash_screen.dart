import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';
import 'package:quiz_ui/src/common/extensions/int_extensions.dart';
import 'package:quiz_ui/src/core/services/storage/local_storage_service.dart';
import 'package:quiz_ui/src/routing/routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(3.seconds, () {
      _redirectToNexPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.1 * height),
          BounceInUp(
            delay: 900.milliseconds,
            duration: 1.seconds,
            child: Center(
              child: Lottie.asset(
                'assets/json/quiz.json',
                width: .5 * width,
                height: 0.2 * height,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _redirectToNexPage() {
    final localStorage = ref.watch(loacalStorageProvider);
    if (mounted) {
      if (localStorage.isLoggedIn) {
        context.replaceNamed(AppRoute.home.name);
      } else {
        context.replaceNamed(AppRoute.auth.name);
      }
    }
  }
}
