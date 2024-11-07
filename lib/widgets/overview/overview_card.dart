import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/widgets/overview/overview_details.dart';
import 'package:hydroponic/widgets/overview/overview_header.dart';

class OverviewCard extends StatelessWidget {
  final WeatherInfo weatherInfo;

  const OverviewCard({super.key, required this.weatherInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: BaseColors.gray700,
      ),
      child: Column(
        children: [
          OverviewHeader(date: weatherInfo.date, time: weatherInfo.time),
          OverviewDetails(
            waterTemperature: weatherInfo.waterTemperature,
            acidity: weatherInfo.acidity,
            tankTds: weatherInfo.tankTds,
            fieldTds: weatherInfo.fieldTds,
          ),
        ],
      ),
    );
  }
}

class WeatherInfo {
  final String date;
  final String time;
  final double waterTemperature;
  final double acidity;
  final double tankTds;
  final double fieldTds;

  WeatherInfo({
    required this.date,
    required this.time,
    required this.waterTemperature,
    required this.acidity,
    required this.tankTds,
    required this.fieldTds,
  });
}

