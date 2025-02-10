import 'package:ecommerce_machinetest/view/navigation/home_main_view.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigation extends StatelessWidget {
  HomeBottomNavigation({super.key});

  final List<IconData> _icons = [
    Icons.home,
    Icons.account_circle,
    Icons.settings,
  ];

  final List<String> _labels = [
    "Home",
    "Profile",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationNotifier.value;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_icons.length, (index) {
          final isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () {
              navigationNotifier.value = index;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: isSelected ? Colors.indigo.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    _icons[index],
                    color: isSelected ? Colors.indigo : Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _labels[index],
                    style: TextStyle(color: isSelected ? Colors.indigo : Colors.grey, fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
