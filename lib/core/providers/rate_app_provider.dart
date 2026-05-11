import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'rate_app_provider.g.dart';

@riverpod
class RateApp extends _$RateApp {
  static const String _hasRatedKey = 'has_rated_app';
  static const String _lastPromptKey = 'last_review_prompt_date';

  @override
  FutureOr<void> build() {}

  /// Manually open the store listing for the user to write a review
  Future<void> openStoreListing() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.openStoreListing();
    }
  }

  /// Request a review popup if conditions are met
  /// This should be called after a "positive action"
  Future<void> requestReview() async {
    final prefs = await SharedPreferences.getInstance();
    final hasRated = prefs.getBool(_hasRatedKey) ?? false;

    if (hasRated) return;

    // Check if we prompted recently (e.g., in the last 7 days)
    final lastPromptStr = prefs.getString(_lastPromptKey);
    if (lastPromptStr != null) {
      final lastPrompt = DateTime.parse(lastPromptStr);
      final difference = DateTime.now().difference(lastPrompt);
      if (difference.inDays < 7) {
        return; // Don't prompt too often
      }
    }

    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
      // Update the last prompt date
      await prefs.setString(_lastPromptKey, DateTime.now().toIso8601String());
      // Ideally we don't mark as rated just for prompting,
      // but if you want to stop prompting after one success, you could contextually handle it.
      // For now, let's just track the prompt time.
    }
  }
}
