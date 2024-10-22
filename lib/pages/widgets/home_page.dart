import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/models/record.dart';

class Homepage extends StatefulWidget {
  final int deviceId;

  const Homepage({super.key, required this.deviceId});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DeviceService _deviceService = DeviceService();
  final ValueNotifier<List<Map<String, String>>> gridItemsNotifier =
  ValueNotifier<List<Map<String, String>>>([
    {
      'title': 'Humidity',
      'description': '63.0%',
      'image': 'assets/images/humidity.png',
    },
    {
      'title': 'pH',
      'description': '7.4',
      'image': 'assets/images/pH.png',
    },
    {
      'title': 'TDS 1',
      'description': '300.0ppm',
      'image': 'assets/images/tds1.png',
    },
    {
      'title': 'TDS 2',
      'description': '100.0ppm',
      'image': 'assets/images/tds2.png',
    },
  ]);

  void _updateGridItems(Record record) {
    gridItemsNotifier.value = [
      {
        'title': 'Humidity',
        'description': '${record.hum}%',
        'image': 'assets/images/humidity.png',
      },
      {
        'title': 'pH',
        'description': record.ph.toStringAsFixed(2),
        'image': 'assets/images/pH.png',
      },
      {
        'title': 'TDS 1',
        'description': '${record.tds.toStringAsFixed(1)} ppm',
        'image': 'assets/images/tds1.png',
      },
      {
        'title': 'TDS 2',
        'description': '0 ppm',
        'image': 'assets/images/tds2.png',
      },
    ];
  }

  @override
  void dispose() {
    gridItemsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: StreamBuilder<Record>(
          stream: _deviceService.getLatestRecordStream(widget.deviceId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              var record = snapshot.data!;
              _updateGridItems(record);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHealthOverview(),
                  _buildTemperatureCard(record),
                  _buildLastUpdated(record),
                  _buildPumpStatus(),
                  const SizedBox(height: 20),
                  _buildGridItems(),
                  const SizedBox(height: 30),
                ],
              );
            } else {
              return const Center(child: Text('Error loading data'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildHealthOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Overview',
          style: AppStyle.appTextStyles.title3!.copyWith(
            color: BaseColors.neutral950,
          ),
        ),
        Text(
          'Your daily health overview',
          style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
            color: BaseColors.neutral400,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTemperatureCard(Record record) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            color: BaseColors.success600,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NORMAL',
                  style: AppStyle.appTextStyles.smallNormalReguler!
                      .copyWith(color: BaseColors.neutral50),
                ),
                const SizedBox(height: 8),
                Text(
                  '${record.temp}°C',
                  style: AppStyle.appTextStyles.title4!.copyWith(
                    color: BaseColors.neutral50,
                  ),
                ),
                Text(
                  'Temperature warm',
                  style: AppStyle.appTextStyles.smallNormalReguler!
                      .copyWith(color: BaseColors.neutral50),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 20,
          child: Image.asset(
            'assets/images/Temperature.png',
            width: 100,
            height: 100,
          ),
        ),
      ],
    );
  }

  Widget _buildLastUpdated(Record record) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: BaseColors.neutral200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            FadeAnimatedText(
              'Last Updated: ${record.datetime}',
              textStyle: AppStyle.appTextStyles.largeNormalBold!.copyWith(
                color: BaseColors.neutral500,
              ),
              duration: const Duration(seconds: 2),
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
        ),
      ),
    );
  }

  Widget _buildPumpStatus() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Image.asset(
            'assets/images/pump.png',
            width: 60,
            height: 80,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/waterpump.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Water Pump',
                    style: AppStyle.appTextStyles.largeNoneMedium!.copyWith(
                      color: BaseColors.neutral400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.power,
                    size: 20,
                    color: BaseColors.neutral900,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Status: ON',
                    style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                      color: BaseColors.neutral900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridItems() {
    return ValueListenableBuilder<List<Map<String, String>>>(
      valueListenable: gridItemsNotifier,
      builder: (context, gridItems, _) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
            mainAxisExtent: 120,
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, index) {
            final item = gridItems[index];
            return _buildGridItem(item);
          },
        );
      },
    );
  }

  Widget _buildGridItem(Map<String, String> item) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: BaseColors.neutral100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['title']!,
                  style: TextStyle(
                    color: BaseColors.neutral600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item['description']!,
                  style: TextStyle(
                    color: BaseColors.neutral900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Image.asset(
              item['image']!,
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
