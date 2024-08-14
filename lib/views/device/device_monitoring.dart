import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/widgets/environment_status_card.dart';
import 'package:hydroponic/widgets/monitoring_header.dart';
import 'package:hydroponic/widgets/monitoring_info.dart';
import 'package:hydroponic/widgets/temperature_humidity_gauge.dart';

class DeviceMonitoring extends StatefulWidget {
  final String deviceId;

  const DeviceMonitoring({super.key, required this.deviceId});

  @override
  State<DeviceMonitoring> createState() => _DeviceMonitoringState();
}

class _DeviceMonitoringState extends State<DeviceMonitoring> {
  final DeviceService _deviceService = DeviceService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Device>(
          stream: _deviceService.getDeviceByIdStream(widget.deviceId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading device'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No device available'));
            } else {
              final device = snapshot.data!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const MonitoringHeader(),
                  const SizedBox(height: 20),
                  const EnvironmentStatusCard(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          MonitoringInfo(
                            humidity: device.records.hum,
                            temperature: device.records.temp,
                            ph: device.records.ph,
                            tds: device.records.tds,
                          ),
                          TemperatureHumidityGauge(
                            humidity: device.records.hum,
                            temperature: device.records.temp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }
      );
  }
}
