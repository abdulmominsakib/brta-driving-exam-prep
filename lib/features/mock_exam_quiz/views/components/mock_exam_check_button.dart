import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MockExamCheckButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onTap;
  final GlobalKey? buttonKey;

  const MockExamCheckButton({
    super.key,
    required this.isEnabled,
    required this.onTap,
    this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        key: buttonKey,
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isEnabled ? const Color(0xFF58CC02) : const Color(0xFFE5E7EB),
          borderRadius: BorderRadius.circular(16),
          border: Border(
            bottom: BorderSide(
              color: isEnabled
                  ? const Color(0xFF58A700)
                  : const Color(0xFFAFB2B7),
              width: 4.0,
            ),
          ),
        ),
        child: Center(
          child: Text(
            'চেক করুন',
            style: ShadTheme.of(context).textTheme.large.copyWith(
              color: isEnabled ? Colors.white : const Color(0xFFAFB2B7),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
