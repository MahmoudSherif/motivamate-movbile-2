import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'providers/auth_provider.dart';
import 'providers/task_provider.dart';
import 'providers/calendar_provider.dart';
import 'providers/notes_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/quote_provider.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MotivaMateApp());
}

class MotivaMateApp extends StatelessWidget {
  const MotivaMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => NotesProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
      ],
      child: MaterialApp(
        title: 'MotivaMate',
        theme: AppTheme.darkTheme,
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isAuthenticated
                ? const MainScreen()
                : const AuthScreen();
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}