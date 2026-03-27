import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final String? title;
  final bool showBack;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    this.onBack,
    this.title,
    this.showBack = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// Back Button
            if (showBack)
              PositionedDirectional(
                start: 20,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: onBack ?? () => Navigator.pop(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Icons.arrow_forward_ios
                          : Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ),

            if (title != null) Text(title!, style: AppTextStyles.titleMedium(context)),

            /// Actions
            if (actions != null)
              PositionedDirectional(
                end: 20,
                child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
              ),
          ],
        ),
      ),
    );
  }
}
