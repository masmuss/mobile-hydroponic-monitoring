import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/widgets/environment_status_card.dart';
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
  final DeviceService _deviceService = DeviceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device ${widget.deviceId}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder<Device>(
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
                      MonitoringHeader(),
                      const SizedBox(height: 20),
                      EnvironmentStatusCard(),
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
          )
        ),
      ),
    );
  }
}
