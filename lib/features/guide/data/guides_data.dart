import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../models/guide_step.dart';

class GuideSection {
  final String title;
  final IconData icon;
  final List<GuideStep> steps;

  GuideSection({required this.title, required this.icon, required this.steps});
}

class GuidesData {
  static List<GuideSection> getRegistrationProcess() {
    return [
      GuideSection(
        title: 'নিবন্ধন প্রক্রিয়া',
        icon: Icons.drive_eta_rounded,
        steps: [
          GuideStep(
            title: 'আবেদন দাখিল',
            icon: HugeIcons.strokeRoundedLicense,
            color: Colors.blue,
            content:
                'সংশ্লিষ্ট বিআরটিএ অফিসে নির্ধারিত ফরমে প্রয়োজনীয় কাগজপত্রসহ মোটরযানের রেজিস্ট্রেশনের জন্য আবেদন করতে হবে।',
          ),
          GuideStep(
            title: 'যাচাই ও স্লিপ',
            icon: HugeIcons.strokeRoundedFiles01,
            color: Colors.orange,
            content:
                'আবেদন ও সংযুক্ত দালিলাদি যাচাই-বাছাই করে সঠিক পাওয়া গেলে রেজিস্ট্রেশন ফি জমা প্রদানের জন্য একটি এ্যাসেসমেন্ট স্লিপ প্রদান করা হবে।',
          ),
          GuideStep(
            title: 'গাড়ি পরিদর্শন',
            icon: HugeIcons.strokeRoundedSearch01,
            color: Colors.purple,
            content:
                'ফি জমা প্রদানের পর গাড়িটি পরিদর্শণের জন্য বিআরটিএ অফিসে হাজির করতে হবে।',
          ),
          GuideStep(
            title: 'অনুমোদন ও প্রাপ্তি',
            icon: HugeIcons.strokeRoundedCheckList,
            color: Colors.teal,
            content:
                'পরিদর্শণ শেষে মালিকানা ও গাড়ি সংক্রান্ত তথ্য সিস্টেমে এন্ট্রি হওয়ার পর রেজিস্ট্রেশনের অনুমোদন প্রদান করা হয় এবং প্রাপ্তিস্বীকারপত্র, ফিটনেস সার্টিফিকেট ও ট্যাক্স টোকেন প্রদান করা হয়।',
          ),
          GuideStep(
            title: 'বায়োমেট্রিক্স',
            icon: HugeIcons.strokeRoundedFingerPrint,
            color: Colors.red,
            content:
                'ডিজিটাল রেজিস্ট্রেশন সার্টিফিকেট (ডিআরসি) তৈরির জন্য বায়োমেট্রিক্স (ছবি, স্বাক্ষর ও আঙ্গুলের ছাপ) প্রদানের জন্য সংশ্লিষ্ট অফিসে উপস্থিত হতে হবে।',
          ),
        ],
      ),
      GuideSection(
        title: 'প্রয়োজনীয় কাগজপত্র',
        icon: Icons.checklist_rounded,
        steps: [
          GuideStep(
            title: 'আবেদনপত্র',
            icon: HugeIcons.strokeRoundedTaskDaily01,
            color: Colors.indigo,
            content:
                'মালিক ও আমদানিকারক/ডিলার কর্তৃক যথাযথভাবে পূরণ ও স্বাক্ষর করা নির্ধারিত আবেদনপত্র।',
          ),
          GuideStep(
            title: 'আমদানি দলিল',
            icon: HugeIcons.strokeRoundedFiles01,
            color: Colors.blueGrey,
            content: 'বিল অব এন্ট্রি, ইনভয়েস, বিল অব লেডিং ও এলসিএ কপি।',
          ),
          GuideStep(
            title: 'অন্যান্য দলিল',
            icon: HugeIcons.strokeRoundedNote01,
            color: Colors.cyan,
            content:
                'সেল সার্টিফিকেট, গেট পাস, ভ্যাট-১১ (ভ্যাট পরিশোধের প্রমাণ) এবং প্যাকিং লিস্ট।',
          ),
        ],
      ),
    ];
  }

