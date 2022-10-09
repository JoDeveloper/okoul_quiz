import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_ui/src/routing/routes.dart';

class QuizUiApp extends ConsumerWidget {
  const QuizUiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routesProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => 'QuizUi',
      theme: FlexThemeData.light(scheme: FlexScheme.outerSpace),
      // darkTheme: FlexThemeData.dark(scheme: FlexScheme.outerSpace),
      themeMode: ThemeMode.system,
    );
  }
}
