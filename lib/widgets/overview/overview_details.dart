import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/widgets/overview/overview_info_tile.dart';

class OverviewDetails extends StatelessWidget {
  final double waterTemperature;
  final double acidity;
  final double tankTds;
  final double fieldTds;

  const OverviewDetails({
    super.key,
    required this.waterTemperature,
    required this.acidity,
    required this.tankTds,
    required this.fieldTds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.water_drop, color: Colors.white),
              const SizedBox(width: 8.0),
              Text(
                'Water Temperature',
                style: const TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${waterTemperature.toStringAsFixed(1)} °C',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.thermostat,
                size: 64,
                color: BaseColors.gray100,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: BaseColors.success700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OverviewInfoTile(
                    label: 'Acidity (pH)',
                    value: acidity.toStringAsFixed(1)),
                OverviewInfoTile(
                    label: 'Tank TDS (ppm)',
                    value: tankTds.toStringAsFixed(0)),
                OverviewInfoTile(
                    label: 'Field TDS (ppm)',
                    value: fieldTds.toStringAsFixed(0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
