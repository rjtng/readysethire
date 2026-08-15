import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../placeholders/tools_screen.dart' show GameAppHeader; // For common widgets

// --- Data Models ---
// Added here to resolve import issues
class GuideContent {
  final String title;
  final String text;

  GuideContent({required this.title, required this.text});
}

class Guide {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<GuideContent> content;

  Guide(
      {required this.title,
        required this.subtitle,
        required this.icon,
        required this.content});
}


// --- Data Source ---
final Guide JobInterviewTips = Guide(
  title: 'Job Interview Tips',
  subtitle:
  'Master your next job interview with tips that turn opportunities into offers',
  icon: Icons.lightbulb_outline,
  content: [
    GuideContent(
      title: 'Research the company and interviewers',
      text:
      'Understanding key information about the company you’re interviewing with can help you go into your interview with confidence. The company’s website, social media posts and recent press releases will provide a solid understanding of the company’s goals and culture and how your background makes you a great fit.',
    ),
    GuideContent(
      title: 'Practice your answers',
      text:
      'Prepare your answer to the common question: “Tell me about yourself, and why are you interested in this role with our company?” The idea is to quickly communicate who you are and what value you\'ll bring to the company and the role—this is your elevator pitch.',
    ),
    GuideContent(
      title: 'Reread the job description',
      text:
      'You may want to print it out and begin underlining specific skills the employer desires. Think about examples from your past and current work that align with these requirements.',
    ),
    GuideContent(
      title: 'Use the STAR method',
      text:
      'Prepare to be asked about times in the past when you used a specific skill so you can answer with a story using the STAR method—situation, task, action and result. The STAR method is a structured way to answer behavioral or competency-based interview questions.',
    ),
    GuideContent(
      title: 'Practice with someone',
      text:
      'Practicing your answers out loud is an incredibly effective way to prepare. Say them to yourself or ask a friend to ask you common questions and rate your answers. You’ll find yourself gaining confidence as you repeat the words.',
    ),
    GuideContent(
      title: 'Prepare a list of references',
      text:
      'Your interviewers may ask you to provide a list of professional references either before or after your interview. Having a prepared reference list ready can save you time and help you respond promptly to this request. This list typically includes the names, contact information, and relationships of people who can vouch for your skills, experience, and work ethic. By preparing your references in advance, you demonstrate professionalism and readiness, which can positively influence the hiring process and help you move smoothly to the next stage.',
    ),
    GuideContent(
      title: 'Be prepared with examples of your work',
      text:
      'The interviewer will probably ask you about relevant work you’ve done in the past. After reviewing the job description, think of previous jobs or volunteer positions that show you have experience and success doing the type of work they require. One of the best ways to make a good impression during an interview is to illustrate that you can meet the requirements of the job with examples from your past experience.',
    ),
    GuideContent(
      title: 'Prepare smart questions for your interviewers',
      text:
      'Interviews are a two-way street. Employers expect you to ask questions: They want to know that you’re thinking seriously about what it would be like to work there. Here are some questions you may want to consider asking your interviewers:\n\nCan you explain some of the day-to-day responsibilities of this job?\n\nHow would you describe the characteristics of someone who would succeed in this role?\n\nIf I were in this position, how would my performance be measured? How often?\n\nWhat departments does this team work with regularly?\n\nHow do these departments typically collaborate?\n\nWhat does that process look like?\n\nWhat are the challenges someone in this role might experience?',
    ),
    GuideContent(
      title: 'Plan your interview attire the night before',
      text:
      'If you speak to a recruiter before the interview, ask them about the dress code in the workplace and choose your outfit accordingly. If you don’t have someone to ask, research the company to learn what’s appropriate.',
    ),
    GuideContent(
      title: 'Bring resume copies, a notebook and a pen',
      text:
      'Take at least five copies of your printed resume on clean paper in case of multiple interviewers. Highlight specific accomplishments on your copy that you can easily refer to and discuss. Bring a pen and a small notebook to take notes. Don\'t take notes on your smartphone or another electronic device. Write down details you can reference later in your follow-up thank-you notes.',
    ),
    GuideContent(
      title: 'Arrive early',
      text:
      'Plan to arrive 10 to 15 minutes before the scheduled interview time. Map out your route to the interview location so you can arrive on time. Consider doing a practice run before your interview day. If you’re taking public transportation, identify a backup plan in case there are delays or closures.\n\nTip: When you arrive early, use the extra minutes to observe the workplace dynamics.',
    ),
    GuideContent(
      title: 'Make a great first impression',
      text:
      'Remember the little things—shine your shoes, brush or style your hair and make sure your nails are clean and tidy. Check your clothes for holes, stains, pet hair and loose threads. And remember to smile.',
    ),
    GuideContent(
      title: 'Treat everyone with respect',
      text:
      'Be respectful of everyone you encounter, including those on the road and in the parking lot, security personnel and front desk staff. Treat everyone you don’t know as though they’re the hiring manager. Even if they aren’t, your potential employer might ask for their feedback.',
    ),
    GuideContent(
      title: 'Win them over',
      text:
      'Being genuine during interview conversations can help employers easily relate to you. Showing positivity with a smile and an upbeat attitude can help keep the interview light and constructive.',
    ),
    GuideContent(
      title: 'Respond truthfully',
      text:
      'While it can seem tempting to embellish your skills and accomplishments, honesty is the best policy. Focus on your key strengths and why your background makes you uniquely qualified for the position. Being able to identify something you struggle with and how you work day-to-day to rectify it shows maturity and self-awareness. That might sound something like this:',
    ),
    GuideContent(
      title: 'Tie answers to your skills and accomplishments',
      text:
      'With any interview question you answer, tie your background to the job by providing examples of solutions and results you’ve achieved in your career. Use every opportunity to address the requirements listed in the job description.',
    ),
    GuideContent(
      title: 'Keep your answers concise and focused',
      text:
      'Remember, your time with each interviewer is limited, so be mindful of rambling answers. Practicing your answers beforehand can help keep you focused. Concise answers also show off your communication skills.',
    ),
    GuideContent(
      title: 'Stay positive',
      text:
      'Don\'t speak negatively about previous employers. Companies want to hire problem solvers capable of overcoming tough situations. If you’re feeling discouraged about your current job, focus on what you’ve gained from the experience and what you want to do next.',
    ),
    GuideContent(
      title: 'Ask about next steps',
      text:
      'After your interview, it\'s appropriate to ask your interviewer, hiring manager or recruiter about what you should expect next. This will likely be a follow-up email with the results from your interview and additional requirements like an assignment, reference list or another interview.',
    ),
    GuideContent(
      title: 'Send a thank-you letter',
      text:
      'If your interview is in person, ask for the business card of each person you speak with so you can follow up individually with separate thank-you emails. If you interview in the morning, send your follow-up emails the same day. If you interview in the afternoon, the next morning is fine.\n\nNote: Make certain each email is distinct from the others, using the notes you took during the conversations.',
    ),
  ],
);

// --- UI Screen Entry ---
class JobInterviewTipsScreen extends StatelessWidget {
  const JobInterviewTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GuideDetailScreen(guide: JobInterviewTips);
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

