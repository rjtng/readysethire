import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart' as pdf;
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:readysethire/models/resume_data.dart';

/// Generates a PDF bytes from the provided [ResumeData], matching the pro template.
Future<Uint8List> generatePdfBytes(ResumeData data) async {
  final pdfDoc = pw.Document();

  // Define reusable text styles
  final baseStyle =
  pw.TextStyle(font: pw.Font.helvetica(), fontSize: 10, color: pdf.PdfColors.black);
  final boldStyle = baseStyle.copyWith(fontWeight: pw.FontWeight.bold);
  final italicStyle = baseStyle.copyWith(fontStyle: pw.FontStyle.italic);
  final sectionTitleStyle =
  baseStyle.copyWith(fontSize: 13, fontWeight: pw.FontWeight.bold);
  final nameStyle = baseStyle.copyWith(fontSize: 24, fontWeight: pw.FontWeight.bold);
  final contactStyle = baseStyle.copyWith(fontSize: 9, color: pdf.PdfColors.grey700);
  final jobTitleStyle = baseStyle.copyWith(fontSize: 11, fontWeight: pw.FontWeight.bold);

  pdfDoc.addPage(
    pw.MultiPage(
      pageFormat: pdf.PdfPageFormat.a4,
      margin: const pw.EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      build: (context) => [
        // 1. Header (Name & Contact)
        pw.Center(child: _buildHeader(data, nameStyle, contactStyle)),
        pw.SizedBox(height: 20),

        // 2. Professional Summary
        _buildSection(
          'PROFESSIONAL SUMMARY',
          sectionTitleStyle,
          pw.Text(
            data.professionalSummary.isNotEmpty ? data.professionalSummary : '-',
            style: baseStyle,
            textAlign: pw.TextAlign.justify,
          ),
        ),
        pw.SizedBox(height: 16),

        // 3. Experience
        _buildSection(
          'EXPERIENCE',
          sectionTitleStyle,
          _buildExperienceList(data, jobTitleStyle, italicStyle, baseStyle, boldStyle),
        ),
        pw.SizedBox(height: 16),

        // 4. Education
        _buildSection(
          'EDUCATION',
          sectionTitleStyle,
          _buildEducationList(data, jobTitleStyle, baseStyle, boldStyle),
        ),
        pw.SizedBox(height: 16),

        // 5. Skills
        _buildSection(
          'SKILLS',
          sectionTitleStyle,
          _buildSkillsList(data, baseStyle),
        ),
      ],
    ),
  );

  return pdfDoc.save();
}

/// Helper to build the top header
pw.Widget _buildHeader(
    ResumeData data, pw.TextStyle nameStyle, pw.TextStyle contactStyle) {
  final contactParts = <String>[];
  if (data.address.isNotEmpty) contactParts.add(data.address);
  if (data.emailAddress.isNotEmpty) contactParts.add(data.emailAddress);
  if (data.contactNumber.isNotEmpty) contactParts.add(data.contactNumber);
  // Add website or other links if they exist in your ResumeData model
  // if (data.website.isNotEmpty) contactParts.add(data.website);

  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Text(
        data.fullName,
        style: nameStyle,
        textAlign: pw.TextAlign.center, // Added explicit center align
      ),
      pw.SizedBox(height: 5),
      pw.Text(
        contactParts.join('  |  '), // Separator as seen in template
        style: contactStyle,
        textAlign: pw.TextAlign.center,
      ),
    ],
  );
}

/// Helper to build a section with a title and divider
pw.Widget _buildSection(
    String title, pw.TextStyle titleStyle, pw.Widget child) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(title, style: titleStyle),
      pw.Container(
        height: 2,
        width: double.infinity,
        margin: const pw.EdgeInsets.only(top: 3, bottom: 8),
        color: pdf.PdfColors.black,
      ),
      child,
    ],
  );
}

