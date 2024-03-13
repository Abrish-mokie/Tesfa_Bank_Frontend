import 'package:flutter/material.dart';
import 'package:front_end/provider/auth/authentication_provider.dart';
import 'package:front_end/provider/auth/login_form_provider.dart';

import 'package:front_end/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../widgets/custom_text_field.dart';

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class Login extends HookConsumerWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final password = useTextEditingController();

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          // Navigate to dashboard screen
          context.go("/dashboard");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Logged In'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        unauthenticated: (message) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
    });

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 121,
                  ),
                  SizedBox(
                    width: 94,
                    height: 121,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Tesfa Bank",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Consumer(
                            builder: (context, ref, _) {
                              final emailField = ref
                                  .watch(loginFormNotifierProvider)
                                  .form
                                  .email;
                              return CustomTextField(
                                onChanged: (value) => ref
                                    .read(loginFormNotifierProvider.notifier)
                                    .setEmail(value),
                                controller: email,
                                // hintText: 'Email',
                                labelText: "Enter your Email",
                                errorMessage: emailField.errorMessage,
                              );
                            },
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Consumer(
                            builder: (context, ref, _) {
                              final passwordField = ref
                                  .watch(loginFormNotifierProvider)
                                  .form
                                  .password;
                              return CustomTextField(
                                isPassword: true,
                                onChanged: (value) => ref
                                    .read(loginFormNotifierProvider.notifier)
                                    .setPassword(value),
                                controller: password,
                                // hintText: 'Email',
                                labelText: "Enter your Password",
                                errorMessage: passwordField.errorMessage,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: <Widget>[
                                // Checkbox(
                                //   value: false,
                                //   onChanged: null,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () =>
                                            {context.go("/signup")},
                                        child: const Row(
                                          children: [
                                            Text('Not a member? '),
                                            Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                    const Text('Forgot Password?'),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 100),
                          Center(
                            child: Consumer(builder: (context, ref, _) {
                              final field =
                                  ref.watch(loginFormNotifierProvider).form;
                              return CustomButton(
                                isDisabled: !(field.password.isValid &&
                                    field.email.isValid),
                                // backgroundColor: Colors.black,
                                title: 'Sign in',
                                loading: ref
                                    .watch(authNotifierProvider)
                                    .maybeWhen(
                                        orElse: () => false,
                                        loading: () => true),
                                onPressed: () => ref
                                    .read(authNotifierProvider.notifier)
                                    .login(
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                    ),
                              );
                            }),
                          ),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     const Text("Not a member? "),
                          //     TextButton(
                          //         onPressed: () => {
                          //           context.go('/signup')
                          //               // Navigator.of(context).push(
                          //               //     MaterialPageRoute(
                          //               //         builder: (context) => SignUp()))
                          //             },
                          //         child: const Text("Register Now")),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
