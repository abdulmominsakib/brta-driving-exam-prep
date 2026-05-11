import 'package:flutter/material.dart';

class HeroImage extends StatelessWidget {
  const HeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Image.asset(
        'assets/images/onboarding.webp',
        fit: BoxFit.fitWidth,
        width: double.infinity,
      ),
    );
  }
}
