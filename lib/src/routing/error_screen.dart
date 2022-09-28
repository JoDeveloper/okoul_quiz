import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_ui/src/routing/routes.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '404 - Page not found!',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () => context.goNamed(AppRoute.home.name),
                child: const Text('Go Home'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
