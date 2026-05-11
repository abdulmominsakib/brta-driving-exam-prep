import 'package:flutter/material.dart';

class SignCategory {
  final String id;
  final String englishName;
  final String bengaliName;
  final String description;
  final String bengaliDescription;
  final String shape;
  final String color;

  const SignCategory({
    required this.id,
    required this.englishName,
    required this.bengaliName,
    required this.description,
    required this.bengaliDescription,
    required this.shape,
    required this.color,
  });

  factory SignCategory.fromJson(String id, Map<String, dynamic> json) {
    return SignCategory(
      id: id,
      englishName: json['english_name'] as String,
      bengaliName: json['bengali_name'] as String,
      description: json['description'] as String,
      bengaliDescription: json['bengali_description'] as String,
      shape: json['shape'] as String,
      color: json['color'] as String,
    );
  }

  Color get displayColor {
    switch (id) {
      case 'mandatory_prohibitory':
        return const Color(0xFFDC2626);
      case 'mandatory_compulsory':
        return const Color(0xFF2563EB);
      case 'warning':
        return const Color(0xFFF59E0B);
      case 'informative':
        return const Color(0xFF16A34A);
      default:
        return const Color(0xFF6B7280);
    }
  }
}

class TrafficSign {
  final String englishName;
  final String bengaliName;
  final String fileName;
  final String category;

  const TrafficSign({
    required this.englishName,
    required this.bengaliName,
    required this.fileName,
    required this.category,
  });

  factory TrafficSign.fromJson(Map<String, dynamic> json) {
    return TrafficSign(
      englishName: json['english_name'] as String,
      bengaliName: json['bengali_name'] as String,
      fileName: json['file_name'] as String,
      category: json['category'] as String,
    );
  }

  String get assetPath => 'assets/images/signs/$fileName';
}

class SignsData {
  final Map<String, SignCategory> categories;
  final List<TrafficSign> signs;

  const SignsData({required this.categories, required this.signs});

  factory SignsData.fromJson(Map<String, dynamic> json) {
    final categoriesDetails =
        json['categories_details'] as Map<String, dynamic>;
    final categories = <String, SignCategory>{};

    categoriesDetails.forEach((key, value) {
      categories[key] = SignCategory.fromJson(
        key,
        value as Map<String, dynamic>,
      );
    });

    final signsList = json['signs'] as List<dynamic>;
    final signs = signsList
        .map((e) => TrafficSign.fromJson(e as Map<String, dynamic>))
        .toList();

    return SignsData(categories: categories, signs: signs);
  }

  List<TrafficSign> getSignsByCategory(String categoryId) {
    return signs.where((sign) => sign.category == categoryId).toList();
  }

  SignCategory? getCategory(String categoryId) {
    return categories[categoryId];
  }
}
