import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/widgets/solid_button.dart';
import 'package:readysethire/screens/auth/auth_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password reset email sent! Check your inbox."),
        ),
      );

      // Go back to login
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Failed to reset password")),
      );
    }

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: 'Reset Password',
      children: [
        Text(
          'Email',
          style: TextStyle(color: AppTheme.fontColor.withOpacity(0.7)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(hintText: 'Enter your email'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 40),

        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SolidButton(
          text: 'Send Reset Link',
          textColor: Colors.white,
          onPressed: _resetPassword,
        ),

        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Remember your password? ",
              style: TextStyle(color: AppTheme.fontColor.withOpacity(0.6)),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text(
                'Sign In',
                style: TextStyle(color: AppTheme.primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
