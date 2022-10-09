import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_ui/src/app.dart';

void main() async {
  await GetStorage.init();
  runApp(
    const ProviderScope(
      child: QuizUiApp(),
    ),
  );
}
