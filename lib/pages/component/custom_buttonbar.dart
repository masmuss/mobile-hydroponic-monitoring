import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/widgets/control_page.dart';

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
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index == 2) {
          // Tampilkan ControlPage sebagai BottomSheet ketika tombol Control ditekan
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // Agar BottomSheet bisa penuh
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return ControlPage(scrollController: scrollController);
                },
              );
            },
          );
        } else {
          onItemTapped(index);
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
            color: selectedIndex == 0
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/images/icons/analytic_icon.png'),
            color: selectedIndex == 1
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Analytic',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/images/icons/control_icon.png'),
            color: selectedIndex == 2
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Control',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            const AssetImage('assets/images/icons/predic_icon.png'),
            color: selectedIndex == 3
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Predict',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.schedule,
            color: selectedIndex == 4
                ? BaseColors.success500
                : BaseColors.neutral500,
            size: 24,
          ),
          label: 'Schedule',
        ),
      ],
    );
  }
}
