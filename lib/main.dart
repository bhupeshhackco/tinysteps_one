import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_theme.dart';
import 'core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(
    // Riverpod scope wraps the entire app
    const ProviderScope(child: TinyStepsApp()),
  );
}

class TinyStepsApp extends ConsumerWidget {
  const TinyStepsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'TinySteps',
      debugShowCheckedModeBanner: false,
      theme: sunriseLightTheme(),
      darkTheme: sunriseDarkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
