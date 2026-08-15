import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../placeholders/tools_screen.dart' show GameAppHeader;
import 'guide_data_models.dart'; // Corrected: Imports shared widgets

// --- Data Source ---
final Guide howToDressGuide = Guide(
  title: 'How To Dress for a Job Interview',
  subtitle:
  'Dress smart, feel confident—how to choose the right interview attire.',
  icon: Icons.business_center,
  content: [
    GuideContent(
      title: 'Research the company\'s dress code',
      text:
      'When you\'re preparing for your interview, consider researching the company\'s dress code to learn more about their expectations. Even if their dress code is casual, it may benefit you to look more professional than the employer requires.',
    ),
    GuideContent(
      title: 'Choose clothing that matches the climate and season',
      text:
      'To ensure you\'re comfortable during your interview, try to choose clothes that align with the climate and season. For example, you may not want to wear sandals if it\'s raining outside.',
    ),
    GuideContent(
      title: 'Check for pet hair or any noticeable defects',
      text:
      'Another way to ensure you look professional for your interview is to check your clothing for any pet hair, holes or stains. You may not want to wear clothing items with these details since it can prevent the interviewer from focusing on your professionalism and credentials.',
    ),
    GuideContent(
      title: 'Ensure clothing is pressed and wrinkle-free',
      text:
      'Regardless of what you decide to wear to your interview, it\'s a good idea to press, steam or iron your clothes before meeting with a prospective employer. This can help you show that you took time to prepare for the interview and care about your appearance in the workplace.',
    ),
    GuideContent(
      title: 'Choose your outfit in advance',
      text:
      'The night before your interview, consider laying out or hanging up the outfit you plan to wear. This can help you save time and allow you to review all the clothing items together to make sure they match and suit the role for which you\'re applying.',
    ),
    GuideContent(
      title: 'Be yourself',
      text:
      'You can use an interview as an opportunity to display your personality and show a hiring manager more about yourself than what\'s listed on your application documents. For example, if you like bold colors, then you may choose to wear a bright-colored top with neutral pants.',
    ),
  ],
);

// --- UI Screen Entry ---
class HowToDressScreen extends StatelessWidget {
  const HowToDressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GuideDetailScreen(guide: howToDressGuide);
  }
}

// --- Generic Detail Screen Widget ---
class GuideDetailScreen extends StatefulWidget {
  final Guide guide;
  const GuideDetailScreen({super.key, required this.guide});

  @override
  State<GuideDetailScreen> createState() => _GuideDetailScreenState();
}

class _GuideDetailScreenState extends State<GuideDetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF2E6FF), Color(0xFFFFF9FB)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const GameAppHeader(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Color(0xFF491D7F), size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.guide.content.length,
                    itemBuilder: (context, index) {
                      final content = widget.guide.content[index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 32),
                            Icon(widget.guide.icon,
                                size: 80, color: const Color(0xFF491D7F)),
                            const SizedBox(height: 16),
                            Text(content.title,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.b612Mono(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF491D7F))),
                            const SizedBox(height: 24),
                            Text(content.text,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.b612Mono(
                                    height: 1.5,
                                    fontSize: 14,
                                    color: const Color(0xFF491D7F))),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Color(0xFF491D7F)),
                      onPressed: _currentPage > 0
                          ? () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      )
                          : null,
                    ),
                    Text(
                        'Page ${_currentPage + 1} of ${widget.guide.content.length}'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Color(0xFF491D7F)),
                      onPressed: _currentPage < widget.guide.content.length - 1
                          ? () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
