import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'dart:math'; // For Random and pow
import 'dart:async';

import 'package:provider/provider.dart';
import '../../models/resume_data.dart';

import '../../models/test_result_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/logo_widget.dart';
import 'history_services.dart'; // For Future.delayed


// ================================================================
// Gemini AI Service - REVISED WITH EXPONENTIAL BACKOFF AND KEY ROTATION
// =================================================================
class GeminiAIService {
  // IMPORTANT: Replace with actual, secure keys in a production environment.
  static const List<String> _apiKeys = [
    'AIzaSyDOD8OD18Xj69VB642hhzhVZbjuJZAA3p8', // Placeholder Primary Key
    'AIzaSyDiFV6ASAjCejMUiaAjVWLhyAaNBrDyyZA', // Placeholder Secondary/Fallback Key
  ];
  static const String _url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  /// Generates content using the Gemini API with exponential backoff and key rotation.
  static Future<String> generateContent(String prompt) async {
    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ],
      // Adding safety settings for completeness, though default is usually fine.
      "safetySettings": [
        {"category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_NONE"},
        {"category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_NONE"}
      ]
    });

    String? lastError;
    final random = Random();
    int keyIndex = 0;

    for (int attempt = 0; attempt < 5; attempt++) { // Total of 5 attempts
      final apiKey = _apiKeys[keyIndex];
      try {
        final response = await http.post(
          Uri.parse('$_url?key=$apiKey'),
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        // Success Case
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['candidates'] != null &&
              data['candidates'].isNotEmpty &&
              data['candidates'][0]['content'] != null &&
              data['candidates'][0]['content']['parts'] != null &&
              data['candidates'][0]['content']['parts'].isNotEmpty) {
            return data['candidates'][0]['content']['parts'][0]['text'].trim();
          }
          if (data['candidates'] != null &&
              data['candidates'].isNotEmpty &&
              data['candidates'][0]['finishReason'] == 'SAFETY') {
            return 'Error: The response was blocked due to safety settings.';
          }
          return 'Error: Received an invalid response format from the AI.';
        }
        // Retryable Error Case (e.g., 429 Too Many Requests, 5xx Server Errors)
        else if (response.statusCode == 429 || response.statusCode >= 500) {
          final errorBody = jsonDecode(response.body);
          final errorMessage = errorBody['error']?['message'] ?? 'Service overloaded.';
          lastError = 'Key failed (Status: ${response.statusCode}). Details: $errorMessage';

          // --- EXPONENTIAL BACKOFF LOGIC ---
          // Wait for 2^attempt seconds + random milliseconds
          final waitTime = Duration(seconds: pow(2, attempt).toInt(), milliseconds: random.nextInt(1000));
          await Future.delayed(waitTime);

          // Rotate to the next key for the next attempt
          keyIndex = (keyIndex + 1) % _apiKeys.length;
          continue; // Continue to the next attempt in the loop
        }
        // Non-Retryable Client Error Case
        else {
          final errorBody = jsonDecode(response.body);
          final errorMessage = errorBody['error']?['message'] ?? 'Unknown error';
          return 'Error: Failed to get a response from the AI. Status: ${response.statusCode}\nDetails: $errorMessage';
        }
      } catch (e) {
        // Network or other exceptions
        lastError = 'Failed to connect to the AI service. Details: $e';
        final waitTime = Duration(seconds: pow(2, attempt).toInt(), milliseconds: random.nextInt(1000));
        await Future.delayed(waitTime);
        keyIndex = (keyIndex + 1) % _apiKeys.length;
        continue;
      }
    }

    // Fallback error message if all retries and keys fail.
    return 'Error: The AI service is currently unavailable after multiple retries. Last error: ${lastError ?? "Unknown"}';
  }
}

class ChatbotAppHeader extends StatelessWidget {
  final String title;
  const ChatbotAppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const LogoWidget(size: 50),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF959FE2), Color(0xFF491D7F), Color(0xFFE8A0BF)],
                    stops: [0.226, 0.4615, 0.8269],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: Text(
                    'ReadySetHire',
                    style: GoogleFonts.b612Mono(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Build Your Future with Confidence',
                  style: GoogleFonts.b612Mono(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: const Color(0xFF656565),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 5,
          color: const Color(0xFFE8A0BF),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppTheme.fontColor),
          ),
        ),
      ],
    );
  }
}

