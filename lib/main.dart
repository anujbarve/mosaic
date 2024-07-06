import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosaic_communities/common/error_page.dart';
import 'package:mosaic_communities/common/loading_page.dart';
import 'package:mosaic_communities/features/auth/controller/auth_controller.dart';
import 'package:mosaic_communities/features/auth/view/signup_view.dart';
import 'package:mosaic_communities/features/home/view/home_view.dart';
import 'package:mosaic_communities/theme/app_theme.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mosaic Communities',
        theme: AppTheme.theme,
        home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if(user != null)
                {
                  return const HomeView();
                }
              return const SignUpView();
            },
            error: (error, st) => ErrorPage(errorText: error.toString()),
            loading: () => LoadingPage()));
  }
}
