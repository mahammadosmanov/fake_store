import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black,
      child: Row(
        children: [
          const SizedBox(
            width: 80,
          ),
          GestureDetector(
            onTap: () {
              pageController.animateToPage(
                0,
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.linearToEaseOut,
              );
            },
            child: const SizedBox(
              height: 50,
              child: Icon(
                Icons.home,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              pageController.animateToPage(
                1,
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.linearToEaseOut,
              );
            },
            child: const SizedBox(
              height: 50,
              child: Icon(
                Icons.man,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 80,
          ),
        ],
      ),
    );
  }
}
