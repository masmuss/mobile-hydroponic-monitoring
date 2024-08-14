import 'package:flutter/material.dart';
import 'package:hydroponic/widgets/info_row.dart';

class MonitoringInfo extends StatefulWidget {
  final num humidity;
  final num ph;
  final num tds;
  final num temperature;

  const MonitoringInfo({
    super.key,
    required this.humidity,
    required this.ph,
    required this.tds,
    required this.temperature,
  });

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(
                icon: Icons.opacity,
                label: 'pH level',
                value: widget.ph.toString()),
            InfoRow(
                icon: Icons.grain,
                label: 'Humidity percentage',
                value: "${widget.humidity}%"),
            InfoRow(
                icon: Icons.thermostat,
                label: 'Real Temperature',
                value: "${widget.temperature}°C"),
            InfoRow(
                icon: Icons.science,
                label: 'Total Dissolved Solids (TDS)',
                value: "${widget.tds} ppm"),
          ],
        ),
      ),
    );
  }
}
