import 'package:flutter/material.dart';
import 'package:readysethire/widgets/gradient_background.dart';
import 'package:readysethire/widgets/logo_widget.dart';

class AuthScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AuthScreen({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LogoWidget(size: 100),
                const SizedBox(height: 30),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 40),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}