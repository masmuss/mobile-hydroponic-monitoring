import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/models/record.dart';
import 'package:hydroponic/services/fuzzy.dart';
import 'package:hydroponic/widgets/overview/overview_card.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  final int deviceId;

  const Homepage({super.key, required this.deviceId});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DeviceService _deviceService = DeviceService();
  final FuzzyService _fuzzyService = FuzzyService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: StreamBuilder<Record>(
          stream: _deviceService.getLatestRecordStream(widget.deviceId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return const Center(child: Text('Error loading data'));
            } else if (snapshot.hasData) {
              return _buildContent(snapshot.data!);
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Widget _buildContent(Record record) {
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.deviceId.toString() == "7452706212")
          _buildFuzzyResult(record),
        _buildOverviewCard(record, formattedDate),
        _buildLastUpdated(record),
      ],
    );
  }

  Widget _buildFuzzyResult(Record record) {
    // Ambil nilai sensor terbaru
    final num tds = record.sensorData["tank_tds"]!;
    final num ph = record.sensorData["ph"]!;
    final num temp = record.sensorData["water_temp"]!;

    // Jalankan fuzzy logic
    final fuzzyResult = _fuzzyService.analyzeEnvironment(tds, ph, temp);

    // Ambil status dan sensor tidak normal
    final String status = fuzzyResult["status"];
    final List<Map<String, String>> abnormalSensors =
        fuzzyResult["abnormal_sensors"];

    if (status == "Tidak Normal") {
      String sensorList = abnormalSensors
          .map((sensor) => "${sensor['sensor']} (${sensor['status']})")
          .join(", ");
    }

    // Tentukan warna dan ikon berdasarkan status
    final Color bgColor =
        status == "Normal" ? BaseColors.success500 : BaseColors.danger500;
    final IconData icon =
        status == "Normal" ? Icons.check_circle : Icons.warning;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status == "Normal"
                      ? "Lingkungan Normal"
                      : "Lingkungan Tidak Normal",
                  style: AppStyle.appTextStyles.largeNormalBold!
                      .copyWith(color: Colors.white),
                ),
                if (status != "Normal") ...[
                  const SizedBox(height: 2.0),
                  ...abnormalSensors.map((sensor) {
                    return Text(
                      "- ${sensor['sensor']} (${sensor['status']})",
                      style: AppStyle.appTextStyles.smallNormalReguler!
                          .copyWith(color: Colors.white),
                    );
                  }),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(Record record, String formattedDate) {
    return StreamBuilder<DateTime>(
      stream:
          Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, timeSnapshot) {
        String formattedTime = timeSnapshot.hasData
            ? DateFormat('hh:mm a').format(timeSnapshot.data!)
            : 'Loading...';

        return OverviewCard(
          sensorInfo: SensorInfo(
              date: formattedDate,
              time: formattedTime,
              sensorData: record.sensorData),
        );
      },
    );
  }

  Widget _buildLastUpdated(Record record) {
    final DateTime lastUpdated = DateTime.parse(record.datetime);

    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: BaseColors.neutral200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Last Updated: ${lastUpdated.day}/${lastUpdated.month}/${lastUpdated.year} ${lastUpdated.hour}:${lastUpdated.minute} ${lastUpdated.timeZoneName}',
          style: AppStyle.appTextStyles.largeNormalBold!.copyWith(
            color: BaseColors.neutral500,
          ),
        ),
      ),
    );
  }
}
