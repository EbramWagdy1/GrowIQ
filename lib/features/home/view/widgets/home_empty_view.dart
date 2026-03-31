import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';

class HomeEmptyView extends StatelessWidget {
  final TextEditingController controller;
  final String? errorMessage;

  const HomeEmptyView({
    super.key,
    required this.controller,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.eco_outlined, size: 60, color: AppColors.greyColor),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.noFarmsLinked,
            style: AppTextStyles.titleMedium(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.addYourDevice,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.enterDeviceId,
                      prefixIcon: const Icon(Icons.qr_code_scanner),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          context.read<DeviceCubit>().addDevice(
                            controller.text.trim(),
                          );
                          controller.clear();
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.connect,
                        style: const TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.errorColor),
            ),
          ],
        ],
      ),
    );
  }
}
