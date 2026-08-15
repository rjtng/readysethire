import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';
import 'package:readysethire/screens/placeholders/Resume/academic_background_screen.dart';

/// A widget that enforces a minimum resume progress level before showing [child].
///
/// minLevel values: 'none', 'basic', 'academic', 'experience', 'completed'
class RequireProgress extends StatelessWidget {
  final String minLevel;
  final Widget child;

  const RequireProgress({Key? key, required this.minLevel, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResumeDataProvider>(context);
    final userLevel = provider.progressLevel;

    const order = ['none', 'basic', 'academic', 'experience', 'completed'];
    final userIdx = order.indexOf(userLevel);
    final minIdx = order.indexOf(minLevel);

    final allowed = userIdx != -1 && minIdx != -1 && userIdx >= minIdx;

    if (allowed) return child;

    return Scaffold(
      appBar: AppBar(title: const Text('Complete your resume')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'You need to complete your resume up to the Experience section to access this feature.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate user to Academic Background (they can continue the flow from there)
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AcademicBackgroundScreen()),
                  );
                },
                child: const Text('Continue to Academic Background'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Optionally let user go back home
                  Navigator.of(context).pop();
                },
                child: const Text('Go back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

