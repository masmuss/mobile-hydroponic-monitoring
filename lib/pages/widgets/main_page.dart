import 'package:flutter/material.dart';
import 'package:hydroponic/pages/component/custom_buttonbar.dart';
import 'package:hydroponic/pages/widgets/analytic_page.dart';
import 'package:hydroponic/pages/widgets/control_page.dart';
import 'package:hydroponic/pages/widgets/home_page.dart';
import 'package:hydroponic/pages/widgets/predict_page.dart';
import 'package:hydroponic/pages/widgets/schedule_page.dart';

class MainPage extends StatefulWidget {
  final int deviceId;

  const MainPage({super.key, required this.deviceId});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final controller = PageController();

  @override
  void initState() {
    super.initState();
    pages = [
      Homepage(deviceId: widget.deviceId),
      AnalyticPage(deviceId: widget.deviceId),
      ControlPage(
          scrollController: ScrollController(), deviceId: widget.deviceId),
      const PredictPage(),
      SchedulePage(deviceId: widget.deviceId),
    ];
  }

  final ScrollController scrollController = ScrollController();

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
                  return ControlPage(
                      scrollController: scrollController,
                      deviceId: widget.deviceId);
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
        deviceId: widget.deviceId,
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onKonsultasi: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return ControlPage(
                      scrollController: scrollController,
                      deviceId: widget.deviceId);
                },
              );
            },
          );
        },
      ),
    );
  }
}
