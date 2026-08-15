import 'package:flutter/material.dart';
import 'package:readysethire/widgets/custom_app_header.dart';

// The screen widget that displays the powerful features page
class PowerfulFeaturesScreen extends StatelessWidget {
  const PowerfulFeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for the feature cards, based on your provided code
    final List<Map<String, dynamic>> features = [
      {
        'icon': Icons.mic,
        'title': 'AI-Powered Mock HR Interview',
        'description':
        'Engage in a realistic mock interview where the AI generates questions based on your résumé information. Each session is customized to your background and experience, providing a practical and immersive way to develop your soft skills and interview confidence..',
      },
      {
        'icon': Icons.computer,
        'title': 'Authority-Level Interview Training',
        'description':
        'Prepare for real-world hiring scenarios with AI-driven mock interviews tailored to your chosen level of authority—operations, supervisory, or managerial. Each interview type is designed to reflect authentic workplace expectations and leadership responsibilities.',
      },
      {
        'icon': Icons.feedback_outlined,
        'title': 'Real-Time AI Feedback',
        'description':
        'Receive instant, data-driven feedback as you answer. The AI evaluates your responses in real time, scoring your clarity, confidence, and relevance with percentage-based results to show how well you’re performing throughout the interview.',
      },
      {
        'icon': Icons.slideshow,
        'title': 'Tailored Interview Simulation',
        'description':
        'Experience a personalized interview flow powered by AI that adapts to the details in your uploaded résumé. The system analyzes your background to generate realistic interview questions, creating an adaptive and authentic simulation that mirrors real hiring experiences.',
      },
      {
        'icon': Icons.summarize,
        'title': 'AI-Driven Interview Summary & Action Plan',
        'description':
        'Conclude your mock interview with a comprehensive AI-generated report featuring percentage scores for each performance area. Gain insights into your strengths, identify areas for growth, and receive personalized action plans with tailored tips and resources to enhance your future interview performance.',
      },
      {
        'icon': Icons.gamepad_outlined,
        'title': 'Gamified Aptitude Test Preparation',
        'description':
        'Strengthen your decision-making skills through interactive, game-based situational judgment scenarios. The AI presents realistic workplace situations where you choose the best response, helping you develop practical judgment, adaptability,leadership , and other skills in an engaging way.',
      },
      {
        'icon': Icons.person,
        'title': 'User Profile Customization',
        'description':
        'Personalize your dashboard and take control of your interview journey. Edit and update your résumé information anytime to match your career goals for a more tailored experience on the platform.',
      },
      {
        'icon': Icons.description,
        'title': 'Resume Optimizer & Tips Section',
        'description':
        'Enter your personal and professional information, and the system will automatically generate a complete, well-formatted résumé. Easily download your generated résumé and use it for your job applications with just a few clicks.',
      },
    ];

    return Scaffold(
      // The body is wrapped in a container to apply the background gradient from your CSS
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.0, -1.0), // Approximates 299.08deg
            end: Alignment(1.0, 1.0),
            colors: [
              Color(0xFFDDC4E4), // #DDC4E4
              Color(0xFFFFF0F2), // #FFF0F2
            ],
            stops: [0.2984, 0.7419], // Corresponding to 29.84% and 74.19%
          ),
        ),
        // SafeArea ensures content is not obscured by system UI (like notches)
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                // Integrated Header
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: CustomAppHeader(),
                ),
                const SizedBox(height: 24.0),

                // Top "Powerful Features" badge section
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE0EE),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE8A0BF)),
                  ),
                  child: const Text(
                    'Powerful Features',
                    style: TextStyle(
                      color: Color(0xFF491D7F),
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Main heading
                const Text(
                  'Everything You Need to\nSucceed in Interviews',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF491D7F),
                    fontSize: 16, // Adjusted for better responsiveness
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                // Sub-heading description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Our AI-powered platform provides comprehensive tools to help you prepare, practice, and perform at your best in any interview scenario.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1B003C),
                      fontSize: 9,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Grid view for laying out the feature cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 32.0,
                      childAspectRatio: 0.85, // Adjust card shape
                    ),
                    itemCount: features.length,
                    itemBuilder: (context, index) {
                      final feature = features[index];
                      // Each grid item is a Stack to position the icon over the card
                      return Stack(
                        clipBehavior: Clip.none, // Allows icon to sit outside
                        alignment: Alignment.topCenter,
                        children: [
                          // The main feature card container
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE0EE),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x99E8A0BF), // Shadow with some opacity
                                  blurRadius: 10,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  feature['title'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF491D7F),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 9, // Font size from CSS
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Expanded(
                                  child: Text(
                                    feature['description'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xFF491D7F),
                                      fontSize: 7, // Font size from CSS
                                      height: 1.2,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // The circular icon positioned on top of the card
                          Positioned(
                            top: -2,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE8A0BF),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                feature['icon'],
                                color: const Color(0xFF491D7F),
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

