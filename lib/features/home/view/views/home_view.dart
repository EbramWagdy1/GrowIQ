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
  final GlobalKey<HomeBodyState> _homeBodyKey = GlobalKey<HomeBodyState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeBar(
            onAddDevice: () {
              _homeBodyKey.currentState?.showAddDeviceDialog();
            },
          ),
          const SizedBox(height: 10),
          Expanded(child: HomeBody(key: _homeBodyKey)),
        ],
      ),
      floatingActionButton: const Chatboticon(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}