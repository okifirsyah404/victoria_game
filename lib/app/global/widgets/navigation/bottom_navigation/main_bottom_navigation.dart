import 'package:flutter/material.dart';

import '../../../icons/custom_icon_data_icons.dart';

class MainBottomNavigation extends StatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  State<MainBottomNavigation> createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(CustomIconData.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomIconData.joystick),
          label: "Sewa",
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomIconData.service),
          label: "Servis PS",
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomIconData.historyReceipt),
          label: "Riwayat",
        ),
      ],
    );
  }
}
