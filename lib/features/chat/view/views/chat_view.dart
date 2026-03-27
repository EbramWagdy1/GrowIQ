import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/widgets/custom_button.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ChatIntroView extends StatelessWidget {
  const ChatIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // AppBar
          CustomAppBar(),
          // White container
          Expanded(
            // ignore: avoid_unnecessary_containers
            child: Container(
             
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      AppLocalizations.of(context)!.hello,
                      style: AppTextStyles.headlineLarge(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      AppLocalizations.of(context)!.slogn,
                      style: AppTextStyles.bodyText1(context),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButtom(
                      text: AppLocalizations.of(context)!.chatbt,
                      onPressed: () => {
                        customNavigate(context, '/start-chat'),
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Bottom SVG
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SvgPicture.asset(
                        Assets.svgsCustomer,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
