import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) return child;
    return _UpdatePageAlt(child: child);
  }
}

class _UpdatePageAlt extends StatefulWidget {
  final Widget child;
  const _UpdatePageAlt({required this.child});

  @override
  State<_UpdatePageAlt> createState() => _UpdatePageAltState();
}

class _UpdatePageAltState extends State<_UpdatePageAlt> {
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    if (Platform.isAndroid) {
      try {
        final info = await InAppUpdate.checkForUpdate();
        debugPrint('Update check completed: $info');
        setState(() {
          _updateInfo = info;
        });

        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          if (info.immediateUpdateAllowed) {
            debugPrint('Performing immediate update');
            await InAppUpdate.performImmediateUpdate();
            debugPrint('Update completed');
          } else if (info.flexibleUpdateAllowed) {
            debugPrint('Starting flexible update');
            await InAppUpdate.startFlexibleUpdate();
            debugPrint('Completing flexible update');
            await InAppUpdate.completeFlexibleUpdate();
            debugPrint('Update completed');
          }
        }
      } catch (e) {
        debugPrint('Update check failed: $e');
        debugPrint('Update check failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.system_update, size: 64),
              const SizedBox(height: 16),
              const Text(
                'New Update Available',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Please update the app to continue using the latest features',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await InAppUpdate.performImmediateUpdate();
                  } catch (e) {
                    debugPrint('Update failed: $e');
                  }
                },
                child: const Text('Update Now'),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
