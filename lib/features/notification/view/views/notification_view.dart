import 'package:flutter/material.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Text(AppLocalizations.of(context)!.comingSoon),
      ),
    );
  }
}