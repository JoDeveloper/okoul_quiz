import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';
import 'package:quiz_ui/src/common/extensions/int_extensions.dart';
import 'package:quiz_ui/src/common/widgets/toast.dart';
import 'package:quiz_ui/src/constants/app_sizes.dart';
import 'package:quiz_ui/src/features/authentication/repositories/auth_repository.dart';
import 'package:quiz_ui/src/routing/routes.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool isLoading = false;
  String? number;

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authRepositoryProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.height * 0.2),
            FadeInDownBig(
              child: Image.asset('assets/images/quiz.png'),
            ),
            SizedBox(height: context.height * 0.05),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: InternationalPhoneNumberInput(
                onInputChanged: (value) => number = value.phoneNumber,
                countries: const ['SA'],
                ignoreBlank: false,
                maxLength: 10,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: const TextStyle(color: Colors.black),
                initialValue: PhoneNumber(isoCode: 'SA'),
                formatInput: false,
                keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                inputBorder: const OutlineInputBorder(),
                onSaved: (value) => number = value.phoneNumber,
              ),
            ),
            KeyboardVisibilityBuilder(
              builder: (context, keyboardIsVisible) {
                return AnimatedContainer(
                  duration: 700.milliseconds,
                  height: keyboardIsVisible ? 2 * context.height / 100 : 30 * context.height / 100,
                );
              },
            ),
            gapH12,
            SizedBox(
              width: context.width / 3,
              child: OutlinedButton(
                onPressed: () async {
                  if (number == null) return;
                  _login(authProvider, context);
                },
                child: isLoading
                    ? SizedBox(
                        width: context.width / 2.5,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const Text(
                        "Continue",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(AuthRepository authProvider, BuildContext context) async {
    {
      setState(() {
        isLoading = true;
      });
      final goRouter = GoRouter.of(context);
      await authProvider.login(
        mobileNumber: number!,
        onSuccess: (user) async {
          setState(() {
            isLoading = false;
          });
          await flash.successFlash(context, message: user.message);
          // await 1.seconds.delay(() {});
          if (user.name == null) {
            // screen to update the name
            goRouter.replaceNamed(AppRoute.home.name);
          } else {
            goRouter.replaceNamed(AppRoute.home.name);
          }
        },
        onError: (error) {
          setState(() {
            isLoading = false;
          });
          flash.errorFlash(context, error: error);
        },
      );
    }
  }
}
