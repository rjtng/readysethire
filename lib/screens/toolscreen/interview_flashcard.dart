import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Data Models & Data ---

class Flashcard {
  final String question;
  final String explanation;
  final String exampleAnswer;

  Flashcard({
    required this.question,
    required this.explanation,
    required this.exampleAnswer,
  });
}

class AptitudeTestData {
  static List<Flashcard> interviewFlashcards = [
    Flashcard(
      question: 'Describe a project you worked on.',
      explanation:
      'In this question, the interviewer is asking for details about a specific project you have worked on to gain insights about your project experience, your approach to problem-solving, your teamwork and collaboration skills, and how you handle challenges and setbacks. This is your opportunity to showcase a project that makes you proud, or one where you made a significant contribution.\n\nWhen answering this question:\nChoose a project that is relevant to the job role you are applying for.\nDescribe the project briefly. What was the goal/end result?\nExplain your role in the project.\nDiscuss the methods or steps you took to execute this project. This will help show your problem-solving skills.\nTalk about the outcome. Did it meet its objectives? What was your learning from it?\nHighlight any challenges or roadblocks you encountered, and how you overcame them.\n\nAlways remember, the goal is to portray not just what you did, but how you did it, and its impact.',
      exampleAnswer:
      'In my previous job as a software developer, one of the projects I am most proud of is the development of a company-wide, real-time reporting system. The purpose of this project was to improve the efficiency and quality of management reports.\n\nI served as the lead developer on a team of five. I was responsible for overseeing the technical aspects of development, including writing code, debugging, and ensuring the quality and timeliness of deliverables.\n\nOne challenge we faced was integrating our new system with the different existing databases. Through careful analysis, brainstorming sessions with the team, and constant trial and error, we successfully resolved the issue.\n\nThe project was a success, it improved the accuracy and speed of producing reports by 30%. Working on this project, I developed my leadership skills, became more proficient with a couple of programming languages, and learned how to effectively solve problems as a team and integrate different databases.',
    ),
    Flashcard(
      question:
      'Tell me about a situation that required you to dig deep to get to the root cause.',
      explanation:
      'The interviewer asking "Tell me about a situation that required you to dig deep to get to the root cause" wants to explore your problem-solving skills. They want to understand how you handle problems, what steps you take to identify the issue, and how you work towards implementing a solution. This question also gives them insights into your ability to remain focused, show resilience, and work independently under challenging situations.\n\nWhen answering this question, you should aim to express:\nA significant problem or challenge that you faced.\nHow you analyzed the situation to identify the issue.\nThe steps and strategies you took to overcome the problem.\nThe results of your action.',
      exampleAnswer:
      'During my tenure as a Project Manager with XYZ corp., we encountered a situation where three out of five projects were significantly over budget and delayed. Recognizing its impact, I took the initiative to get at the root of the problem.\n\nAfter going through project budget reports and talking to team leaders, I discovered that the main issue was the ineffective use of resources. There was a clear lack of understanding amongst team members about project goals, timelines, and a lot of time was wasted on rework.\n\nI proposed and implemented a new protocol, which included weekly team meetings for clear communication, documented project plans with defined milestones, and regular training programs to improve skills. These changes helped in eliminating ambiguity and improved the efficiency of teams. Within six months, all three projects were back on track and we not only saved the company a significant amount of money but also improved the client’s confidence in our ability to deliver.',
    ),
    Flashcard(
      question: 'Tell me about yourself.',
      explanation:
      'When an interviewer asks the question, "Tell me about yourself," it\'s an invitation for the interviewee to highlight their professional background, skills, and achievements. This is typically the first question in an interview, and it\'s a fantastic opportunity to set the tone for the rest of the interview.\n\nWhile answering this question, follow a structured method. One such method is the Present-Past-Future formula:\nPresent: Talk about what you are currently doing.\nPast: Discuss your past experiences and achievements that brought you to the present stage in your career.\nFuture: Highlight your future ambitions and why you are excited about the job you are applying for.\nAvoid sharing personal information unless it directly relates to the job for which you are being interviewed. Keep your answer concise and focused on your career.',
      exampleAnswer:
      'I\'m a recent graduate with a degree in [your course] from [university graduated]. Right now, I\'m actively seeking opportunities where I can apply the knowledge and skills I’ve developed during my academic journey, particularly in areas like [mention a specialization or field you\'re interested in]. In my final year, I worked on several projects that challenged me to think critically and collaborate effectively with a team, especially when solving real-world problems.\n\nBack in university, I took every opportunity to get involved in activities beyond the classroom—from volunteering in tech events to joining student-led organizations. These experiences helped me improve not just my technical abilities, but also my communication and leadership skills. I also spent a lot of time learning tools and platforms on my own, which allowed me to build confidence in handling different types of challenges.\n\nNow, I’m eager to begin the next phase of my career where I can grow further, contribute to meaningful projects, and continuously improve. I’m particularly excited about roles that offer mentorship and hands-on experience, as I believe that being in a supportive learning environment is key to professional growth.',
    ),
    Flashcard(
      question: 'What are your weaknesses and strengths?',
      explanation:
      'This question is a classic one used by interviewers to evaluate your self-awareness, honesty, and ability to improve from past experiences. They want to know if you can be objective about your skills and abilities, highlighting what you do well, but also showing that you have humility to acknowledge areas where you can improve.\n\nYour strengths must demonstrate abilities and skills relevant to the job role, while your weaknesses must show both self-awareness and an initiative to learn and progress. Remember, don\'t mention a weakness that is a critical requirement for the job. It\'s beneficial to choose a weakness that you\'re actively working on improving, this shows the interviewer that you can take initiative in personal development.',
      exampleAnswer:
      'Strengths: "One of my key strengths is communication. I can comfortably speak in large groups, write comprehensive reports, and can establish rapport with a wide variety of people. During my last job at XYZ Company, I often had to present complex information to clients, which was a task I excelled at.\n\nWeaknesses: My biggest weakness is that I\'m a perfectionist. I have often found myself spending too much time checking over my work for the smallest mistakes that might not even exist; to overcome it, I\'ve learned to set deadlines for reviews which has improved my efficiency.\n\nExample Answer 2:\nStrengths: "I pride myself on my problem-solving skills. They have been very useful throughout my career especially when dealing with issues like software bugs and production disruptions. It\'s satisfying to resolve issues quickly and efficiently to maintain workflow continuity.\n\nWeaknesses: In terms of weaknesses, I\'m aware that I can get too engrossed in the details of a project and lose sight of the bigger picture. To balance this, I\'ve started practicing time-management techniques, and I am learning to delegate tasks more effectively."',
    ),
    Flashcard(
      question:
      'How do you approach debugging a complex software issue when the root cause is not immediately apparent?',
      explanation:
      'This question is asking about your problem-solving approach when facing unclear or difficult issues in software debugging. It\'s important to demonstrate a structured method. Key points to consider in your response include: identifying and isolating the problem, using data analysis and logging tools, researching known issues, collaborating with team members, and being methodical in testing solutions to narrow down potential causes. Also, highlighting a positive outcome from your approach can be beneficial.',
      exampleAnswer:
      'When I encounter a complex software issue, I start by clearly defining the problem and gathering any relevant context. I check logs and error messages to gather statistics that may guide my investigation. After that, I create a hypothesis based on my findings and conduct tests to confirm or deny my assumptions. For instance, in my previous project, I faced a persistent crash issue. By analyzing usage patterns and error frequencies, I discovered that a specific user action triggered a race condition. This led us to apply a patch that resolved the issue without further complaints.\n\nExample Answer 2:\nIn situations where the root cause of a software issue isn\'t clear, I first replicate the problem in a controlled environment. I utilize tools to collect metrics and logs related to the issue. I also consult documentation and resources to determine if the problem might be a known issue. Once I have sufficient data, I perform a series of tests, focusing on one component at a time to identify abnormalities. For example, I once dealt with a performance drop in a web application. After isolating the components, it became evident that a third-party API was introducing latency, which I mitigated with caching strategies.',
    ),
    Flashcard(
      question:
      'How do you approach problem-solving in high-pressure situations while maintaining productivity and focus?',
      explanation:
      'This question is asking you to articulate your process for problem-solving specifically when under high-pressure circumstances. \n\nTo answer effectively, consider the following points: \n1. Describe your initial reaction to pressure situations. \n2. Explain your problem-solving methodology (e.g., breaking down the issue, prioritizing tasks). \n3. Share an example showcasing your focus and productivity in such scenarios. \n4. Reflect on what you learned from these experiences.',
      exampleAnswer:
      'In high-pressure situations, I first take a deep breath and assess the situation to avoid making rash decisions. I break down the problem into smaller, manageable parts and prioritize them based on urgency and impact. For instance, during a project deadline crunch, I once faced a critical issue with a client\'s software. I quickly gathered my team, delegated tasks based on each member’s strengths, and established clear deadlines. By maintaining open communication and focusing on solutions rather than the pressure, we met the deadline and exceeded client expectations.\n\nExample Answer 2:\nWhen confronted with high-pressure scenarios, I maintain my productivity by implementing a structured approach. I often start by identifying the core issue at hand and outline a plan of action. For instance, during a recent event planning crisis where key vendors pulled out last minute, I immediately created a list of alternative vendors and prioritized outreach based on availability. By keeping my focus on solutions and using a systematic approach, I managed to secure replacements in time for the event, ensuring everything ran smoothly despite the initial setbacks.',
    ),
    Flashcard(
      question:
      'What strategies do you use to prioritize tasks and manage time effectively in high-pressure environments?',
      explanation:
      'This question is designed to assess your ability to manage time and prioritize tasks, especially in high-pressure situations. The interviewer wants to understand your thought process and strategies you employ to remain productive and organized. \n\nTo effectively answer this question, you should: \n1. Describe specific strategies or methods you use (e.g., prioritization frameworks like Eisenhower Matrix). \n2. Provide an example of a high-pressure situation where you applied these strategies effectively. \n3. Highlight the outcome of your approach to emphasize its effectiveness.',
      exampleAnswer:
      'In high-pressure situations, I rely on a combination of the Eisenhower Matrix and digital project management tools. For instance, during a recent project deadline at my previous job, I identified urgent and important tasks using the matrix, allowing me to focus on what truly mattered. I made a detailed checklist in my project management software, breaking down tasks into manageable portions. As a result, I completed the project two days early, allowing additional time for final revisions.\n\nExample Answer 2:\nI prioritize tasks in high-pressure environments by implementing a daily planning routine and using time-blocking techniques. An example of this was when I was leading a critical client presentation. I started by listing all the tasks that needed completion, categorized them by urgency and importance, and allocated specific time slots for each task in my calendar. This method not only kept me organized but also helped me reduce stress, ultimately leading to a smooth presentation day and positive feedback from the client.',
    ),
    Flashcard(
      question:
      'Talk about a time when you worked on a team and demonstrated leadership',
      explanation:
      'This question is asking you to provide an example from your past experiences where you were part of a team and took on a leadership role. Ideally, your answer will demonstrate to the interviewer that you possess good teamwork and leadership skills, and you\'re able to collaborate with peers while also being capable of taking the lead when the situation demands it. When structuring your response, try to follow the STAR (Situation, Task, Action, Result) format. Elaborate on where you were working or what the project was (Situation). Then talk about what your team was asked to do (Task). Then describe what steps you took, specifically as a leader (Action). Lastly, how did your leadership contribute to the team\'s success (Result)?',
      exampleAnswer:
      'In my previous role as a project coordinator at an advertising company, I had the opportunity to lead a team of five to deliver a complex project for a major client (Situation). The project required us to develop a comprehensive digital marketing strategy within a highly tight deadline (Task). Recognizing the intense workload and time constraint, as a leader, I brainstormed with my team to arrange the tasks based on each individual\'s strengths and split the workload evenly amongst team members. I maintained open and regular communication to ensure we were all aligned with our goals. I also arranged weekly team meetings to discuss our progress and resolve any issues that arose (Action). The result was that we finished the task 3 days ahead of the deadline with an outcome that exceeded the client’s expectations. The client praised our team’s dedication and the quality of our recommended strategy (Result).\n\nExample Answer 2:\nIn my final year at [university graduated], I led our capstone project team in developing a web application. At first, we faced challenges in dividing responsibilities and staying on track. I stepped up by assigning clear roles, setting deadlines, and holding regular check-ins to keep everyone aligned. I also made sure each member’s input was valued to keep motivation high. In the end, we submitted the project ahead of time and received positive feedback from our panel. The experience helped me grow as a team player and as someone who can guide a group toward a shared goal.',
    ),
    Flashcard(
      question:
      'How do you approach troubleshooting a critical production system failure under tight deadlines?',
      explanation:
      'This question is about assessing your problem-solving skills and ability to work under pressure. Troubleshooting a critical production system failure requires a systematic approach, decisive action, and effective communication. \n\nTo answer this question, consider the following key points: \n1. Identify the problem: Quickly assess the situation to understand what exactly has failed. \n2. Gather relevant information: Collect data, logs, and user feedback to help diagnose the issue. \n3. Prioritize actions: Determine which issues are most critical to resolve first. \n4. Communicate clearly: Keep stakeholders informed of your progress and any potential impacts. \n5. Implement a solution and monitor: Once a potential fix is identified, apply it and monitor the system closely for any further issues. \n6. Post-mortem analysis: After resolution, review the incident to prevent future occurrences.',
      exampleAnswer:
      'When facing a critical production system failure under tight deadlines, my first step is to quickly identify the nature of the problem by checking the error logs and speaking to the affected users. I then prioritize the issues based on their impact on the system\'s functionality. For example, if the failure affects customer transactions, that would become my top priority. Once I have identified the primary issue, I communicate with my team and stakeholders to keep everyone informed about the status. After implementing the fix, such as rolling back a recent deployment or modifying configuration settings, I continuously monitor the system for stability. Finally, I ensure that a thorough post-mortem is conducted to analyze what went wrong and develop preventive measures for the future.\n\nExample Answer 2:\nIn the event of a critical failure in a production system, I adopt a structured approach to troubleshooting. First, I assess the situation by gathering all relevant data and alerts to pinpoint the source of the failure. For instance, if I notice a spike in error rates following a new feature launch, that would be my starting point. I prioritize resolving the issue that has the greatest impact, focusing on restoring system functionality as quickly as possible. I communicate my findings and actions to the team while collaborating to brainstorm additional solutions. After applying a fix, like optimizing the code or scaling the database, I closely monitor performance metrics. Once stability is achieved, I lead a review meeting to discuss the incident and document lessons learned for future reference.',
    ),
    Flashcard(
      question:
      'How would you approach handling a difficult client and provide a solution that satisfies both parties?',
      explanation:
      'This question is trying to assess your conflict resolution skills, as well as your abilities to maintain good client relationships and deliver customer satisfaction. The employer wants to understand how you deal with challenging situations and difficult stakeholders, and how you strive towards proposing solutions that are mutually beneficial to both the client and the organization. \n\nWhen answering this question, make sure to emphasize your:\nProblem-solving abilities\nCommunication skills\nEmpathy and understanding towards the client\nNegotiation skills\nBalancing clients’ needs and organization’s interests\nProfessionalism and patience\n\nYou should sequence your answer in terms of identifying the problem, understanding the client\'s perspective, developing a solution, and negotiating to ensure that both parties are satisfied with the outcome.',
      exampleAnswer:
      'During our internship project at [company or university program], we had a client who kept requesting changes that weren’t aligned with the initial scope. Instead of pushing back right away, I first listened to understand their concerns. I acknowledged their needs, then explained the limitations and how it could affect our timeline. After discussing with my team, I proposed a compromise — we prioritized the most critical changes within the deadline and scheduled the rest for future iterations. The client appreciated the transparency, and we maintained a good working relationship. I learned that empathy, clear communication, and setting expectations early can turn a difficult situation into a productive one.',
    ),
  ];
}

