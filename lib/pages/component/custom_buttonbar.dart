import 'package:flutter/material.dart';
import 'package:hydroponic_app/pages/common/colors.dart';
import 'package:hydroponic_app/providers/button_providers';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback onKonsultasi;
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onKonsultasi,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavBarProvider = Provider.of<ButtonProviders>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: bottomNavBarProvider.currentIndex,
      onTap: (index) {
        if (index != 2) {
          bottomNavBarProvider.currentIndex = index;
          onItemTapped(index);
        } else {
          onKonsultasi();
        }
      },
      selectedItemColor: BaseColors.success500,
      unselectedItemColor: BaseColors.neutral500,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage(
              'assets/images/icons/home_icon.png',
            ),
            color: bottomNavBarProvider.currentIndex == 0
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/images/icons/analytic_icon.png'),
            color: bottomNavBarProvider.currentIndex == 1
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Analytic',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/images/icons/control_icon.png'),
            color: bottomNavBarProvider.currentIndex == 3
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Control',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/images/icons/predic_icon.png'),
            color: bottomNavBarProvider.currentIndex == 3
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Predic',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/images/icons/profile_icon.png'),
            color: bottomNavBarProvider.currentIndex == 4
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