// --- Interview Chatbot Screens ---

class InterviewChatbotIntroScreen extends StatelessWidget {
  const InterviewChatbotIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const ChatbotAppHeader(title: 'Interview Chatbot'),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withAlpha((0.2 * 255).round()),
                    ),
                    child: const Icon(Icons.chat_bubble,
                        size: 80, color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 20),
                  Text('Interview Chatbot',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppTheme.fontColor)),
                  const SizedBox(height: 16),
                  Text(
                    'Experience a realistic interview simulation where you interact with an AI chatbot acting as a real HR Manager. Practice your communication skills through dynamic questions tailored to your selected level of authority — operations, supervision, or management. Your performance score reflects how effectively you deliver your answers.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatbotLevelScreen()),
                      );
                    },
                    child: const Text('Start'),
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

class ChatbotLevelScreen extends StatelessWidget {
  const ChatbotLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const ChatbotAppHeader(title: 'Interview Chatbot'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.fontColor, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withAlpha((0.2 * 255).round()),
                    ),
                    child: const Icon(Icons.chat_bubble,
                        size: 80, color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 20),
                  Text('Select interview level:',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.fontColor)),
                  const SizedBox(height: 24),
                  _buildLevelButton(
                    context,
                    'Management Level',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatbotLevelDetailScreen(
                          level: 'Management',
                          description:
                          'This level is for senior roles and focuses on strategic thinking, leadership, and complex problem-solving.',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLevelButton(
                    context,
                    'Supervisory Level',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatbotLevelDetailScreen(
                          level: 'Supervisory',
                          description:
                          'This level is for team leads and supervisors, focusing on team management and operational oversight.',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildLevelButton(
                    context,
                    'Operations Level',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatbotLevelDetailScreen(
                          level: 'Operations',
                          description:
                          'This level is designed for entry-level staff roles and focuses on assessing your communication skills, basic teamwork abilities, adaptability, and problem-solving mindset. Get ready to answer practical questions and demonstrate how well you handle tasks and collaborate within a team. Good luck and show your best self!',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(
      BuildContext context, String title, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.fontColor,
        side: const BorderSide(color: AppTheme.primaryColor),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      ),
      child: Text(title),
    );
  }
}

class ChatbotLevelDetailScreen extends StatelessWidget {
  final String level;
  final String description;

  const ChatbotLevelDetailScreen(
      {super.key, required this.level, required this.description});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ChatbotAppHeader(title: '$level Level'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.fontColor, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withAlpha((0.2 * 255).round()),
                    ),
                    child: const Icon(Icons.chat_bubble,
                        size: 80, color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 20),
                  Text('$level Level',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: AppTheme.fontColor)),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InterviewChatbotScreen(interviewLevel: level),
                        ),
                      );
                    },
                    child: const Text('Next'),
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

class InterviewChatbotScreen extends StatefulWidget {
  final String interviewLevel;
  const InterviewChatbotScreen({super.key, required this.interviewLevel});

  @override
  State<InterviewChatbotScreen> createState() => _InterviewChatbotScreenState();
}