// --- App Theme Data ---
// Note: It's better practice to have this in its own file (e.g., theme/app_theme.dart)
// to avoid conflicts, but keeping it here as per the original structure.
class AppTheme {
  // Core color palette
  static const Color primaryColor = Color(0xFFD185A6); // Muted Pink
  static const Color fontColor = Color(0xFF491D7F); // Dark Purple

  // Background gradient colors
  static const Color backgroundStart = Color(0xFFEADFF0);
  static const Color backgroundEnd = Color(0xFFFDEFF4);

  // The main theme data for the application
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.transparent, // Required for gradient
      primaryColor: primaryColor,
      fontFamily: GoogleFonts.b612Mono().fontFamily,
      textTheme: TextTheme(
        // Style for large display text (e.g., screen titles)
        displayLarge: TextStyle(
            color: fontColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        // Style for titles (e.g., card headers)
        titleLarge: TextStyle(
            color: fontColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        // Style for primary body text
        bodyLarge: TextStyle(
            color: fontColor,
            fontSize: 16,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        // Style for secondary body text
        bodyMedium: TextStyle(
            color: fontColor,
            fontSize: 14,
            fontFamily: GoogleFonts.b612Mono().fontFamily),
        labelLarge: TextStyle(
            color: fontColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.b612Mono().fontFamily), // For solid buttons
      ),
      iconTheme: const IconThemeData(color: fontColor),
    );
  }
}

// --- Custom Reusable Widgets ---

// A reusable widget to apply a consistent gradient background to screens.
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.backgroundStart, AppTheme.backgroundEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}

