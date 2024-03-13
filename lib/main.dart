import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:front_end/firebase_options.dart';
import 'package:front_end/provider/shared_utility.dart';
import 'package:front_end/screens/auth/Auth.dart';
import 'package:front_end/screens/home.dart';
import 'package:front_end/screens/login.dart';
import 'package:front_end/screens/onboarding.dart';
import 'package:front_end/screens/signup/signup_address.dart';
import 'package:front_end/screens/signup/signup_personal.dart';
import 'package:front_end/screens/signup/signup_stepper.dart';
import 'package:front_end/screens/splash.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
// We store the app and auth to make testing with a named instance easier.
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(overrides: [
    // override the previous value with the new object
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  late Widget screen;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
          colorScheme:
              const ColorScheme.light().copyWith(primary: Colors.black)),
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return ref.watch(sharedUtilityProvider).isFirstTime()
                  ? const Onboarding()
                  : const Auth();
            },
          ),
          //    /products
          ///products/1
          GoRoute(
            path: '/login',
            builder: (BuildContext context, GoRouterState state) {
              return const Login();
            },
          ),
          GoRoute(
            path: '/signup',
            builder: (BuildContext context, GoRouterState state) {
              return SignupStepper();
            },
          ),
          GoRoute(
            path: '/auth',
            builder: (BuildContext context, GoRouterState state) {
              return const Auth();
            },
          ),
          GoRoute(
            path: '/signup_personal',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpPersonal();
            },
          ),
          GoRoute(
            path: '/signup_address',
            builder: (BuildContext context, GoRouterState state) {
              return const SignUpAddress();
            },
          ),
          GoRoute(
            path: '/dashboard',
            builder: (BuildContext context, GoRouterState state) {
              return const Home();
            },
          ),
          GoRoute(
            path: '/onboarding',
            builder: (BuildContext context, GoRouterState state) {
              return const Onboarding();
            },
          ),
        ],
      ),
    );
  }
}

// The route configuration.
// final GoRouter _router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return 
//       },
//     ),
//     //    /products
//     ///products/1
//     GoRoute(
//       path: '/login',
//       builder: (BuildContext context, GoRouterState state) {
//         return const Login();
//       },
//     ),
//     GoRoute(
//       path: '/signup',
//       builder: (BuildContext context, GoRouterState state) {
//         return SignupStepper();
//       },
//     ),
//     GoRoute(
//       path: '/signup_personal',
//       builder: (BuildContext context, GoRouterState state) {
//         return const SignUpPersonal();
//       },
//     ),
//     GoRoute(
//       path: '/signup_address',
//       builder: (BuildContext context, GoRouterState state) {
//         return const SignUpAddress();
//       },
//     ),
//     GoRoute(
//       path: '/dashboard',
//       builder: (BuildContext context, GoRouterState state) {
//         return const Home();
//       },
//     ),
//   ],
// );
