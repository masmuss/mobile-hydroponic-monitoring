import 'package:flutter/material.dart';

class DeviceControl extends StatefulWidget {
  const DeviceControl({super.key});

  @override
  State<DeviceControl> createState() => _DeviceControlState();
}

class _DeviceControlState extends State<DeviceControl> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Relay 1'),
          trailing: Switch(
            value: false,
            onChanged: (bool value) {},
          ),
        ),
        ListTile(
          title: const Text('Relay 2'),
          trailing: Switch(
            value: false,
            onChanged: (bool value) {},
          ),
        ),
        ListTile(
          title: const Text('Relay 3'),
          trailing: Switch(
            value: false,
            onChanged: (bool value) {},
          ),
        ),
        ListTile(
          title: const Text('Relay 4'),
          trailing: Switch(
            value: false,
            onChanged: (bool value) {},
          ),
        ),
        ListTile(
          title: const Text('Relay 5'),
          trailing: Switch(
            value: false,
            onChanged: (bool value) {},
          ),
        ),
      ],
    );
  }
}
