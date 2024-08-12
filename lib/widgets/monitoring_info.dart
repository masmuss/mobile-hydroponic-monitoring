import 'package:flutter/material.dart';
import 'package:hydroponic/widgets/info_row.dart';

class MonitoringInfo extends StatefulWidget {
  const MonitoringInfo({super.key});

  @override
  State<MonitoringInfo> createState() => _MonitoringInfoState();
}

class _MonitoringInfoState extends State<MonitoringInfo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(icon: Icons.opacity, label: 'pH level', value: '11.3'),
            InfoRow(icon: Icons.grain, label: 'Humidity percentage', value: '20%'),
            InfoRow(icon: Icons.thermostat, label: 'Real Temperature', value: '58°C'),
            InfoRow(icon: Icons.science, label: 'Total Dissolved Solids (TDS)', value: '1200 ppm'),
          ],
        ),
      ),
    );;
  }
}
