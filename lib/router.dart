import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async'; // Import for StreamSubscription
import 'package:flutter/foundation.dart'; // Import for ValueListenable

// Import your screen widgets
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'package:myapp/main.dart'; // Import MyHomePage

final GoRouter goRouter = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(); // Use MyHomePage as the home route
      },
    ),
  ],
  redirect:
      (BuildContext context, GoRouterState state) {
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn = state.matchedLocation == '/login';
    final bool signingUp = state.matchedLocation == '/signup';

    // If the user is logged in, but is on the login or signup page, redirect to home.
    if (loggedIn && (loggingIn || signingUp)) {
      return '/'; // Redirect to the root route (MyHomePage)
    }
    // If the user is not logged in, and is not on the login or signup page, redirect to login.
    if (!loggedIn && !(loggingIn || signingUp)) {
      return '/login';
    }

    // No redirect needed
    return null;
  },
  refreshListenable: StreamNotifier<User?>(FirebaseAuth.instance.authStateChanges()),
);

// Helper class to make FirebaseAuth stream a ValueNotifier for GoRouter
class StreamNotifier<T> extends ChangeNotifier implements ValueListenable<T?> {
  StreamNotifier(Stream<T> stream) : _stream = stream {
    _subscription = _stream.listen((value) {
      _value = value;
      notifyListeners();
    });
  }

  final Stream<T> _stream;
  T? _value;
  late final StreamSubscription<T> _subscription;

  @override
  T? get value => _value;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