  static List<GuideSection> getLicenseRenew() {
    return [
      GuideSection(
        title: 'নবায়ন প্রক্রিয়া',
        icon: Icons.refresh_rounded,
        steps: [
          GuideStep(
            title: 'অপেশাদার লাইসেন্স',
            icon: HugeIcons.strokeRoundedUser,
            color: Colors.blue,
            content:
                'নির্ধারিত ফি জমা দিয়ে প্রয়োজনীয় কাগজপত্রসহ বিআরটিএর নির্দিষ্ট সার্কেল অফিসে আবেদন করতে হবে।',
          ),
          GuideStep(
            title: 'বায়োমেট্রিক্স ও প্রিন্টিং',
            icon: HugeIcons.strokeRoundedFingerPrint,
            color: Colors.orange,
            content:
                'কাগজপত্র সঠিক পাওয়া গেলে একইদিনে বায়োমেট্রিক্স গ্রহণ করা হয়। প্রিন্টিং সম্পন্ন হলে এসএমএস এর মাধ্যমে জানানো হয়।',
          ),
          GuideStep(
            title: 'পেশাদার লাইসেন্স',
            icon: HugeIcons.strokeRoundedPassport,
            color: Colors.purple,
            content:
                'পেশাদার ড্রাইভিং লাইসেন্সধারীদের পুনরায় একটি ব্যবহারিক পরীক্ষায় অংশগ্রহণ করতে হবে।',
          ),
        ],
      ),
      GuideSection(
        title: 'প্রয়োজনীয় কাগজপত্র',
        icon: Icons.checklist_rounded,
        steps: [
          GuideStep(
            title: 'আবেদন ও মেডিকেল',
            icon: HugeIcons.strokeRoundedTaskDaily01,
            color: Colors.indigo,
            content:
                'নির্ধারিত ফরমে আবেদন ও রেজিস্টার্ড ডাক্তার কর্তৃক মেডিকেল সার্টিফিকেট।',
          ),
          GuideStep(
            title: 'পরিচয়পত্র ও ছবি',
            icon: HugeIcons.strokeRoundedContact01,
            color: Colors.teal,
            content:
                'ন্যাশনাল আইডি কার্ডের ফটোকপি এবং সদ্য তোলা পাসপোর্ট ও স্ট্যাম্প সাইজ ছবি।',
          ),
        ],
      ),
    ];
  }

  static List<GuideSection> getTaxTokenRenew() {
    return [
      GuideSection(
        title: 'নবায়ন প্রক্রিয়া',
        icon: Icons.money_rounded,
        steps: [
          GuideStep(
            title: 'ফি প্রদান',
            icon: HugeIcons.strokeRoundedMoney03,
            color: Colors.green,
            content:
                'বিআরটিএ ফি গ্রহণের কাজে নিয়োজিত ব্যাংক বা অনলাইনে নির্ধারিত ফি প্রদান করতে হবে।',
          ),
          GuideStep(
            title: 'অনলাইন নবায়ন',
            icon: HugeIcons.strokeRoundedGlobal,
            color: Colors.blue,
            content:
                'বিকাশের মাধ্যমে ফি প্রদান করা হলে নবায়নকৃত ট্যাক্স টোকেন গ্রাহকের ঠিকানায় কুরিয়ারের মাধ্যমে পাঠানো হয়।',
          ),
        ],
      ),
      GuideSection(
        title: 'প্রয়োজনীয় কাগজপত্র',
        icon: Icons.checklist_rounded,
        steps: [
          GuideStep(
            title: 'পূর্বের সার্টিফিকেট',
            icon: HugeIcons.strokeRoundedFiles01,
            color: Colors.orange,
            content: 'পূর্বের ইস্যুকৃত ট্যাক্স টোকেন সার্টিফিকেট (মূল কপি)।',
          ),
        ],
      ),
    ];
  }

