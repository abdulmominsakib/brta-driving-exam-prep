import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockExamStartButton extends StatelessWidget {
  final VoidCallback onTap;

  const MockExamStartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF58CC02),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0xFF58A700), offset: Offset(0, 4)),
          ],
        ),
        child: Center(
          child: Text(
            'পরীক্ষা শুরু করুন', // Start Exam
            style: ShadTheme.of(context).textTheme.large.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
