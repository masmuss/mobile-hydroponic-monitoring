import 'package:flutter/material.dart';
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
        title: Text('Device ${widget.deviceId}'),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: IndexedStack(
              index: _selectedIndex,
              children: <Widget>[
                DeviceMonitoring(deviceId: widget.deviceId),
                DeviceControl(deviceId: widget.deviceId)
              ],
            )),
      ),
      bottomNavigationBar: DeviceNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}
