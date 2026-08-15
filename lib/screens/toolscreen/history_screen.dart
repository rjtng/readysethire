import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
// Assuming your project structure for these imports
import 'package:readysethire/models/test_result_model.dart';
import 'package:readysethire/screens/toolscreen/aptitude_game/aptitude_results_screen.dart';
import 'package:readysethire/theme/app_theme.dart';
import 'package:readysethire/widgets/gradient_background.dart';
import 'history_services.dart';
import 'interview_chatbot.dart';
import 'mock_interview.dart' show MockInterviewResultsScreen;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<TestResult>> _historyFuture;
  String _selectedFilter = 'Overall';
  static const List<String> _filters = [
    'Overall',
    'Mock Interview',
    'Chatbot Interview',
    'Aptitude Game',
  ];

  final PageController _pageController = PageController();
  StreamSubscription<TestResult>? _newResultSub;
  static const List<String> _aptitudeCategories = [
    'Communication',
    'Teamwork',
    'Problem-Solving',
    'Adaptability',
    'Emotional Intelligence',
  ];

  @override
  void initState() {
    super.initState();
    _historyFuture = HistoryService.getHistory();
    _newResultSub = HistoryService.onNewResult.listen((newResult) {
      if (mounted) {
        setState(() {
          _historyFuture = HistoryService.getHistory();
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _newResultSub?.cancel();
    super.dispose();
  }

  List<TestResult> _filterResults(List<TestResult> results) {
    if (_selectedFilter == 'Overall') return results;
    return results.where((r) => r.type == _selectedFilter).toList();
  }

  void _refreshHistory() {
    setState(() {
      _historyFuture = HistoryService.getHistory();
    });
  }

  Future<void> _deleteItem(TestResult result) async {
    await HistoryService.deleteHistoryItem(result);
    _refreshHistory();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('History item deleted.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _clearAllHistory() async {
    await HistoryService.clearAllHistory();
    _refreshHistory();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All history has been cleared.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showDeleteConfirmationDialog(TestResult result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this history item permanently?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteItem(result);
              },
            ),
          ],
        );
      },
    );
  }

  void _showClearAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All History?'),
          content: const Text('This action is irreversible and will delete all your progress history. Are you sure?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Clear All'),
              onPressed: () {
                Navigator.of(context).pop();
                _clearAllHistory();
              },
            ),
          ],
        );
      },
    );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppTheme.fontColor, size: 30),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Your Progress',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: FutureBuilder<List<TestResult>>(
                    future: _historyFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error loading history: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No history yet.\nComplete a test or interview to see your progress!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                        );
                      }

                      final allResults = snapshot.data!;
                      final results = _filterResults(allResults);

                      return RefreshIndicator(
                        onRefresh: () async => _refreshHistory(),
                        child: ListView(
                          children: [
                            // --- NEW FEATURE: Readiness Assessment Widget ---
                            _buildReadinessAssessment(allResults),
                            const SizedBox(height: 20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Filter:', style: TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(width: 8),
                                DropdownButton<String>(
                                  value: _selectedFilter,
                                  items: _filters.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
                                  onChanged: (val) {
                                    if (val == null) return;
                                    setState(() {
                                      _selectedFilter = val;
                                    });
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildProgressChart(results),
                            const SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge)),
                                if (allResults.isNotEmpty)
                                  TextButton.icon(
                                    onPressed: _showClearAllConfirmationDialog,
                                    icon: Icon(Icons.delete_sweep_outlined, color: Colors.red.shade400),
                                    label: Text('Clear All', style: TextStyle(color: Colors.red.shade400)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            if (results.isEmpty)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 40),
                                child: Center(child: Text('No items for the selected filter.', style: TextStyle(fontSize: 16))),
                              )
                            else
                              ...results.map((result) => _buildHistoryCard(result)),
                          ],
                        ),
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

  // --- NEW IMPLEMENTATION: Readiness Assessment Logic ---
  Widget _buildReadinessAssessment(List<TestResult> allResults) {
    if (allResults.isEmpty) return const SizedBox.shrink();

    // 1. Calculate overall average score
    double totalScore = 0;
    for (var result in allResults) {
      totalScore += result.score;
    }
    int averageScore = (totalScore / allResults.length).round();

    // 2. Map to Verdict based on requirements
    String verdict;
    Color verdictColor;
    IconData verdictIcon;

    if (averageScore <= 50) {
      verdict = "Needs Practice";
      verdictColor = Colors.orange.shade800;
      verdictIcon = Icons.warning_amber_rounded;
    } else if (averageScore <= 75) {
      verdict = "Getting Ready";
      verdictColor = Colors.blue.shade700;
      verdictIcon = Icons.trending_up;
    } else {
      verdict = "Interview Ready";
      verdictColor = Colors.green.shade700;
      verdictIcon = Icons.check_circle_outline;
    }

    // 3. Build the Conclusive Statement Card
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: verdictColor.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: verdictColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(verdictIcon, color: verdictColor, size: 28),
              const SizedBox(width: 8),
              Text(
                verdict.toUpperCase(),
                style: TextStyle(
                  color: verdictColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
              ),
              const Spacer(),
              Text(
                "$averageScore%",
                style: TextStyle(
                  color: verdictColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Based on your performance, you are $averageScore% ready for a general interview.",
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              color: Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChart(List<TestResult> results) {
    if (_selectedFilter == 'Aptitude Game') {
      final pageViewCard = SizedBox(
        height: 220,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _aptitudeCategories.length,
                    onPageChanged: (index) {
                      setState(() {});
                    },
                    itemBuilder: (context, idx) {
                      final cat = _aptitudeCategories[idx];
                      final values = results
                          .where((r) => r.categoryPercentages != null && r.categoryPercentages!.containsKey(cat))
                          .map((r) => r.categoryPercentages![cat]!)
                          .toList()
                          .reversed
                          .toList();

                      if (values.isEmpty) {
                        return Center(child: Text('$cat\nNo data yet', textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium));
                      }

                      final spots = List.generate(values.length, (i) => FlSpot(i.toDouble(), values[i]));
                      final avg = values.reduce((a, b) => a + b) / values.length;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cat, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 75,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: LineChart(
                                LineChartData(
                                  clipData: const FlClipData(top: false, bottom: false, left: false, right: false),
                                  gridData: const FlGridData(show: false),
                                  titlesData: const FlTitlesData(show: false),
                                  borderData: FlBorderData(show: false),
                                  minY: 0,
                                  maxY: 100,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: spots,
                                      isCurved: true,
                                      color: AppTheme.primaryColor,
                                      barWidth: 3,
                                      dotData: const FlDotData(show: true),
                                      belowBarData: BarAreaData(show: true, color: AppTheme.primaryColor.withAlpha((0.12 * 255).round())),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Avg: ${avg.round()}%', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_aptitudeCategories.length, (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_pageController.hasClients && _pageController.page?.round() == index)
                            ? AppTheme.primaryColor
                            : Colors.grey.withOpacity(0.5),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );

      return Column(children: [pageViewCard]);
    }

    if (results.length < 2) {
      return const SizedBox(height: 200, child: Center(child: Text("Complete at least two activities to see a progress chart.")));
    }

    final chartData = results.reversed.toList();

    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color.fromARGB((0.9 * 255).round(), 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 24, 12),
          child: LineChart(
            LineChartData(
              clipData: const FlClipData(top: false, bottom: false, left: false, right: false),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 44,
                    getTitlesWidget: (value, meta) {
                      if (value % 25 == 0) {
                        return Text('${value.toInt()}%', style: const TextStyle(fontSize: 10));
                      }
                      return const Text('');
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minY: 0,
              maxY: 100,
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(chartData.length, (index) => FlSpot(index.toDouble(), chartData[index].score)),
                  isCurved: true,
                  color: AppTheme.primaryColor,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: true, color: AppTheme.primaryColor.withAlpha((0.2 * 255).round())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(TestResult result) {
    VoidCallback? onTapAction;

    if (result.type == 'Aptitude Game' && result.rawScore != null && result.totalQuestions != null) {
      onTapAction = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AptitudeResultsScreen(
            score: result.rawScore!,
            totalQuestions: result.totalQuestions!,
            testName: result.name,
            categoryPercentages: result.categoryPercentages,
          )),
        );
      };
    } else if (result.type == 'Mock Interview') {
      onTapAction = () {
        if (result.feedback != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MockInterviewResultsScreen(feedback: result.feedback!, interviewLevel: result.name)),
          );
        }
      };
    } else if (result.type == 'Chatbot Interview') {
      onTapAction = () {
        if (result.feedback != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatbotResultsScreen(feedback: result.feedback!, interviewLevel: result.name)),
          );
        }
      };
    }

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color(0xFFEADFF0),
      shadowColor: Colors.deepPurple.withAlpha((0.1 * 255).round()),
      child: InkWell(
        onTap: onTapAction,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMd().add_jm().format(result.date),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${result.type}: ${result.name}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onTapAction != null)
                    ElevatedButton(
                      onPressed: onTapAction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4A0C7),
                        foregroundColor: const Color(0xFF491D7F),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                      ),
                      child: const Text('View'),
                    )
                  else
                    Text(
                      '${result.score.toInt()}%',
                      style: TextStyle(
                        color: result.score >= 50 ? Colors.green.shade700 : Colors.red.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red.shade700),
                    onPressed: () => _showDeleteConfirmationDialog(result),
                    tooltip: 'Delete Item',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}