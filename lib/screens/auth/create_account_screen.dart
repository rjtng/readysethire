import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/widgets/solid_button.dart';
import 'package:readysethire/screens/auth/auth_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // ✅ Optionally send email verification
      await _auth.currentUser?.sendEmailVerification();

      // ✅ Navigate to verify page or home
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/verify');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Registration failed")),
      );
    }

    if (!mounted) return;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: 'Create an Account',
      children: [
        Text('Email',
            style: TextStyle(color: AppTheme.fontColor.withOpacity(0.7))),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(hintText: 'Enter your email'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),

        Text('Password',
            style: TextStyle(color: AppTheme.fontColor.withOpacity(0.7))),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Enter your password',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () =>
                  setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
          ),
        ),
        const SizedBox(height: 20),

        Text('Confirm Password',
            style: TextStyle(color: AppTheme.fontColor.withOpacity(0.7))),
        const SizedBox(height: 8),
        TextField(
          controller: _confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          decoration: InputDecoration(
            hintText: 'Confirm your password',
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () => setState(() =>
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
            ),
          ),
        ),
        const SizedBox(height: 40),

        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SolidButton(
          text: 'Sign Up',
          textColor: Colors.white,
          onPressed: _signUp,
        ),

        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
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
