import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:async'; // Import for Future.delayed
import 'dart:math'; // Import for Random and pow
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:provider/provider.dart';
import '../../models/resume_data.dart';

import '../../models/test_result_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/logo_widget.dart';
import 'history_services.dart';




// =================================================================
// Gemini AI Service - REVISED WITH TRUE EXPONENTIAL BACKOFF
// =================================================================
class GeminiAIService {
  // IMPORTANT: For production apps, use environment variables or a secure secret management solution.
  // These keys are exposed for demonstration purposes only and should be secured.
  static const List<String> _apiKeys = [
    'AIzaSyAT93raKQyVgQS0atUpwKUi4T9n4GDJmbU', // Primary API Key
    'AIzaSyCBOZB_m5BO-Zt-A6L-fcpfLxBXSFlE1rw', // Secondary/Fallback API Key
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

class GameAppHeader extends StatelessWidget {
  const GameAppHeader({super.key});

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
      ],
    );
  }
}

// =================================================================
// Application Screens
// =================================================================

class MockInterviewIntroScreen extends StatelessWidget {
  const MockInterviewIntroScreen({super.key});

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
                  const GameAppHeader(),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withAlpha((0.2 * 255).round()),
                    ),
                    child: const Icon(Icons.mic,
                        size: 80, color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 20),
                  Text('Mock Interview',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontSize: 24)),
                  const SizedBox(height: 16),
                  Text(
                    'Practice your communication skills through an AI-powered mock interview that simulates a real HR session. Choose your preferred interview level—operations, supervision, or management—answer dynamic questions, and receive a score based on how clearly, confidently, and appropriately you respond, just like in an actual interview.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const MockInterviewLevelScreen()),
                      );
                    },
                    child: const Text('Start'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MockInterviewLevelScreen extends StatelessWidget {
  const MockInterviewLevelScreen({super.key});

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
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withAlpha((0.2 * 255).round()),
                    ),
                    child: const Icon(Icons.mic,
                        size: 80, color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 20),
                  Text('Select interview level:',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 24),
                  _buildLevelButton(
                    context,
                    'Management Level',
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const MockInterviewLevelDetailScreen(
                          level: 'Management',
                          description:
                          'At this stage, you are expected to demonstrate strategic thinking, organizational leadership, clear communication with stakeholders, and sound ethical judgment. \n\nTake your time to explain your insights thoroughly and connect your experiences to how you can contribute to high-level goals and departmental success. \n\nLet’s get started and see how you can lead from the top.',
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
                        builder: (context) =>
                        const MockInterviewLevelDetailScreen(
                          level: 'Supervisory',
                          description:
                          'In this level, you will face questions designed to assess your leadership, conflict resolution, time management, and decision-making skills. \n\nTake a deep breath, answer confidently, and support your responses with real experiences whenever possible. Good luck and show your best self!',
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
                        builder: (context) =>
                        const MockInterviewLevelDetailScreen(
                          level: 'Operations',
                          description:
                          'This level is designed for entry-level staff roles and focuses on assessing your communication skills, basic teamwork abilities, adaptability, and problem-solving mindset. \n\nGet ready to answer practical questions and demonstrate how well you handle tasks and collaborate within a team. Good luck and show your best self!',
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

class MockInterviewLevelDetailScreen extends StatelessWidget {
  final String level;
  final String description;

  const MockInterviewLevelDetailScreen(
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
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.primaryColor.withAlpha((0.2 * 255).round()),
                    ),
                    child: const Icon(Icons.mic,
                        size: 80, color: AppTheme.fontColor),
                  ),
                  const SizedBox(height: 20),
                  Text('$level Level',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontSize: 24)),
                  const SizedBox(height: 16),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MockInterviewScreen(interviewLevel: level),
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

// =================================================================
// Core Interview Logic Screen
// =================================================================
class MockInterviewScreen extends StatefulWidget {
  final String interviewLevel;
  const MockInterviewScreen({super.key, required this.interviewLevel});

  @override
  State<MockInterviewScreen> createState() => _MockInterviewScreenState();
}

class _MockInterviewScreenState extends State<MockInterviewScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isListening = false;
  String _userAnswer = 'Press the button and start speaking';
  String _aiResponse = "Initializing interview...";
  bool _isProcessing = false;
  final List<Map<String, String>> _conversationHistory = [];
  bool _speechAvailable = false;

  // Track how many interviewer questions have been asked so we can raise difficulty progressively
  int _questionCount = 0;

  // Helper: extract candidate first name (for greeting) from resume
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

  // Helper: produce a concise candidate profile string from saved resume data.
  String _candidateProfile() {
    try {
      final resume = Provider.of<ResumeDataProvider>(context, listen: false).resumeData;
      final buffer = StringBuffer();

      if ((resume.fullName.trim()).isNotEmpty) {
        buffer.writeln('Name: ${resume.fullName.trim()}');
      }
      if ((resume.emailAddress.trim()).isNotEmpty) {
        buffer.writeln('Email: ${resume.emailAddress.trim()}');
      }
      if ((resume.contactNumber.trim()).isNotEmpty) {
        buffer.writeln('Contact: ${resume.contactNumber.trim()}');
      }
      if ((resume.professionalSummary.trim()).isNotEmpty) {
        buffer.writeln('Summary: ${resume.professionalSummary.trim()}');
      }

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
      if (skills.isNotEmpty) {
        buffer.writeln('Skills: ${skills.join(', ')}');
      }

      final result = buffer.toString().trim();
      return result.isEmpty ? 'No candidate profile available.' : result;
    } catch (e) {
      debugPrint('Failed to read resume data: $e');
      return 'No candidate profile available.';
    }
  }

  // Compute difficulty label based on _questionCount
  String _difficultyLabel() {
    if (_questionCount < 2) return 'EASY';
    if (_questionCount < 5) return 'MEDIUM';
    return 'HARD';
  }

  @override
  void initState() {
    super.initState();
    _initializeInterview();
  }

  Future<void> _initializeInterview() async {
    _speechAvailable = await _speech.initialize(
        onStatus: _statusListener,
        onError: (error) =>
            debugPrint('Speech recognition error: $error'));

    if (mounted) {
      setState(() {
        _aiResponse = "Getting the first question...";
      });
      // Directly ask the first question for a more natural start.
      await _askNextQuestion();
    }
  }

  Future<void> _askNextQuestion() async {
    if (!mounted) return;
    setState(() {
      _isProcessing = true;
    });

    final prompt = _buildNewQuestionPrompt();
    final nextQuestion = await GeminiAIService.generateContent(prompt);

    if (!mounted) return;
    // Sanitize AI output to extract one concise question
    String raw = nextQuestion.trim();
    // Remove common labels the model might emit
    raw = raw.replaceFirst(RegExp(r'^(Interviewer:|INTERVIEWER:|Q:|Question:|Interviewer\s*-)', caseSensitive: false), '').trim();

    // Choose the first non-empty line
    final lines = raw.split('\n').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    String candidateLine = lines.isNotEmpty ? lines[0] : raw;

    // If the chosen line contains multiple sentences, try to extract the first sentence ending with '?'
    final sentenceMatch = RegExp(r'[^?!.]*\?').firstMatch(candidateLine);
    if (sentenceMatch != null) {
      candidateLine = sentenceMatch.group(0)!.trim();
    } else {
      // Fallback: try to find a sentence ending in the whole raw text
      final sentenceMatch2 = RegExp(r'[^?!.]*\?').firstMatch(raw);
      if (sentenceMatch2 != null) {
        candidateLine = sentenceMatch2.group(0)!.trim();
      }
    }

    // Ensure the result ends with a question mark
    candidateLine = candidateLine.trim();
    if (!candidateLine.endsWith('?')) {
      // If it doesn't end with a question mark but looks like a question, add one.
      if (candidateLine.length > 0) candidateLine = candidateLine.replaceAll(RegExp(r'[.]+\s*\$'), '');
      candidateLine = candidateLine + (candidateLine.endsWith('?') ? '' : '?');
    }

    // Cap the length to keep the UI concise
    if (candidateLine.length > 300) {
      candidateLine = candidateLine.substring(0, 297).trim() + '...';
    }

    // Ensure the first question includes a greeting by name (app-managed) to guarantee personalization
    final firstName = _candidateFirstName();
    String questionText = candidateLine;

    if (_questionCount == 0 && firstName.isNotEmpty) {
      final lower = questionText.toLowerCase();
      if (!(lower.startsWith('hi') || lower.startsWith('hello') || lower.startsWith('dear') || questionText.startsWith('Hi ') || questionText.startsWith('Hello '))) {
        questionText = 'Hi $firstName, ' + questionText[0].toUpperCase() + questionText.substring(1);
      } else {
        if (!questionText.contains(firstName)) {
          questionText = questionText.replaceFirst(RegExp(r'^(hi|hello)\b', caseSensitive: false), 'Hi $firstName');
        }
      }
    }

    // Add interviewer question to history and increment question counter
    _conversationHistory.add({'interviewer': questionText});
    _questionCount++;
    setState(() {
      _aiResponse = questionText;
      _isProcessing = false;
    });
    await _speak(questionText);
  }

  String _buildNewQuestionPrompt() {
    final transcript = _conversationHistory
        .map((turn) {
      final role = turn.keys.first == 'candidate' ? 'CANDIDATE' : 'INTERVIEWER';
      return "$role: ${turn.values.first}";
    })
        .join('\n');

    final profile = _candidateProfile();
    final difficulty = _difficultyLabel();

    return '''
    **SYSTEM INSTRUCTION:**
    You are an expert HR manager conducting a realistic mock job interview. Your goal is to behave like an interviewer: ask focused, progressively more challenging questions, and probe follow-ups based on both the candidate's resume/profile and their earlier answers.

    **CANDIDATE PROFILE:**
    $profile

    **ROLE LEVEL:**
    ${widget.interviewLevel}

    **INTERVIEW STYLE & DIFFICULTY:**
    - Interview difficulty level: $difficulty. Start easy and progressively increase difficulty as more questions are asked.
    - Base your questions on the candidate's profile and the conversation history. Where possible, reference specific roles, projects, institutions, skills, or achievements listed in the profile to make questions feel tailored.
    - Do NOT include any greeting ("Hi", "Hello", or similar) or salutations in your output. The app will handle producing a short greeting with the candidate's first name on the first question.
    - For subsequent questions, do NOT repeat the greeting.

    **CONVERSATION HISTORY:**
    $transcript

    **YOUR TASK:**
    Based on the candidate profile, the interview difficulty level, and the full conversation history, generate the very next single question you will ask the candidate.
    - Do NOT include any extra greeting. Output ONLY the single interviewer question.
    - Keep each output concise and output only the single question. Do not include additional commentary, scoring, or feedback.
    ''';
  }

  void _statusListener(String status) {
    if (status == 'notListening' && _isListening) {
      _stopListening();
    }
  }

  void _startListening() {
    if (!_speechAvailable || _isListening) return;

    setState(() {
      _userAnswer = 'Listening...';
      _isListening = true;
    });

    _speech.listen(onResult: (val) {
      if (val.recognizedWords.isNotEmpty && mounted) {
        setState(() {
          _userAnswer = val.recognizedWords;
        });
      }
    });
  }

  void _stopListening() async {
    if (!_isListening) return;

    await _speech.stop();
    setState(() {
      _isListening = false;
    });

    if (_userAnswer.isNotEmpty &&
        _userAnswer != 'Listening...' &&
        _userAnswer != 'Press the button and start speaking') {
      setState(() {
        _isProcessing = true;
      });
      _conversationHistory.add({'candidate': _userAnswer});
      await _askNextQuestion();
    } else {
      setState(() {
        _userAnswer = 'Press the button and start speaking';
      });
    }
  }

  Future<void> _speak(String text) async {
    await _flutterTts.stop();
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(text);
  }

  void _endInterview() async {
    if (_isProcessing) return;

    final bool hasCandidateAnswers =
    _conversationHistory.any((turn) => turn.containsKey('candidate'));

    if (!hasCandidateAnswers) {
      const feedback = '''
      Score: 0/100

      Overall Assessment:
      The interview was not completed as no answers were provided. Please try again and respond to the questions to receive a full assessment.

      Communication Skills: N/A
      Soft Skills & Interpersonal Competencies : N/A
      Key Strengths: * N/A
      Key Weaknesses: * N/A
      Recommended Skill Improvements: * N/A
      Next Steps to Improve Performance: * Please participate in the interview by providing answers to the questions to receive feedback.
      ''';

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MockInterviewResultsScreen(
            feedback: feedback,
            interviewLevel: widget.interviewLevel,
          ),
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _aiResponse = 'Thank you for your time. Generating your feedback now...';
    });
    await _speak(_aiResponse);

    final prompt = _buildFeedbackPrompt();
    final feedback = await GeminiAIService.generateContent(prompt);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MockInterviewResultsScreen(
          feedback: feedback,
          interviewLevel: widget.interviewLevel,
        ),
      ),
    );
  }

  String _buildFeedbackPrompt() {
    final transcript = _conversationHistory
        .map((turn) => "${turn.keys.first.toUpperCase()}: ${turn.values.first}")
        .join('\n');

    final profile = _candidateProfile();
    return '''
    **SYSTEM INSTRUCTION:**
    You are a highly analytical and objective expert career coach. Your task is to provide a detailed, evidence-based feedback report on a mock interview transcript. Your analysis MUST be based *exclusively* on the provided transcript and the candidate profile. Do not invent information or make assumptions about the candidate beyond what is present.

    **CANDIDATE PROFILE:**
    $profile

    **INTERVIEW DETAILS:**
    - Role Level: ${widget.interviewLevel}

    **INTERVIEW TRANSCRIPT:**
    $transcript

    **YOUR TASK:**
    Generate a feedback report using the following strict format. You must provide concrete, actionable feedback and reference specific examples from the transcript to support your evaluation in each section. Start each section on a new line.

    Score: [Provide a score from 0 to 100 based on the overall performance in the transcript]/100

    Overall Assessment:
    [Provide a concise, 2-3 sentence summary of the candidate's performance as a paragraph. This should be a high-level overview reflecting the score and key takeaways from the analysis.]

    Soft Skills & Interpersonal Competencies:
    [In a single paragraph, evaluate the candidate's soft skills. Start by assessing their Communication Skills (clarity, confidence, articulation, and directness). Then, critically assess other demonstrated soft skills relevant to a ${widget.interviewLevel} position. Cite specific phrases or examples from the transcript to support your entire assessment.]

    Key Strengths:
    [Identify and list 2-3 distinct strengths. Start each strength on a new line with a '*' bullet point. For each strength, provide a direct quote or a specific example from the transcript that demonstrates this quality.]

    Key Weaknesses:
    [Identify and list 2-3 specific areas for improvement. Start each weakness on a new line with a '*' bullet point. For each weakness, provide a direct quote or a specific example from the transcript that highlights the issue.]

    Recommended Skill Improvements:
    [Based on the identified weaknesses, suggest concrete skills to develop. Start each recommendation on a new line with a '*' bullet point. Be specific. Instead of "improve communication," suggest "Practice structuring answers using the STAR method to improve clarity and impact."]

    Next Steps to Improve Performance:
    [Provide a short, actionable list of 2-3 next steps the candidate can take. Start each step on a new line with a '*' bullet point. These steps should directly address the weaknesses and skill gaps identified in your feedback.]
    ''';
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
                const GameAppHeader(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    icon: const Icon(Icons.exit_to_app),
                    label: const Text('End Interview'),
                    onPressed: _endInterview,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          "AI Interviewer:",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        if (_isProcessing)
                          const CircularProgressIndicator()
                        else
                          Text(_aiResponse, textAlign: TextAlign.center),
                        const SizedBox(height: 40),
                        Text(
                          _isListening ? "Listening..." : "Your Answer:",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(_userAnswer, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: FloatingActionButton(
                    onPressed: _isListening ? _stopListening : _startListening,
                    backgroundColor: AppTheme.primaryColor,
                    child: Icon(_isListening ? Icons.mic_off : Icons.mic),
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

// =================================================================
// Results & Feedback Screen
// =================================================================
class MockInterviewResultsScreen extends StatefulWidget {
  final String feedback;
  final String interviewLevel;

  const MockInterviewResultsScreen(
      {super.key, required this.feedback, required this.interviewLevel});

  @override
  State<MockInterviewResultsScreen> createState() =>
      _MockInterviewResultsScreenState();
}

class _MockInterviewResultsScreenState extends State<MockInterviewResultsScreen> {
  late final double _score;

  @override
  void initState() {
    super.initState();
    _score = _extractScore(widget.feedback);
    _saveResult();
  }

  void _saveResult() async {
    final result = TestResult(
      type: 'Mock Interview',
      name: widget.interviewLevel,
      score: _score,
      // --- FIX: Added rawScore and totalQuestions for data consistency ---
      rawScore: _score.toInt(),
      totalQuestions: 100,
      date: DateTime.now(),
      feedback: widget.feedback,
    );
    await HistoryService.saveResult(result);
  }

  double _extractScore(String feedback) {
    try {
      // --- FIX: Made the regex more specific to match "Score: 85/100" format ---
      final scoreRegex = RegExp(r'Score: (\d+(\.\d+)?)/100');
      final match = scoreRegex.firstMatch(feedback);
      if (match != null && match.group(1) != null) {
        return double.parse(match.group(1)!);
      }
    } catch (e) {
      debugPrint("Error extracting score: $e");
      return 0.0;
    }
    return 0.0;
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GameAppHeader(),
                  const SizedBox(height: 30),
                  Text('Applied Role: ${widget.interviewLevel}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('Interview Type: Voice Mock Interview',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 30),
                  _buildScoreChart(context, _score),
                  const SizedBox(height: 30),
                  ..._buildFeedbackCards(context),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                      child: const Text('Done'),
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
              centerSpaceRadius: 70,
            ),
          ),
          Text(
            '${score.toInt()}%',
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(color: AppTheme.fontColor, fontSize: 36),
          ),
        ],
      ),
    );
  }

  // REPLACE this method in class _MockInterviewResultsScreenState
  List<Widget> _buildFeedbackCards(BuildContext context) {
    // This regular expression now specifically looks for the "Score: ... /100" line to remove it.
    final cleanFeedback =
    widget.feedback.replaceAll(RegExp(r'Score:.*\d/\d{2,3}\n\n'), '');
    final sections = cleanFeedback.split(RegExp(r'\n\n(?=[A-Z])'));

    // The 'Communication Skills' entry has been removed from this map.
    final iconMap = {
      'Overall Assessment': Icons.assessment,
      'Soft Skills & Interpersonal Competencies': Icons.people_outline,
      'Key Strengths': Icons.check_circle_outline,
      'Key Weaknesses': Icons.warning_amber_rounded,
      'Recommended Skill Improvements': Icons.trending_up,
      'Next Steps to Improve Performance': Icons.next_plan_outlined,
    };

    return sections.map((section) {
      final parts = section.split(':');
      if (parts.length < 2) return const SizedBox.shrink();

      final title = parts[0].trim();
      final content = parts.sublist(1).join(':').trim();

      return Card(
        elevation: 4.0,
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(iconMap[title] ?? Icons.info_outline,
                      color: AppTheme.fontColor),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Use a helper to build content, which now supports bullet points
              ..._buildContentWidgets(context, content),
            ],
          ),
        ),
      );
    }).toList();
  }


  List<Widget> _buildContentWidgets(BuildContext context, String content) {
    final lines = content.split('\n').where((line) => line.trim().isNotEmpty).toList();

    return lines.map<Widget>((line) {
      if (line.trim().startsWith('*')) {
        // It's a bullet point
        final text = line.trim().substring(1).trim();
        return Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "• ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        );
      } else {
        // It's a regular paragraph line
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            line,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }
    }).toList();
  }
}
