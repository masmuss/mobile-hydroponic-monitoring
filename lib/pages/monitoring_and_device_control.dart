import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/views/device/device_control.dart';
import 'package:hydroponic/views/device/device_monitoring.dart';
import 'package:hydroponic/widgets/device_navigation_bar.dart';

class MonitoringAndDeviceControl extends StatefulWidget {
  final String deviceId;

  const MonitoringAndDeviceControl({super.key, required this.deviceId});

  @override
  State<MonitoringAndDeviceControl> createState() =>
      _MonitoringAndDeviceControlState();
}

class _MonitoringAndDeviceControlState
    extends State<MonitoringAndDeviceControl> {
  final DeviceService _deviceService = DeviceService();
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Monitoring & Control'),
      ),
      body: StreamBuilder<Device>(
        stream: _deviceService.getDeviceByIdStream(widget.deviceId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading device data'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No device data available'));
          }

          final device = snapshot.data!;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: IndexedStack(
                index: _selectedIndex,
                children: <Widget>[
                  DeviceMonitoring(device: device),
                  DeviceControl(device: device),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: DeviceNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
