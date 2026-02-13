import 'package:flutter/material.dart';
import 'package:growiq/features/home/view/widgets/home_bar.dart';
import 'package:growiq/features/home/view/widgets/chatbot_icon.dart';
import 'package:growiq/features/home/view/widgets/home_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: HomeBar()),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(child: HomeBody()),
        ],
      ),
      floatingActionButton: const Chatboticon(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
