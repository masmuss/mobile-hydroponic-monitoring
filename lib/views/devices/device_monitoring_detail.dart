import 'package:flutter/material.dart';
import 'package:hydroponic/widgets/environment_status_card.dart';
import 'package:hydroponic/widgets/info_row.dart';
import 'package:hydroponic/widgets/monitoring_header.dart';
import 'package:hydroponic/widgets/monitoring_info.dart';
import 'package:hydroponic/widgets/temperature_humidity_gauge.dart';

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
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MonitoringHeader(),
              SizedBox(height: 20),
              EnvironmentStatusCard(),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MonitoringInfo(),
                      TemperatureHumidityGauge(),
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
}
