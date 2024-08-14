import 'package:flutter/material.dart';
import 'package:hydroponic/widgets/info_row.dart';

class MonitoringInfo extends StatefulWidget {
  final num humidity;
  final num ph;
  final num tds1;
  final num tds2;
  final num temperature;

  const MonitoringInfo({
    super.key,
    required this.humidity,
    required this.ph,
    required this.tds1,
    required this.tds2,
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
                value: widget.ph.toStringAsFixed(1)),
            InfoRow(
                icon: Icons.grain,
                label: 'Humidity percentage',
                value: "${widget.humidity.toStringAsFixed(1)}%"),
            InfoRow(
                icon: Icons.thermostat,
                label: 'Real Temperature',
                value: "${widget.temperature.toStringAsFixed(1)}°C"),
            InfoRow(
                icon: Icons.science,
                label: 'Total Dissolved Solids (TDS) 1',
                value: "${widget.tds1.ceilToDouble()} ppm"),
            InfoRow(
                icon: Icons.science,
                label: 'Total Dissolved Solids (TDS) 2',
                value: "${widget.tds2.ceilToDouble()} ppm"),
          ],
        ),
      ),
    );
  }
}
