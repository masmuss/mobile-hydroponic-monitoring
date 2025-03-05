import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/widgets/overview/overview_details.dart';
import 'package:hydroponic/widgets/overview/overview_header.dart';

class OverviewCard extends StatelessWidget {
  final SensorInfo sensorInfo;

  const OverviewCard({super.key, required this.sensorInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: BaseColors.gray700,
      ),
      child: Column(
        children: [
          OverviewHeader(date: sensorInfo.date, time: sensorInfo.time),
          OverviewDetails(sensorData: sensorInfo.sensorData),
        ],
      ),
    );
  }
}

class SensorInfo {
  final String date;
  final String time;
  final Map<String, num> sensorData;

  SensorInfo({
    required this.date,
    required this.time,
    required this.sensorData,
  });
}
