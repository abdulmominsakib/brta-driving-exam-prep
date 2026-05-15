import '../models/penalty_offense.dart';
import '../models/penalty_rule.dart';

const penaltiesIntro =
    'বাংলাদেশে ড্রাইভিং মূলত সড়ক পরিবহন আইন, ২০১৮ দ্বারা নিয়ন্ত্রিত। '
    'এই আইনের লক্ষ্য হলো সড়কে শৃঙ্খলা ফেরানো এবং জননিরাপত্তা নিশ্চিত করা।';

const penaltiesEducationRule =
    'ড্রাইভিং লাইসেন্সের জন্য আবেদনকারীকে ন্যূনতম ৮ম শ্রেণি পাস হতে হবে।';

const penaltiesPointSystem =
    'RSPS (Road Safety Penalty System) অনুযায়ী প্রতিটি লাইসেন্সে ১২ পয়েন্ট থাকে। '
    'নির্দিষ্ট ট্রাফিক আইন ভাঙলে পয়েন্ট কাটা হয়। '
    'সব ১২ পয়েন্ট শেষ হয়ে গেলে লাইসেন্স স্থগিত বা বাতিল হতে পারে।';

const penaltiesEnforcement =
    'ট্রাফিক পুলিশিং এবং ডিজিটাল ট্র্যাকিংয়ের মাধ্যমে আইন প্রয়োগ আরও কঠোর হয়েছে। '
    'রেজিস্ট্রেশন, ট্যাক্স টোকেন, ফিটনেস, রুট পারমিট এবং লাইসেন্স আপডেট রাখা জরুরি।';

const List<PenaltyRule> majorDrivingRules = [
  PenaltyRule(
    title: 'সিটবেল্ট বাধ্যতামূলক',
    description:
        'গাড়ি চলন্ত অবস্থায় চালক ও সামনের যাত্রীকে সিটবেল্ট পরতেই হবে।',
    icon: '🚗',
  ),
  PenaltyRule(
    title: 'হেলমেট বাধ্যতামূলক',
    description:
        'মোটরসাইকেল চালক ও আরোহী উভয়ের মানসম্মত হেলমেট পরা বাধ্যতামূলক।',
    icon: '🪖',
  ),
  PenaltyRule(
    title: 'মোবাইল ফোন নিষিদ্ধ',
    description:
        'গাড়ি চালানোর সময় মোবাইল ফোন বা যেকোনো যোগাযোগ ডিভাইস ব্যবহার নিষিদ্ধ।',
    icon: '📵',
  ),
  PenaltyRule(
    title: 'রুট পারমিট ও ফিটনেস',
    description:
        'বাণিজ্যিক গাড়িতে বৈধ রুট পারমিট ও হালনাগাদ ফিটনেস সার্টিফিকেট থাকতে হবে।',
    icon: '📄',
  ),
  PenaltyRule(
    title: 'অননুমোদিত মডিফিকেশন বেআইনি',
    description:
        'সাইলেন্সার, ব্রেক, হর্ন বা বডিতে অনুমোদনহীন পরিবর্তন করলে শাস্তিযোগ্য অপরাধ।',
    icon: '🛠️',
  ),
  PenaltyRule(
    title: 'উল্টোপথে গাড়ি চালানো গুরুতর অপরাধ',
    description:
        'ট্রাফিকের নির্ধারিত দিকের বিপরীতে গাড়ি চালানো গুরুতর আইন লঙ্ঘন।',
    icon: '⛔',
  ),
];

const List<PenaltyOffense> penaltyOffenses = [
  PenaltyOffense(
    offense: 'বৈধ লাইসেন্স ছাড়া গাড়ি চালানো',
    maxFine: '২৫,০০০ টাকা',
    punishment: '৬ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'নিবন্ধন (Registration) ছাড়া গাড়ি চালানো',
    maxFine: '৫০,০০০ টাকা',
    punishment: '৬ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'ফিটনেসবিহীন গাড়ি চালানো',
    maxFine: '২৫,০০০ টাকা',
    punishment: '৬ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'রুট পারমিট ছাড়া বাণিজ্যিক গাড়ি চালানো',
    maxFine: '২৫,০০০ টাকা',
    punishment: '৬ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'গাড়ির অবৈধ বডি পরিবর্তন/পরিবর্ধন',
    maxFine: '৩,০০,০০০ টাকা',
    punishment: '৩ বছর পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'মিটার টেম্পারিং (প্রযোজ্য পরিবহনের ক্ষেত্রে)',
    maxFine: '৫০,০০০ টাকা',
    punishment: '৬ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'অতিরিক্ত গতিতে গাড়ি চালানো',
    maxFine: '১০,০০০ টাকা',
    punishment: '৩ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'উল্টোপথে (Wrong way) গাড়ি চালানো',
    maxFine: '১০,০০০ টাকা',
    punishment: '৩ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'ট্রাফিক সিগন্যাল অমান্য করা',
    maxFine: '১০,০০০ টাকা',
    punishment: '৩ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'নিষিদ্ধ/হাইড্রোলিক হর্ন বাজানো',
    maxFine: '১৫,০০০ টাকা',
    punishment: '৩ মাস পর্যন্ত জেল বা উভয়',
  ),
  PenaltyOffense(
    offense: 'হেলমেট ছাড়া মোটরসাইকেল চালানো',
    maxFine: '১০,০০০ টাকা',
    punishment: 'জরিমানা এবং পয়েন্ট কর্তন',
  ),
  PenaltyOffense(
    offense: 'চলন্ত অবস্থায় সিটবেল্ট না বাঁধা',
    maxFine: '৫,০০০ টাকা',
    punishment: 'শুধুমাত্র জরিমানা',
  ),
  PenaltyOffense(
    offense: 'গাড়ি চালানোর সময় মোবাইল ফোনে কথা বলা',
    maxFine: '৫,০০০ টাকা',
    punishment: 'শুধুমাত্র জরিমানা',
  ),
  PenaltyOffense(
    offense: 'ভুল/অবৈধ পার্কিং',
    maxFine: '৫,০০০ টাকা',
    punishment: 'শুধুমাত্র জরিমানা',
  ),
  PenaltyOffense(
    offense: 'জে-ওয়াকিং (পথচারী কর্তৃক আইন ভঙ্গ)',
    maxFine: '৫,০০০ টাকা',
    punishment: 'শুধুমাত্র জরিমানা',
  ),
];
