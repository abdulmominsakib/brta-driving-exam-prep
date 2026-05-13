import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Responsive {
  static bool get isWeb => kIsWeb;

  static bool get isMobileDevice => !kIsWeb;

  static bool isDesktop(BuildContext context) =>
      context.breakpoint >= const ShadBreakpointLG(1024);

  static bool isTablet(BuildContext context) =>
      context.breakpoint >= const ShadBreakpointMD(768) &&
      context.breakpoint < const ShadBreakpointLG(1024);

  static bool isPhone(BuildContext context) =>
      context.breakpoint < const ShadBreakpointMD(768);

  static bool isMobileWidth(BuildContext context) =>
      context.breakpoint < const ShadBreakpointLG(1024);

  static double maxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 1200;
    if (isTablet(context)) return 960;
    return double.infinity;
  }
}
