import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/widgets/environment_status_card.dart';
import 'package:hydroponic/widgets/monitoring_header.dart';
import 'package:hydroponic/widgets/monitoring_info.dart';
import 'package:hydroponic/widgets/temperature_humidity_gauge.dart';

class DeviceMonitoring extends StatefulWidget {
  final Device device;

  const DeviceMonitoring({super.key, required this.device});

  @override
  State<DeviceMonitoring> createState() => _DeviceMonitoringState();
}

class _DeviceMonitoringState extends State<DeviceMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const MonitoringHeader(),
        const SizedBox(height: 20),
        const EnvironmentStatusCard(),
        const SizedBox(height: 20),
        // Text('Last Updated: ${widget.device.records.datetime}'),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // MonitoringInfo(
                //   humidity: widget.device.records.hum,
                //   temperature: widget.device.records.temp,
                //   ph: widget.device.records.ph,
                //   tds1: widget.device.records.tds1,
                //   tds2: widget.device.records.tds2,
                // ),
                // TemperatureHumidityGauge(
                //   humidity: widget.device.records.hum,
                //   temperature: widget.device.records.temp,
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
