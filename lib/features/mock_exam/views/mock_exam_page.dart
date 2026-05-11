import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mock_exam_quiz/data/models/mock_exam_result.dart';
import '../../mock_exam_quiz/providers/mock_exam_repository_provider.dart';
import 'components/mock_exam_info_card.dart';
import 'components/mock_exam_start_button.dart';
import 'components/mock_exam_tutorial_helper.dart';

class MockExamPage extends ConsumerStatefulWidget {
  const MockExamPage({super.key});

  @override
  ConsumerState<MockExamPage> createState() => _MockExamPageState();
}

class _MockExamPageState extends ConsumerState<MockExamPage> {
  List<MockExamResult> _history = [];
  bool _isLoading = true;

  // Tutorial related
  final GlobalKey _welcomeKey = GlobalKey();
  final GlobalKey _infoTipKey = GlobalKey();
  final GlobalKey _startButtonKey = GlobalKey();
  final GlobalKey _historyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final history = await ref.read(mockExamRepositoryProvider).getResults();
      if (mounted) {
        setState(() {
          _history = history;
          _isLoading = false;
        });
        _checkAndShowTutorial();
      }
    } catch (e) {
      debugPrint('Error loading history: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _checkAndShowTutorial() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasShownTutorial =
          prefs.getBool('hasShownMockExamMainTutorial') ?? false;

      if (!hasShownTutorial) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            MockExamTutorialHelper.showTutorial(
              context: context,
              welcomeKey: _welcomeKey,
              infoTipKey: _infoTipKey,
              startButtonKey: _startButtonKey,
              historyKey: _history.isNotEmpty ? _historyKey : null,
              onFinish: () {
                prefs.setBool('hasShownMockExamMainTutorial', true);
              },
            );
          }
        });
      }
    } catch (e) {
      debugPrint('Error showing tutorial: $e');
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: ShadTheme.of(context).brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        title: Text(
          'মডেল টেস্ট', // Model Test
          style: ShadTheme.of(
            context,
          ).textTheme.h3.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    // Hero Image or Icon
                    Center(
                      child: Container(
                        key: _welcomeKey,
                        width: 140,
                        height: 140,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const HugeIcon(
                          icon: HugeIcons.strokeRoundedTaskDaily01,
                          size: 64,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // New Info Tip
                    Column(
                      children: [
                        Container(
                          key: _infoTipKey,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.amber.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HugeIcon(
                                icon: HugeIcons.strokeRoundedInformationCircle,
                                color: Colors.amber,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "পরীক্ষায় লিখিত পরীক্ষা নেওয়া হবে, এভাবে MCQ স্টাইলে দেওয়া হবেনা, তাই এখানে যেই অপশনটা সঠিক উত্তর ওটা ভালো ভাবে পড়ে নিয়েন, উত্তর দিতে ইজি হবে।",
                                  style: ShadTheme.of(context).textTheme.p
                                      .copyWith(
                                        color: Colors.grey,
                                        height: 1.4,
                                        fontSize: 14,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Info Card
                        const MockExamInfoCard(),
                        const SizedBox(height: 32),
                      ],
                    ),

                    // Start Button
                    MockExamStartButton(
                      key: _startButtonKey,
                      onTap: () async {
                        await context.push(
                          '/mock-exam-quiz',
                          extra: {
                            'dataPath': 'mock_test',
                            'questionLimit': 20,
                            'passThreshold': 15,
                          },
                        );
                        // Reload history when coming back
                        _loadHistory();
                      },
                    ),
                    const SizedBox(height: 48),

                    if (_history.isNotEmpty) ...[
                      Row(
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedWorkHistory,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'পূর্ববর্তী ফলাফল', // Previous Results
                            key: _historyKey,
                            style: ShadTheme.of(context).textTheme.large
                                .copyWith(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            if (_isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_history.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 24.0, top: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedTransactionHistory,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'কোনো পরীক্ষার ইতিহাস পাওয়া যায়নি', // No exam history found
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final result = _history[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: ShadTheme.of(context).colorScheme.border,
                        ),
                      ),
                      color: ShadTheme.of(context).cardTheme.backgroundColor,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: result.isPassed
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.red.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: HugeIcon(
                            icon: result.isPassed
                                ? HugeIcons.strokeRoundedTick02
                                : HugeIcons.strokeRoundedCancel01,
                            color: result.isPassed ? Colors.green : Colors.red,
                            size: 24,
                          ),
                        ),
                        title: Text(
                          'স্কোর: ${result.score}/${result.totalQuestions}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _formatDate(result.timestamp),
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: result.isPassed
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            result.isPassed ? 'পাস' : 'ফেইল',
                            style: TextStyle(
                              color: result.isPassed
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  }, childCount: _history.length),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }
}
