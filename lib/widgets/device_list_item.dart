import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/pages/common/colors.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/device-monitoring-detail',
          arguments: device.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: BaseColors.success600.withAlpha(90),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              device.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              device.target,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
