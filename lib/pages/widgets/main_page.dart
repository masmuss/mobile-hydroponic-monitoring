import 'package:flutter/material.dart';
import 'package:hydroponic/pages/component/custom_buttonbar.dart';
import 'package:hydroponic/pages/widgets/analytic_page.dart';
import 'package:hydroponic/pages/widgets/control_page.dart';
import 'package:hydroponic/pages/widgets/home_page.dart';
import 'package:hydroponic/pages/widgets/predict_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _selectedIndex = 0;

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

  final ScrollController scrollController = ScrollController();

  final pages = [
    const Homepage(),
    const AnalyticPage(),
    const PredictPage(),
    ControlPage(scrollController: ScrollController()),
    const AnalyticPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
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
          // Panggil ControlPage sebagai BottomSheet
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
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
        },
      ),
    );
  }
}
