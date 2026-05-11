import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../constants/app_colors.dart';

const kFontFamily = 'SolaimanLipi';

class AppTheme {
  static ShadThemeData get lightTheme {
    return ShadThemeData(
      brightness: Brightness.light,
      colorScheme: const ShadSlateColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        destructive: AppColors.secondary,
        background: AppColors.background,
        card: AppColors.card,
        border: AppColors.border,
        foreground: AppColors.textMain,
        mutedForeground: AppColors.textMuted,
        ring: AppColors.primary,
      ),
      textTheme: ShadTextTheme(family: kFontFamily),
    );
  }

  static ShadThemeData get darkTheme {
    return ShadThemeData(
      brightness: Brightness.dark,
      colorScheme: const ShadSlateColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        destructive: AppColors.secondary,
        background: AppColors.darkBackground,
        card: AppColors.darkCard,
        border: AppColors.darkBorder,
        foreground: AppColors.darkTextMain,
        mutedForeground: AppColors.darkTextMuted,
        ring: AppColors.primary,
      ),
      textTheme: ShadTextTheme(family: kFontFamily),
    );
  }
}
