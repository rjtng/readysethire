import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart'; // Commented out for testing
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/widgets/solid_button.dart';
import 'package:readysethire/screens/auth/auth_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  // final _googleSignIn = GoogleSignIn(); // Commented out for testing

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An unknown error occurred.";
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided for that user.';
          break;
        case 'invalid-credential':
          errorMessage = 'The email or password you entered is incorrect.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        default:
          errorMessage = e.message ?? "Login failed";
      }
      _showErrorSnackBar(errorMessage);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /* Commented out for testing
  Future<void> _loginWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      // Use the instance to sign in
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in flow
        if (mounted) setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // This part remains correct
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      print("Google sign-in error: $e");
      _showErrorSnackBar("Google sign-in failed. Please try again.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: 'LOGIN',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email',
                  style: TextStyle(color: AppTheme.fontColor.withOpacity(0.7))),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                enabled: !_isLoading,
                decoration: const InputDecoration(hintText: 'Enter your email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text('Password',
                  style: TextStyle(color: AppTheme.fontColor.withOpacity(0.7))),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                enabled: !_isLoading,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: _isLoading
                ? null
                : () => Navigator.pushNamed(context, '/reset_password'),
            child: const Text(
              'Forgot password?',
              style: TextStyle(color: AppTheme.primaryColor),
            ),
          ),
        ),
        const SizedBox(height: 30),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SolidButton(
          text: 'Sign In',
          textColor: Colors.white,
          onPressed: _login,
        ),
        const SizedBox(height: 30),
        /* Commented out for testing
        Row(children: [
          Expanded(child: Divider(color: AppTheme.fontColor.withOpacity(0.2))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Or continue with',
              style: TextStyle(color: AppTheme.fontColor.withOpacity(0.6)),a
            ),
          ),
          Expanded(child: Divider(color: AppTheme.fontColor.withOpacity(0.2))),
        ]),
        const SizedBox(height: 30),
        OutlinedButton.icon(
          icon: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png',
            height: 24,
          ),
          label: Text('Google', style: TextStyle(color: AppTheme.fontColor)),
          onPressed: _isLoading ? null : _loginWithGoogle,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.fontColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.white.withOpacity(0.2),
            side: BorderSide(color: AppTheme.fontColor.withOpacity(0.2)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        */
        const SizedBox(height: 40),
      ],
    );
  }
}

