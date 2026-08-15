import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/widgets/solid_button.dart';
import 'package:readysethire/screens/auth/auth_screen.dart';

class VerifyAccountScreen extends StatefulWidget {
  const VerifyAccountScreen({super.key});

  @override
  State<VerifyAccountScreen> createState() => _VerifyAccountScreenState();
}

class _VerifyAccountScreenState extends State<VerifyAccountScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _checkVerification() async {
    setState(() => _isLoading = true);

    // Refresh the current user
    await _auth.currentUser?.reload();
    final user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      // Navigate to home when verified
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Your email is not verified yet.")),
      );
    }

    setState(() => _isLoading = false);
  }

  Future<void> _resendVerificationEmail() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Verification email resent!")),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to resend email: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: 'Verify Your Account',
      children: [
        Text(
          "We've sent a verification link to your email. Please click the link in your inbox to complete your registration.",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppTheme.fontColor.withOpacity(0.7)),
        ),
        const SizedBox(height: 40),

        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SolidButton(
          text: 'Check Verification',
          textColor: Colors.white,
          onPressed: _checkVerification,
        ),

        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive an email? ",
              style: TextStyle(color: AppTheme.fontColor.withOpacity(0.6)),
            ),
            TextButton(
              onPressed: _resendVerificationEmail,
              child: const Text(
                'Resend',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