class _InterviewChatbotScreenState extends State<InterviewChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  // Track how many interviewer questions have been asked so difficulty can increase
  int _questionCount = 0;

  // Helper: extract candidate first name
  String _candidateFirstName() {
    try {
      final resume = Provider.of<ResumeDataProvider>(context, listen: false).resumeData;
      final name = resume.fullName.trim();
      if (name.isEmpty) return '';
      return name.split(' ').first;
    } catch (e) {
      return '';
    }
  }

  // Helper: produce concise candidate profile string
  String _candidateProfile() {
    try {
      final resume = Provider.of<ResumeDataProvider>(context, listen: false).resumeData;
      final buffer = StringBuffer();
      if ((resume.fullName.trim()).isNotEmpty) buffer.writeln('Name: ${resume.fullName.trim()}');
      if ((resume.emailAddress.trim()).isNotEmpty) buffer.writeln('Email: ${resume.emailAddress.trim()}');
      if ((resume.contactNumber.trim()).isNotEmpty) buffer.writeln('Contact: ${resume.contactNumber.trim()}');
      if ((resume.professionalSummary.trim()).isNotEmpty) buffer.writeln('Summary: ${resume.professionalSummary.trim()}');

      if (resume.academicEntries.isNotEmpty) {
        buffer.writeln('Academic Background:');
        for (final a in resume.academicEntries) {
          final school = (a.schoolName ?? '').trim();
          final degree = (a.degree ?? '').trim();
          final years = (a.yearStarted ?? '').trim();
          final end = a.isPresent ? 'Present' : (a.yearEnded ?? '').trim();
          if (school.isNotEmpty || degree.isNotEmpty) {
            buffer.writeln('- ${degree.isNotEmpty ? degree : 'Study'} at ${school.isNotEmpty ? school : 'Unknown'} (${years.isNotEmpty ? years : ''}${end.isNotEmpty ? ' - $end' : ''})');
          }
        }
      }

      if (resume.experienceEntries.isNotEmpty) {
        buffer.writeln('Experience:');
        for (final e in resume.experienceEntries) {
          final title = (e.jobTitle ?? '').trim();
          final company = (e.company ?? '').trim();
          final years = (e.startYear ?? '').trim();
          final end = e.isPresent ? 'Present' : (e.endYear ?? '').trim();
          final desc = (e.description ?? '').trim();
          if (title.isNotEmpty || company.isNotEmpty) {
            buffer.writeln('- ${title.isNotEmpty ? title : 'Role'} at ${company.isNotEmpty ? company : 'Unknown'} (${years.isNotEmpty ? years : ''}${end.isNotEmpty ? ' - $end' : ''})${desc.isNotEmpty ? ' : $desc' : ''}');
          }
        }
      }

      final skills = resume.skills.entries.where((kv) => kv.value).map((kv) => kv.key).toList();
      if (skills.isNotEmpty) buffer.writeln('Skills: ${skills.join(', ')}');

      final result = buffer.toString().trim();
      return result.isEmpty ? 'No candidate profile available.' : result;
    } catch (e) {
      debugPrint('Failed to read resume data: $e');
      return 'No candidate profile available.';
    }
  }

  String _difficultyLabel() {
    if (_questionCount < 2) return 'EASY';
    if (_questionCount < 5) return 'MEDIUM';
    return 'HARD';
  }

  // Sanitize the AI output to a single concise question
  String _sanitizeQuestion(String raw) {
    raw = raw.trim();
    raw = raw.replaceFirst(RegExp(r'^(Interviewer:|INTERVIEWER:|Q:|Question:|Interviewer\s*-)', caseSensitive: false), '').trim();
    final lines = raw.split('\n').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    String candidateLine = lines.isNotEmpty ? lines[0] : raw;
    final sentenceMatch = RegExp(r'[^?!.]*\?').firstMatch(candidateLine);
    if (sentenceMatch != null) candidateLine = sentenceMatch.group(0)!.trim();
    else {
      final sentenceMatch2 = RegExp(r'[^?!.]*\?').firstMatch(raw);
      if (sentenceMatch2 != null) candidateLine = sentenceMatch2.group(0)!.trim();
    }
    candidateLine = candidateLine.trim();
    if (!candidateLine.endsWith('?')) candidateLine = candidateLine + '?';
    if (candidateLine.length > 300) candidateLine = candidateLine.substring(0, 297).trim() + '...';
    return candidateLine;
  }

  @override
  void initState() {
    super.initState();
    // Start interview by requesting the first tailored question from the AI
    WidgetsBinding.instance.addPostFrameCallback((_) => _startInterview());
  }

  Future<void> _startInterview() async {
    setState(() => _isLoading = true);
    // Build prompt with empty history to request the opening question
    final profile = _candidateProfile();
    final difficulty = _difficultyLabel();
    final prompt = '''
    **Role:** Expert HR Interviewer for a ${widget.interviewLevel} role.
    **Candidate Profile:**
    $profile
    **Difficulty:** $difficulty
    **Instructions:** Ask one concise interview question (do NOT include a greeting). Tailor the question to the profile and chosen role level. Output only the question text.
    ''';

    final response = await GeminiAIService.generateContent(prompt);
    final questionLine = _sanitizeQuestion(response);
    final firstName = _candidateFirstName();
    String botText = questionLine;
    if (firstName.isNotEmpty) botText = 'Hi $firstName, ' + questionLine[0].toUpperCase() + questionLine.substring(1);

    setState(() {
      _messages.insert(0, ChatMessage(text: botText, isUser: false));
      _isLoading = false;
      _questionCount++;
    });
  }

  String _buildNextQuestionPrompt(String lastUserMessage) {
    final chatHistory = _messages.take(8).toList().reversed;
    final transcript = chatHistory
        .map((msg) => "${msg.isUser ? 'CANDIDATE' : 'INTERVIEWER'}: ${msg.text}")
        .join('\n');

    final profile = _candidateProfile();
    final difficulty = _difficultyLabel();

    return '''
    **Role:** Expert HR Interviewer for a ${widget.interviewLevel} role.
    **Candidate Profile:**
    $profile
    **Difficulty:** $difficulty
    **Goal:** Ask professional, insightful questions relevant to the role.
    **Style:** Use behavioral/situational questions. Ask logical follow-ups to probe details (STAR method thinking). Be neutral. Do NOT give feedback, advice, or evaluations. Do NOT include any greeting in your output.
    **History (Last 8 turns):
    $transcript
    **Task:** Generate the next single concise question in response to the candidate's last message.
    **Output:** ONLY the question text.
    ''';
  }

  void _handleSubmitted(String text) async {
    if (text.trim().isEmpty) return;

    final userResponse = text.trim();
    _controller.clear();

    setState(() {
      _messages.insert(0, ChatMessage(text: userResponse, isUser: true));
      _isLoading = true;
    });

    final prompt = _buildNextQuestionPrompt(userResponse);
    final response = await GeminiAIService.generateContent(prompt);
    final questionLine = _sanitizeQuestion(response);
    // Ensure no greeting from model; prepend app-managed greeting only for first question
    final firstName = _candidateFirstName();
    String botText = questionLine;
    if (_questionCount == 0 && firstName.isNotEmpty) {
      botText = 'Hi $firstName, ' + questionLine[0].toUpperCase() + questionLine.substring(1);
    }

    if (mounted) {
      setState(() {
        _messages.insert(0, ChatMessage(text: botText, isUser: false));
        _isLoading = false;
        _questionCount++;
      });
    }
  }

  double _extractScore(String feedback) {
    if (feedback.toLowerCase().startsWith('error:')) {
      return 0.0;
    }
    try {
      final scoreRegex = RegExp(r'Score: (\d+(\.\d+)?)/100');
      final match = scoreRegex.firstMatch(feedback);
      if (match != null && match.group(1) != null) {
        return double.parse(match.group(1)!);
      }
    } catch (e) {
      debugPrint('Error parsing score: $e');
      return 0.0;
    }
    return 0.0;
  }

  String _buildFeedbackPrompt() {
    final transcriptMessages = _messages.reversed.skip(1);
    final transcript = transcriptMessages
        .map((msg) => "${msg.isUser ? 'CANDIDATE' : 'INTERVIEWER'}: ${msg.text}")
        .join('\n');

    final profile = _candidateProfile();

    return '''
    **Role:** Objective, analytical career coach.
    **Candidate Profile:**
    $profile
    **Task:** Provide an evidence-based feedback report on the mock interview for a ${widget.interviewLevel} role. Base all analysis ONLY on the transcript and the provided profile.
    **Transcript:**
    $transcript
    **Output Format (Strict):**
    Score: [0-100 score]/100
    Overall Assessment: [2-3 sentence summary paragraph.]
    Soft Skills & Interpersonal Competencies: [In a single paragraph, evaluate the candidate's soft skills. Start by assessing their Communication Skills (clarity, tone, organization of written responses). Then, critically assess other demonstrated soft skills relevant to a ${widget.interviewLevel} position. Cite transcript examples to support your entire assessment.]
    Key Strengths: * [2-3 strengths with supporting transcript quotes/examples.]
    Key Weaknesses: * [2-3 weaknesses with supporting transcript quotes/examples.]
    Recommended Skill Improvements: * [Specific, actionable skills to develop, e.g., "Practice STAR method"].
    Next Steps to Improve Performance: * [2-3 actionable next steps related to weaknesses].
    **Instructions:** Use '*' for all list items. Start each section on a new line.
    ''';
  }

  void _endInterview() async {
    setState(() {
      _isLoading = true;
    });

    final userMessagesCount = _messages.where((msg) => msg.isUser).length;

    String feedback;
    double score;

    if (userMessagesCount == 0) {
      score = 0.0;
      feedback = """
Score: 0/100

Overall Assessment:
The interview was not completed as no answers were provided. To receive feedback, you must answer the interview questions.

Soft Skills & Interpersonal Competencies: N/A
Key Strengths: * N/A
Key Weaknesses: * Failed to provide any answers to the interview questions.
Recommended Skill Improvements: * Engage with the interview simulation by providing responses.
Next Steps to Improve Performance: * Try the interview again and answer the questions thoughtfully.
""";
    } else {
      if (mounted) {
        setState(() {
          _messages.insert(0, ChatMessage(text: "Generating your feedback...", isUser: false));
        });
      }

      final prompt = _buildFeedbackPrompt();
      feedback = await GeminiAIService.generateContent(prompt);

      if (feedback.toLowerCase().startsWith('error:')) {
        score = 0.0;
        feedback = """
Score: 0/100

Overall Assessment:
AI Service Error. Failed to generate detailed feedback. This is usually due to a network connection issue or service throttling.

Soft Skills & Interpersonal Competencies: Error during processing.
Key Strengths: * N/A
Key Weaknesses: * AI Service connection failed.
Recommended Skill Improvements: * Try submitting fewer, but more detailed, answers in the next session.
Next Steps to Improve Performance: * Check your internet connection and try again later.
""";
      }

      score = _extractScore(feedback);
    }

    final result = TestResult(
      type: 'Chatbot Interview',
      name: widget.interviewLevel,
      score: score,
      totalQuestions: 100, // This represents the max score, not question count
      date: DateTime.now(),
      feedback: feedback,
    );

    await HistoryService.saveResult(result);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChatbotResultsScreen(
            feedback: feedback,
            interviewLevel: widget.interviewLevel,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                ChatbotAppHeader(title: '${widget.interviewLevel} Level'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: Colors.red.shade700),
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('End Interview'),
                    onPressed: _endInterview,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) => _messages[index],
                  ),
                ),
                if (_isLoading) const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                const Divider(height: 1.0),
                _buildTextComposer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _controller,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(
                    hintText: _isLoading ? 'Waiting for AI response...' : 'Send a message'
                ),
                enabled: !_isLoading,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: _isLoading ? null : () => _handleSubmitted(_controller.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) const CircleAvatar(child: Icon(Icons.android)),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: isUser
                      ? AppTheme.primaryColor.withAlpha((0.2 * 255).round())
                      : AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.05 * 255).round()),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    )
                  ]
              ),
              child: Text(text, style: const TextStyle(color: AppTheme.fontColor)),
            ),
          ),
          if (isUser) const CircleAvatar(child: Icon(Icons.person)),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final bool isBulleted;

  const CustomCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.isBulleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final contentItems = content
        .replaceAll('*', '')
        .split('\n')
        .where((s) => s.trim().isNotEmpty)
        .toList();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).round()),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppTheme.fontColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title.replaceAll('*', ''),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.fontColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (isBulleted)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: contentItems.map((item) {
                final cleanItem =
                item.trim().replaceFirst(RegExp(r'^[-*]\s*'), '');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '• ',
                        style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.fontColor
                        ),
                      ),
                      Expanded(
                        child: Text(
                          cleanItem,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(height: 1.5, color: AppTheme.fontColor),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          else
            Text(
              content.replaceAll('*', ''),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(height: 1.5, color: AppTheme.fontColor),
            ),
        ],
      ),
    );
  }
}

