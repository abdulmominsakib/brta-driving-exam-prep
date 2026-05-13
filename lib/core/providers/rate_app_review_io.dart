import 'package:in_app_review/in_app_review.dart';

class RateAppReview {
  Future<bool> isAvailable() async {
    final inAppReview = InAppReview.instance;
    return await inAppReview.isAvailable();
  }

  Future<void> openStoreListing() async {
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.openStoreListing();
    }
  }

  Future<void> requestReview() async {
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    }
  }
}
