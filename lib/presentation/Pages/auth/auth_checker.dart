import 'package:authentication_riverpod/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/export.dart';
import '../common/error_screen.dart';
import '../common/loading_screen.dart';
import 'login/login_page.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initializeAppResources(context: context);
    //  now the build method takes a new paramaeter ScopeReader.
    //  this object will be used to access the provider.
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) return const HealthDataScreen();
          return const LoginPage();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(e, trace));
  }
}
