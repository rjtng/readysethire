import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/screens/welcome_screen.dart';
import 'package:readysethire/screens/auth/login_screen.dart';
import 'package:readysethire/screens/auth/create_account_screen.dart';
import 'package:readysethire/screens/auth/verify_account_screen.dart';
import 'package:readysethire/screens/auth/reset_password_screen.dart';
import 'package:readysethire/screens/main_app_screen.dart';
import 'package:readysethire/screens/placeholders/feedback_screen.dart'; // Placeholder
import 'package:readysethire/screens/placeholders/account_screen.dart';   // Placeholder
import 'package:readysethire/screens/placeholders/Resume/export_resume_screen.dart';
import 'package:readysethire/widgets/require_progress.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ResumeDataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadySetHire',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const CreateAccountScreen(),
        '/verify': (context) => const VerifyAccountScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/home': (context) => const MainAppScreen(),
        '/feedback': (context) => const FeedbackScreen(),
        '/account': (context) => const AccountScreen(),
        '/export_resume': (context) => const RequireProgress(minLevel: 'experience', child: ExportResumeScreen()),
      },
    );
  }
}
