import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../placeholders/tools_screen.dart' show GameAppHeader;
import 'guide_data_models.dart';
import 'package:permission_handler/permission_handler.dart';

// --- Data Source ---
final Guide resumeChecklistGuide = Guide(
  title: 'Resume Checklist',
  subtitle: '',
  icon: Icons.check_circle_outline,
  content: [
    GuideContent(
      title: 'Resume Checklist Introduction',
      text:
      "Use this checklist to help you review your resume before you give it to an employer.\n\nIt can be hard to find mistakes in documents you have written. If you can, give your resume and this checklist to a friend or family member so they can check it for you.",
    ),
    GuideContent(
      title: 'Does your resume look professional:',
      text:
      "Is your name, phone number and email address clearly written on each page?\n\nDoes your resume use an easy-to-read font (e.g. Arial 11pt) and have a simple, professional layout?\n\nDoes your resume have headings that clearly communicate each section? For example, ‘Education’, ‘Work experience’, ‘Personal profile’..?",
    ),
    GuideContent(
      title: 'Is your resume tailored to the specific job and employer:',
      text:
      "Could the employer understand your key skills and experience after reading your resume for 5-10 seconds?\n\nIs your resume written with the particular job and employer in mind? In other words, is it tailored to this job? Does it include the employer’s key words?\n\nHave you been honest about your skills, work history and accomplishments?",
    ),
    GuideContent(
      title: 'Has it been checked for errors:',
      text:
      "Have you checked the spelling of every word?\n\nHave you checked your grammar and punctuation?\n\nHas a family member or friend reviewed your final resume?",
    ),
  ],
);

// --- Main Optimizer Screen ---
class ResumeOptimizerScreen extends StatelessWidget {
  const ResumeOptimizerScreen({super.key});

  Future<void> _requestStoragePermission() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      throw 'Storage permission denied';
    }
  }

  Future<void> _downloadAndOpenPDF(BuildContext context) async {
    try {
      // 1. Ask for storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
        return;
      }

      // 2. Load PDF from assets
      final byteData = await rootBundle.load('assets/ResumeTemplate.pdf');
      final Uint8List bytes = byteData.buffer.asUint8List();

      // 3. Get Downloads directory (Android & iOS compatible)
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      // 4. Write the file
      final filePath = '${downloadsDir.path}/ResumeTemplate.pdf';
      final file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);

      // 5. Notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Template saved to Downloads folder!')),
      );

      // 6. Open in viewer
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PDFViewerScreen(filePath: filePath),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save template: $e')),
      );
    }
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
                const Spacer(),
                const Icon(Icons.person_search,
                    size: 100, color: Color(0xFF491D7F)),
                const SizedBox(height: 20),
                Text('Resume Optimizer & Tips',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.b612Mono(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF491D7F))),
                const SizedBox(height: 40),

                // Resume Checklist Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResumeChecklistScreen(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF491D7F),
                    side:
                    const BorderSide(color: Color(0xFFC46BAD), width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    backgroundColor: const Color(0xFFC46BAD).withOpacity(0.1),
                  ),
                  child: const Text('Resume Checklist',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),

                // Open PDF Button
                OutlinedButton(
                  onPressed: () => _downloadAndOpenPDF(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF491D7F),
                    side:
                    const BorderSide(color: Color(0xFFC46BAD), width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    backgroundColor: const Color(0xFFC46BAD).withOpacity(0.1),
                  ),
                  child: const Text('Open Resume Template',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- PDF Viewer Screen ---
class PDFViewerScreen extends StatelessWidget {
  final String filePath;
  const PDFViewerScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Template'),
        backgroundColor: const Color(0xFF491D7F),
      ),
      body: SfPdfViewer.file(
        File(filePath),
      ),
    );
  }
}

// --- Checklist Screen ---
class ResumeChecklistScreen extends StatelessWidget {
  const ResumeChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guide = resumeChecklistGuide;
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 24),
                  Text(
                    guide.content[0].text, // Introduction text
                    style: GoogleFonts.b612Mono(
                        color: const Color(0xFF491D7F), fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  ...guide.content.sublist(1).map((content) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          content.title,
                          style: GoogleFonts.b612Mono(
                              color: const Color(0xFF491D7F),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...content.text.split('\n\n').map((item) {
                          return ChecklistItem(text: item);
                        }),
                        const SizedBox(height: 24),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Checklist Item Widget ---
class ChecklistItem extends StatefulWidget {
  final String text;
  const ChecklistItem({super.key, required this.text});

  @override
  State<ChecklistItem> createState() => _ChecklistItemState();
}

class _ChecklistItemState extends State<ChecklistItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
            activeColor: const Color(0xFFC46BAD),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                widget.text,
                style: GoogleFonts.b612Mono(
                    color: const Color(0xFF491D7F), fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
