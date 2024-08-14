import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/services/device_service.dart';

class DeviceControl extends StatefulWidget {
  final Device device;

  const DeviceControl({super.key, required this.device});

  @override
  State<DeviceControl> createState() => _DeviceControlState();
}

class _DeviceControlState extends State<DeviceControl> {
  final DeviceService _deviceService = DeviceService();

  Future<void> _toggleRelay(String relayKey, bool value) async {
    try {
      await _deviceService.updateRelayConfig(widget.device.id, relayKey, value);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                "${relayKey.substring(0, 5).toUpperCase()} ${relayKey.substring(5)} is turned ${value ? 'on' : 'off'}")),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update $relayKey: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, bool>>(
      stream: _deviceService.getDeviceConfigStream(widget.device.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading relay states: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No relay states available'));
        }

        final Map<String, bool> relayStates = snapshot.data!;

        log(relayStates.keys.toString());

        return Column(
          children: relayStates.keys.map((relayKey) {
            return ListTile(
              title: Text(
                  "${relayKey.substring(0, 5).toUpperCase()} ${relayKey.substring(5)}"),
              trailing: Switch(
                value: relayStates[relayKey]!,
                onChanged: (bool value) {
                  _toggleRelay(relayKey, value);
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
