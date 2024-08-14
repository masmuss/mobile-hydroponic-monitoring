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
  Map<String, bool> _relayStates = {
    'relay1': false,
    'relay2': false,
    'relay3': false,
    'relay4': false,
    'relay5': false,
  };

  @override
  void initState() {
    super.initState();
    _loadRelayStates();
  }

  Future<void> _loadRelayStates() async {
    try {
      final config = await _deviceService.getDeviceConfig(widget.device.id);
      if (config != null) {
        setState(() {
          _relayStates = {
            'relay1': config['relay1'] ?? false,
            'relay2': config['relay2'] ?? false,
            'relay3': config['relay3'] ?? false,
            'relay4': config['relay4'] ?? false,
            'relay5': config['relay5'] ?? false,
          };
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load relay states: $error')),
      );
    }
  }

  Future<void> _toggleRelay(String relayKey, bool value) async {
    try {
      await _deviceService.updateRelayConfig(widget.device.id, relayKey, value);
      setState(() {
        _relayStates[relayKey] = value;
      });

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
    return Column(
      children: _relayStates.keys.map((relayKey) {
        return ListTile(
          title: Text(
              "${relayKey.substring(0, 5).toUpperCase()} ${relayKey.substring(5)}"),
          trailing: Switch(
            value: _relayStates[relayKey]!,
            onChanged: (bool value) {
              _toggleRelay(relayKey, value);
            },
          ),
        );
      }).toList(),
    );
  }
}