class ChatbotResultsScreen extends StatelessWidget {
  final String feedback;
  final String interviewLevel;

  const ChatbotResultsScreen(
      {super.key, required this.feedback, required this.interviewLevel});

  double _extractScore(String feedback) {
    if (feedback.toLowerCase().startsWith('error:')) {
      return 0.0;
    }
    try {
      final scoreRegex = RegExp(r'Score: (\d+(\.\d+)?)/100');
      final match = scoreRegex.firstMatch(feedback);
      if (match != null && match.group(1) != null) {
        return double.parse(match.group(1)!);
      }
    } catch (e) {
      debugPrint('Error parsing score on results screen: $e');
      return 0.0;
    }
    return 0.0;
  }

  Map<String, String> _parseFeedback(String feedback) {
    final sections = <String, String>{};
    const headers = [
      'Score:',
      'Overall Assessment:',
      'Soft Skills & Interpersonal Competencies:',
      'Key Strengths:',
      'Key Weaknesses:',
      'Recommended Skill Improvements:',
      'Next Steps to Improve Performance:',
    ];

    final pattern = RegExp('(${headers.map(RegExp.escape).join('|')})', multiLine: true);
    final matches = pattern.allMatches(feedback).toList();

    for (int i = 0; i < matches.length; i++) {
      final match = matches[i];
      final titleWithColon = match.group(0)!;
      final title = titleWithColon.replaceAll(':', '').trim();

      String content;
      if (i + 1 < matches.length) {
        content = feedback.substring(match.end, matches[i + 1].start).trim();
      } else {
        content = feedback.substring(match.end).trim();
      }
      sections[title] = content;
    }
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final score = _extractScore(feedback);
    final feedbackSections = _parseFeedback(feedback);

    final iconMap = {
      'Overall Assessment': Icons.assessment,
      'Soft Skills & Interpersonal Competencies': Icons.diversity_3_outlined,
      'Key Strengths': Icons.check_circle,
      'Key Weaknesses': Icons.warning_amber_rounded,
      'Recommended Skill Improvements': Icons.lightbulb_outline,
      'Next Steps to Improve Performance': Icons.next_plan_outlined,
    };

    final overallAssessment = feedbackSections.remove('Overall Assessment') ?? 'No assessment provided.';
    final softSkillsContent = feedbackSections.remove('Soft Skills & Interpersonal Competencies') ?? 'No soft skills assessment provided.';
    feedbackSections.remove('Score');


    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ChatbotAppHeader(title: 'Interview Chatbot'),
                  const SizedBox(height: 24),
                  Text('Feedback for your $interviewLevel role interview',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppTheme.fontColor)),
                  const SizedBox(height: 24),