  static List<GuideSection> getFitnessRenew() {
    return [
      GuideSection(
        title: 'নবায়ন প্রক্রিয়া',
        icon: Icons.verified_rounded,
        steps: [
          GuideStep(
            title: 'আবেদন ও ফি',
            icon: HugeIcons.strokeRoundedMoney03,
            color: Colors.green,
            content:
                'নির্ধারিত ফি জমা দিয়ে প্রয়োজনীয় কাগজপত্রসহ বিআরটিএর যে কোনো সার্কেল অফিসে আবেদন করতে হবে।',
          ),
          GuideStep(
            title: 'গাড়ি পরিদর্শন',
            icon: HugeIcons.strokeRoundedSearch01,
            color: Colors.blue,
            content:
                'গাড়িটি পরিদর্শনের জন্য বিআরটিএ অফিসে হাজির করতে হবে। পরিদর্শন শেষে ফিটনেস সার্টিফিকেট প্রদান করা হয়।',
          ),
        ],
      ),
      GuideSection(
        title: 'প্রয়োজনীয় কাগজপত্র',
        icon: Icons.checklist_rounded,
        steps: [
          GuideStep(
            title: 'পূর্বের সার্টিফিকেট',
            icon: HugeIcons.strokeRoundedFiles01,
            color: Colors.orange,
            content: 'পূর্বের ইস্যুকৃত ফিটনেস সার্টিফিকেট (মূল কপি)।',
          ),
          GuideStep(
            title: 'অন্যান্য',
            icon: HugeIcons.strokeRoundedNote01,
            color: Colors.indigo,
            content: 'ট্যাক্স টোকেনের ফটোকপি এবং মালিকের ছবি।',
          ),
        ],
      ),
    ];
  }

  static List<GuideSection> getOwnerChange() {
    return [
      GuideSection(
        title: 'মালিকানা পরিবর্তন',
        icon: Icons.person_add_rounded,
        steps: [
          GuideStep(
            title: 'আবেদন দাখিল',
            icon: HugeIcons.strokeRoundedUserSharing,
            color: Colors.blue,
            content:
                'ক্রেতা ও বিক্রেতা উভয়কে প্রয়োজনীয় কাগজপত্রসহ সংশ্লিষ্ট বিআরটিএ অফিসে আবেদন করতে হবে।',
          ),
          GuideStep(
            title: 'বায়োমেট্রিক্স',
            icon: HugeIcons.strokeRoundedFingerPrint,
            color: Colors.orange,
            content:
                'ক্রেতা ও বিক্রেতা উভয়কেই বায়োমেট্রিক্স প্রদানের জন্য বিআরটিএ অফিসে উপস্থিত হতে হবে।',
          ),
        ],
      ),
      GuideSection(
        title: 'প্রয়োজনীয় কাগজপত্র',
        icon: Icons.checklist_rounded,
        steps: [
          GuideStep(
            title: 'হলফনামা',
            icon: HugeIcons.strokeRoundedNote01,
            color: Colors.indigo,
            content:
                'নির্ধারিত ফরমে ক্রেতা ও বিক্রেতার ছবিসহ স্বাক্ষরকৃত হলফনামা।',
          ),
          GuideStep(
            title: 'ফি প্রদান',
            icon: HugeIcons.strokeRoundedMoney03,
            color: Colors.green,
            content: 'মালিকানা পরিবর্তনের নির্ধারিত ফি জমা প্রদানের রশিদ।',
          ),
        ],
      ),
    ];
  }

  static List<GuideSection> getCarModification() {
    return [
      GuideSection(
        title: 'পরিবর্তন প্রক্রিয়া',
        icon: Icons.settings_suggest_rounded,
        steps: [
          GuideStep(
            title: 'অনুমতি গ্রহণ',
            icon: HugeIcons.strokeRoundedCheckList,
            color: Colors.blue,
            content:
                'গাড়ির কাঠামো পরিবর্তনের পূর্বে বিআরটিএ থেকে লিখিত অনুমতি গ্রহণ করতে হবে।',
          ),
          GuideStep(
            title: 'পরিবর্তন ও পরিদর্শন',
            icon: HugeIcons.strokeRoundedTools,
            color: Colors.orange,
            content:
                'অনুমতি অনুযায়ী পরিবর্তন করার পর গাড়িটি পুনরায় বিআরটিএ অফিসে পরিদর্শনের জন্য হাজির করতে হবে।',
          ),
        ],
      ),
      GuideSection(
        title: 'প্রয়োজনীয় কাগজপত্র',
        icon: Icons.checklist_rounded,
        steps: [
          GuideStep(
            title: 'আবেদন ও ফি',
            icon: HugeIcons.strokeRoundedTaskDaily01,
            color: Colors.indigo,
            content: 'নির্ধারিত ফরমে আবেদন ও পরিবর্তন ফি জমা প্রদানের রশিদ।',
          ),
        ],
      ),
    ];
  }
}
