import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';
import 'package:readysethire/utils/pdf_generator.dart';
import 'package:open_filex/open_filex.dart';
import 'pdf_viewer_screen.dart';

class ExportResumeScreen extends StatefulWidget {
  const ExportResumeScreen({super.key});

  @override
  State<ExportResumeScreen> createState() => _ExportResumeScreenState();
}

class _ExportResumeScreenState extends State<ExportResumeScreen> {
  bool _isGenerating = false;

  Future<void> _showPostSaveOptions(String filePath) async {
    if (!mounted) return;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: const Text('View in app'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PdfViewerScreen(filePath: filePath),
                  ));
                },
              ),
              ListTile(
                leading: const Icon(Icons.open_in_new),
                title: const Text('Open with external app'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await OpenFilex.open(filePath);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await generateAndShare(Provider.of<ResumeDataProvider>(context, listen: false).resumeData, filename: filePath.split('/').last);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Close'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveToDownloads() async {
    setState(() => _isGenerating = true);
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    try {
      final path = await generateAndSaveToDownloads(provider.resumeData,
          filename: 'readysethire_resume.pdf');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to: $path')),
      );
      // Show options to view/open/share
      await _showPostSaveOptions(path);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save PDF: $e')),
      );
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  Future<void> _sharePdf() async {
    setState(() => _isGenerating = true);
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    try {
      final path = await generateAndSaveToDownloads(provider.resumeData,
          filename: 'readysethire_resume.pdf');
      await generateAndShare(provider.resumeData, filename: path.split('/').last);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to share PDF: $e')),
      );
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  /// Save the PDF and immediately share it (single-tap export).
  Future<void> _exportPdf() async {
    setState(() => _isGenerating = true);
    final provider = Provider.of<ResumeDataProvider>(context, listen: false);
    try {
      // Save to downloads first so we have a file path to reference externally
      final path = await generateAndSaveToDownloads(provider.resumeData,
          filename: 'readysethire_resume.pdf');

      // Optionally show quick feedback
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exported to: $path — opening share sheet...')),
      );

      // Immediately share the generated file
      await generateAndShare(provider.resumeData, filename: path.split('/').last);

      // After sharing, present post-save options (view/open/share) like Save flow
      if (!mounted) return;
      await _showPostSaveOptions(path);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to export PDF: $e')),
      );
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0FC), // Light purple background
      appBar: AppBar(
        title: const Text('Export Resume'),
        backgroundColor: const Color(0xFFF8F0FC), // Match app bar background
        elevation: 0, // Remove shadow
        iconTheme: const IconThemeData(color: Colors.black), // Dark icon for contrast
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(color: Colors.black, fontSize: 20),
        ).titleLarge,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Export your filled resume to a PDF file',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5A2A7F), // Darker purple for text
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 220,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isGenerating ? null : _saveToDownloads,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6BCF0), // Light purple button
                    foregroundColor: const Color(0xFF5A2A7F), // Darker purple text
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0, // Remove shadow
                  ),
                  child: _isGenerating
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF5A2A7F), // Darker purple spinner
                    ),
                  )
                      : const Text('Save as PDF'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 220,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isGenerating ? null : _sharePdf,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6BCF0), // Light purple button
                    foregroundColor: const Color(0xFF5A2A7F), // Darker purple text
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0, // Remove shadow
                  ),
                  child: _isGenerating
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF5A2A7F), // Darker purple spinner
                    ),
                  )
                      : const Text('Share as PDF'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 220,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isGenerating ? null : _exportPdf,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A2A7F), // Primary purple button
                    foregroundColor: Colors.white, // White text
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0, // Remove shadow
                  ),
                  child: _isGenerating
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Text('Export (Save & Share)'),
                ),
              ),
              const SizedBox(height: 20),
              // Done button: navigates back to home (first route)
              SizedBox(
                width: 220,
                height: 60,
                child: ElevatedButton(
                  onPressed: _isGenerating
                      ? null
                      : () {
                          // Return to the app's home screen by popping until the first route
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFFFFF), // White background
                    foregroundColor: const Color(0xFF5A2A7F), // Purple text
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    elevation: 0,
                  ),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}