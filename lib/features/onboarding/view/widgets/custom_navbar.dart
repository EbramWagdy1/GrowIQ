import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/features/onboarding/view/views/functions/onboarding_visit.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onboardingvisit();
        customReplacementNavigate(context, '/Login');
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(AppLocalizations.of(context)!.skip, style: AppTextStyles.bodyText1(context)),
        ),
      ),
    );
  }
}
