import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF004D40), 
        ),
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
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