                  CustomCard(
                    title: 'Overall Assessment',
                    content: overallAssessment,
                    icon: iconMap['Overall Assessment']!,
                    isBulleted: false,
                  ),
                  const SizedBox(height: 20),

                  _buildScoreChart(context, score),
                  const SizedBox(height: 24),

                  if (softSkillsContent.isNotEmpty && softSkillsContent != 'No soft skills assessment provided.')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: CustomCard(
                        title: 'Soft Skills & Interpersonal Competencies',
                        content: softSkillsContent,
                        icon: iconMap['Soft Skills & Interpersonal Competencies']!,
                        isBulleted: false,
                      ),
                    ),

                  Column(
                    children: feedbackSections.entries.map((entry) {
                      final isBulletedSection = entry.key.contains('Strengths') ||
                          entry.key.contains('Weaknesses') ||
                          entry.key.contains('Improvements') ||
                          entry.key.contains('Next Steps');

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CustomCard(
                          title: entry.key,
                          content: entry.value,
                          icon: iconMap[entry.key] ?? Icons.info,
                          isBulleted: isBulletedSection,
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                      child: const Text('Done'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreChart(BuildContext context, double score) {
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: AppTheme.primaryColor,
                  value: score,
                  title: '',
                  radius: 80,
                ),
                PieChartSectionData(
                  color: AppTheme.primaryColor.withAlpha((0.2 * 255).round()),
                  value: 100 - score,
                  title: '',
                  radius: 80,
                ),
              ],
              sectionsSpace: 0,
              centerSpaceRadius: 60,
            ),
          ),
          Text(
            '${score.toInt()}%',
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: AppTheme.fontColor, fontSize: 36),
          ),
        ],
      ),
    );
  }
}

