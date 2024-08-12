import 'package:flutter/material.dart';
import 'package:hydroponic/widgets/environment_status_card.dart';
import 'package:hydroponic/widgets/ph_level_chart.dart';
import 'package:hydroponic/widgets/temperature_humidity_gauge.dart';
import 'package:intl/intl.dart';

class DeviceMonitoringDetail extends StatefulWidget {
  final String deviceId;

  const DeviceMonitoringDetail({super.key, required this.deviceId});

  @override
  State<DeviceMonitoringDetail> createState() => _DeviceMonitoringDetailState();
}

class _DeviceMonitoringDetailState extends State<DeviceMonitoringDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device ${widget.deviceId}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              const EnvironmentStatusCard(),
              const SizedBox(height: 20),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TemperatureHumidityGauge(),
                      SizedBox(height: 20),
                      PhLevelChart(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMEEEEd().format(DateTime.now()),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.Hms().format(DateTime.now()),
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const Icon(
          Icons.notifications_outlined,
          size: 32,
        ),
      ],
    );
  }
}
