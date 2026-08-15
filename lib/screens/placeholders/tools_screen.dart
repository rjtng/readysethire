import 'package:flutter/material.dart';
import 'package:readysethire/screens/toolscreen/aptitude_game.dart';
import 'package:readysethire/screens/toolscreen/history_screen.dart';
import 'package:readysethire/screens/toolscreen/interview_chatbot.dart' hide MockInterviewIntroScreen;
import 'package:readysethire/screens/toolscreen/interview_flashcard.dart' hide AppTheme, LogoWidget, GameAppHeader;
import 'package:readysethire/screens/toolscreen/interview_guide_hub.dart';
import 'package:readysethire/screens/toolscreen/mock_interview.dart';
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/widgets/custom_app_header.dart';
import 'package:readysethire/widgets/logo_widget.dart';
import 'package:readysethire/widgets/styled_card.dart';

// This header was defined locally, it's better to use a shared widget
// or ensure this local definition is what you want.
// If you have a shared `GameAppHeader` widget, you can remove this class
// and import it from its file.
class GameAppHeader extends StatelessWidget {
  const GameAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const LogoWidget(size: 40),
            const SizedBox(width: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ReadySetHire',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18)),
                Text('Build Your Future with Confidence',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Removed 'const' because AppTheme.primaryColor is not a compile-time constant
        Divider(color: AppTheme.primaryColor, thickness: 1),
      ],
    );
  }
}

// Dummy screen to navigate to (you can keep this for other tools)
class ToolDetailScreen extends StatelessWidget {
  final String title;

  const ToolDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('This is the page for $title'),
      ),
    );
  }
}

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  void _navigateToTool(BuildContext context, String title) {
    if (title == 'Mock Interview') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MockInterviewIntroScreen(),
        ),
      );
    } else if (title == 'Interview Chatbot') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const InterviewChatbotIntroScreen(),
        ),
      );
    } else if (title == 'Aptitude Game') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AptitudeGameIntroScreen(),
        ),
      );
    } else if (title == 'Interview Flashcards') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FlashcardIntroScreen(),
        ),
      );
    } else if (title == 'Interview Guide Hub') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const InterviewGuideHubScreen(),
        ),
      );
    } else if (title == 'History') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HistoryScreen(),
        ),
      );
    } else {
      // Handle all other tool cards with the generic screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ToolDetailScreen(title: title),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tools = [
      {
        'icon': Icons.mic,
        'title': 'Mock Interview',
        'description': 'Practice your verbal communication',
      },
      {
        'icon': Icons.chat,
        'title': 'Interview Chatbot',
        'description': 'Sharpen your thinking through realistic interview chats',
      },
      {
        'icon': Icons.sports_esports,
        'title': 'Aptitude Game',
        'description': 'Level up your test-taking strategies',
      },
      {
        'icon': Icons.history,
        'title': 'History',
        'description': 'Review your past performances',
      },
      {
        'icon': Icons.style,
        'title': 'Interview Flashcards',
        'description': 'Flip. Learn. Nail your next interview.',
      },
      {
        'icon': Icons.help_outline,
        'title': 'Interview Guide Hub',
        'description': 'From resume hacks to interview strategies, find the support you need to move forward',
      },
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppHeader(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Choose Your Tools',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.fontColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: tools.length,
                    itemBuilder: (context, index) {
                      final tool = tools[index];
                      return InkWell(
                        onTap: () {
                          _navigateToTool(context, tool['title']);
                        },
                        child: StyledCard(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  tool['icon'],
                                  size: 35,
                                  color: AppTheme.primaryColor,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  tool['title'],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  tool['description'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color:
                                    AppTheme.fontColor.withOpacity(0.7),
                                    fontSize: 7,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

