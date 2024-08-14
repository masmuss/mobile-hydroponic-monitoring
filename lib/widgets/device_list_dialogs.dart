import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/services/device_storage.dart';

Future<void> showAddDeviceDialog(
  BuildContext context,
  DeviceService deviceService,
  DeviceStorage deviceStorage,
  VoidCallback onDeviceAdded,
) async {
  final TextEditingController deviceIdController = TextEditingController();

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add a new device'),
        content: TextField(
          controller: deviceIdController,
          decoration: const InputDecoration(
            hintText: 'Device ID',
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Add Device'),
            onPressed: () async {
              final deviceId = deviceIdController.text;
              if (deviceId.isNotEmpty) {
                final exists = await deviceService.isDeviceIdExists(deviceId);
                if (exists) {
                  await deviceStorage.addDeviceId(deviceId);
                  deviceIdController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Device added successfully')),
                  );
                  Navigator.of(context).pop();
                  onDeviceAdded();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Device ID not found in Firebase')),
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showEditDeviceDialog(
  BuildContext context,
  DeviceService deviceService,
  Device device,
  VoidCallback onDeviceUpdated,
) async {
  final TextEditingController editController =
      TextEditingController(text: device.name);

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Device'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(
            hintText: 'Device Name',
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Save'),
            onPressed: () async {
              final newName = editController.text;
              if (newName.isNotEmpty) {
                // await deviceService.updateDeviceName(device.id, newName);
                Navigator.of(context).pop();
                onDeviceUpdated();
              }
            },
          ),
        ],
      );
    },
  );
}

Future<void> showDeleteDeviceDialog(
  BuildContext context,
  DeviceStorage deviceStorage,
  Device device,
  VoidCallback onDeviceDeleted,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Device'),
        content: Text('Are you sure you want to delete ${device.name}?'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Delete'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  );

  if (confirmed != null && confirmed) {
    await deviceStorage.removeDeviceId(device.id);
    onDeviceDeleted();
  }
}
