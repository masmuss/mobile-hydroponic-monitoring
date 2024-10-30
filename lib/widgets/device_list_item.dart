import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';

class DeviceListItem extends StatelessWidget {
  final Device device;
  final VoidCallback onDelete;

  const DeviceListItem({
    super.key,
    required this.device,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: Text('ID: ${device.id}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/device-monitoring-detail',
          arguments: device.id,
        );
      },
    );
  }
}
