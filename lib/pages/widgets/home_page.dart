import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/models/record.dart';
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
        _buildOverviewCard(record, formattedDate),
        _buildLastUpdated(record),
      ],
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
