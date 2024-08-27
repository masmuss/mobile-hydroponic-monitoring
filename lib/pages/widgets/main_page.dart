import 'package:flutter/material.dart';
import 'package:hydroponic_app/pages/component/custom_buttonbar.dart';
import 'package:hydroponic_app/pages/widgets/analytic_page.dart';
import 'package:hydroponic_app/pages/widgets/control_page.dart';
import 'package:hydroponic_app/pages/widgets/home_page.dart';
import 'package:hydroponic_app/pages/widgets/predict_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _selectedIndex = 0; // Inisialisasi _selectedIndex

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  final pages = [
    const Homepage(),
    const AnalyticPage(),
    const ControlPage(),
    const PredictPage(),
    const AnalyticPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ControlPage(),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/images/icons/control_icon.png',
            width: 75,
            height: 75,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onKonsultasi: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ControlPage(),
            ),
          );
        },
      ),
    );
  }
}