// Displays the application logo.
class LogoWidget extends StatelessWidget {
  final double size;
  const LogoWidget({super.key, this.size = 150});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://i.imgur.com/jStHkjp.png', // Logo URL
      height: size,
      width: size,
      // Fallback in case the image fails to load
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.style, size: size, color: AppTheme.primaryColor);
      },
    );
  }
}

// A solid button to match the new designs.
class SolidButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const SolidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppTheme.primaryColor,
    this.textColor = AppTheme.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        elevation: 2,
      ),
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: textColor)),
    );
  }
}

// Reusable App Header for game-related screens.
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
        const Divider(color: AppTheme.primaryColor, thickness: 1),
      ],
    );
  }
}

// --- Flashcard Screens ---

class FlashcardIntroScreen extends StatelessWidget {
  const FlashcardIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const GameAppHeader(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.fontColor, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Icon(Icons.style,
                      size: 100, color: AppTheme.primaryColor.withOpacity(0.8)),
                  const SizedBox(height: 20),
                  Text('Interview Flashcards',
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 16),
                  Text(
                    'Practice makes perfect. Flip through a curated deck of flashcards designed to help you prepare for common interview questions, understand the logic behind them, and formulate compelling answers that showcase your skills. Each card features a question on the front and a detailed breakdown on the back, complete with example answers and expert tips. This is your personal study tool to build confidence and ensure you\'re never caught off guard in an interview. Ready to ace it?',
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 80),
                  SolidButton(
                    text: 'Start',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FlashcardScreen()),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  late List<Flashcard> _shuffledFlashcards;
  int _currentIndex = 0;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    // Create a shuffled copy of the flashcards when the screen is first built.
    _shuffledFlashcards = List.of(AptitudeTestData.interviewFlashcards)
      ..shuffle();
  }

  void _nextCard() {
    setState(() {
      if (_currentIndex < _shuffledFlashcards.length - 1) {
        _currentIndex++;
        _isFlipped = false;
      } else {
        // When all cards are viewed, pop back to the intro screen.
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the shuffled list to get the current flashcard.
    final flashcard = _shuffledFlashcards[_currentIndex];
    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const GameAppHeader(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.exit_to_app,
                        color: AppTheme.fontColor, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFlipped = !_isFlipped;
                      });
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SingleChildScrollView(
                          child: _isFlipped
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Explanation',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(height: 8),
                              Text(flashcard.explanation,
                                  style:
                                  const TextStyle(fontSize: 14, height: 1.4)),
                              const SizedBox(height: 24),
                              const Text('Example Answer',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                              const SizedBox(height: 8),
                              Text(flashcard.exampleAnswer,
                                  style:
                                  const TextStyle(fontSize: 14, height: 1.4)),
                            ],
                          )
                              : Center(
                            child: Text(
                              flashcard.question,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SolidButton(
                  text: 'Next',
                  onPressed: _nextCard,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
