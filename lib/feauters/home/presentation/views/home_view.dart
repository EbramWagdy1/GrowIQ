import 'package:flutter/material.dart';
import 'package:growiq/feauters/home/presentation/widgets/HomeBar.dart';
import 'package:growiq/feauters/home/presentation/widgets/NavBar.dart';
import 'package:growiq/feauters/home/presentation/widgets/chatbot_icon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: HomeBar()),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        const SliverToBoxAdapter(child: Placeholder(fallbackHeight: 400)),
      ],
    ),
    const Center(child: Text('Search Page' )),
    const Center(child: Text('Chat Page')),
    const Center(child: Text('Profile Page')),
  ];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],

          // Floating Chatbot
          const Positioned(
            bottom: 10,
            right: 10,
            child: Chatboticon(),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex, 
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