/// Helper to build the list of experience entries
pw.Widget _buildExperienceList(ResumeData data, pw.TextStyle jobTitleStyle,
    pw.TextStyle italicStyle, pw.TextStyle baseStyle, pw.TextStyle boldStyle) {
  if (data.experienceEntries.isEmpty) {
    return pw.Text('-', style: baseStyle);
  }
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: data.experienceEntries.map((e) {
      final years = (e.startYear ?? '').isEmpty && (e.endYear ?? '').isEmpty
          ? ''
          : '${e.startYear ?? ''} - ${e.isPresent ? 'Present' : (e.endYear ?? '')}';

      // Split description into bullet points
      final descriptionLines = (e.description ?? '')
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();

      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Row for: Job Title (left) and Date (right)
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(e.jobTitle ?? '-', style: jobTitleStyle),
                pw.Spacer(),
                pw.Text(years, style: boldStyle), // Template date is bold
              ],
            ),
            // Company Name (italic)
            pw.Text(e.company ?? '-', style: italicStyle),
            pw.SizedBox(height: 4),
            // Bulleted Description
            if (descriptionLines.isNotEmpty)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: descriptionLines.map((line) {
                  return pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('· ',
                          style: baseStyle.copyWith(
                              fontWeight: pw.FontWeight.bold)),
                      pw.Expanded(
                        child: pw.Text(line, style: baseStyle),
                      ),
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      );
    }).toList(),
  );
}

/// Helper to build the list of education entries
pw.Widget _buildEducationList(ResumeData data, pw.TextStyle degreeStyle,
    pw.TextStyle baseStyle, pw.TextStyle boldStyle) {
  if (data.academicEntries.isEmpty) {
    return pw.Text('-', style: baseStyle);
  }
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: data.academicEntries.map((e) {
      final years = (e.yearStarted ?? '').isEmpty && (e.yearEnded ?? '').isEmpty
          ? ''
          : '${e.yearStarted ?? ''} - ${e.isPresent ? 'Present' : (e.yearEnded ?? '')}';

      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 10),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Row for: Degree (left) and Date (right)
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(e.degree ?? '-', style: degreeStyle),
                pw.Spacer(),
                pw.Text(years, style: boldStyle), // Match experience date style
              ],
            ),
            // School
            pw.Text(e.schoolName ?? '-', style: baseStyle),
            // Note: The template shows bullet points for achievements,
            // but the ResumeData model (from original code) doesn't seem to have
            // a description/achievements field for academic entries.
          ],
        ),
      );
    }).toList(),
  );
}

/// Helper to build the skills list
pw.Widget _buildSkillsList(ResumeData data, pw.TextStyle baseStyle) {
  final skills = data.skills.entries
      .where((entry) => entry.value)
      .map<String>((e) => e.key)
      .toList();

  if (skills.isEmpty) {
    return pw.Text('-', style: baseStyle);
  }

  // Use a simple text flow, separated by a separator
  // The template just lists them.
  return pw.Text(
    skills.join('  |  '),
    style: baseStyle,
  );

  // --- Alternative: If you really want the wrap behavior ---
  // return pw.Wrap(
  //   spacing: 8,
  //   runSpacing: 6,
  //   children: skills.map((skill) => pw.Text(skill, style: baseStyle)).toList(),
  // );
}

// -------------------------------------------------------------------
// --- The functions below are unchanged as they were already correct ---
// -------------------------------------------------------------------

/// Save generated PDF bytes for [data] to a downloads-like directory and return the absolute file path.
Future<String> generateAndSaveToDownloads(ResumeData data, {required String filename}) async {
  final bytes = await generatePdfBytes(data);

  Directory dir;

  try {
    if (Platform.isAndroid) {
      // Try to get Android "Downloads" directory if possible
      final externalDirs = await getExternalStorageDirectories(type: StorageDirectory.downloads);
      if (externalDirs != null && externalDirs.isNotEmpty) {
        dir = externalDirs.first;
      } else {
        dir = await getApplicationDocumentsDirectory();
      }
    } else if (Platform.isIOS) {
      // iOS doesn't expose a shared Downloads folder, use app documents
      dir = await getApplicationDocumentsDirectory();
    } else {
      // Desktop (Windows/macOS/Linux) typically supports getDownloadsDirectory
      final downloads = await getDownloadsDirectory();
      dir = downloads ?? await getApplicationDocumentsDirectory();
    }
  } catch (_) {
    dir = await getApplicationDocumentsDirectory();
  }

  // Ensure directory exists
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }

  final file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);
  return file.path;
}

/// Generate the PDF and open the platform share sheet.
Future<void> generateAndShare(ResumeData data, {required String filename}) async {
  final bytes = await generatePdfBytes(data);

  // Write to a temp file and share that file (most share plugins support file paths)
  final tmpDir = await getTemporaryDirectory();
  final file = File('${tmpDir.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);

  // Use share_plus to share the generated file
  final xfile = XFile(file.path, mimeType: 'application/pdf'); // Added MIME type
  await Share.shareXFiles([xfile], text: 'My resume from ReadySetHire');
}

