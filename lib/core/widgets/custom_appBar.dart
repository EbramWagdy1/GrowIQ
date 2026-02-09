import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  const CustomAppBar({super.key, this.onBack});
  @override
  Size get preferredSize => const Size.fromHeight(160);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        width: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Back Button
              Positioned(
                left: 20,
                child: InkWell(
                  onTap: onBack ?? () => Navigator.pop(context),
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0BA37F),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
              // Title
            ],
          ),
        ),
      ),
    );
  }
}
