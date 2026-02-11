import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/feauters/me/presentation/widgets/Team_Card_Widget.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'About'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.aboutGrowIQTitle,
                    style: AppTextStyles.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.aboutGrowIQDesc,
                    style: AppTextStyles.bodyText1,
                  ),

                  const SizedBox(height: 30),

                  Text("Our Team", style: AppTextStyles.titleMedium),

                  const SizedBox(height: 20),

                  /// Team Members
                  const TeamMemberCard(
                    name: "Ebram Wagdy",
                    role: "Software & Flutter Developer",
                    imagePath: Assets.imagesEbram,
                    linkedInLink: "https://www.linkedin.com/in/ebramwagdy/",
                    githubLink: "https://github.com/EbramWagdy1",
                  ),
                  const SizedBox(height: 20),

                  const TeamMemberCard(
                    name: "Yousef Botros",
                    role: "Penetration Tester", 
                    imagePath: Assets.imagesYousef,
                    linkedInLink: "https://www.linkedin.com/in/yousef-botros-09592a335/",
                    githubLink: "https://github.com/YousefBotros10",
                  ),
                  const SizedBox(height: 20),

                  const TeamMemberCard(
                    name: "Ahmed Mohamed",
                    role: "Backend Developer",
                    imagePath: "assets/images/ebram.jpg",
                  ),
                  const SizedBox(height: 20),

                  const TeamMemberCard(
                    name: "Ebrahim Mostafa",
                    role: "Backend Developer",
                    imagePath: "assets/images/ebram.jpg",
                  ),
                  const SizedBox(height: 20),

                  const TeamMemberCard(
                    name: "Ismail Ayman",
                    role: "Backend Developer",
                    imagePath: "assets/images/ebram.jpg",
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
