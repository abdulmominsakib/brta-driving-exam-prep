import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/traffic_sign.dart';

class SignsService {
  Future<SignsData> loadSignsData() async {
    final jsonString = await rootBundle.loadString(
      'assets/images/signs/signs.json',
    );
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return SignsData.fromJson(jsonData);
  }
}
