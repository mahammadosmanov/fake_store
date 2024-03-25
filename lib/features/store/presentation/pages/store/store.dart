import 'package:flutter/material.dart';
import 'package:test_task/features/store/presentation/pages/home/home.dart';
import 'package:test_task/features/store/presentation/pages/profile/profile.dart';
import 'package:test_task/features/store/presentation/widgets/bottom_bar.dart';

class StoreView extends StatelessWidget {
  StoreView({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                const HomeView(),
                ProfileView(),
              ],
            ),
          ),
          Column(
            children: [
              const Spacer(),
              BottomBar(
                pageController: pageController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
