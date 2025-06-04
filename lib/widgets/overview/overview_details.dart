import 'package:flutter/material.dart';

class OverviewDetails extends StatelessWidget {
  final Map<String, num> sensorData;

  const OverviewDetails({
    super.key,
    required this.sensorData,
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
          // Header Overview
          Row(
            children: [
              const Icon(Icons.sensors, color: Colors.white),
              const SizedBox(width: 8.0),
              const Text(
                'Sensor Data',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sensorData.length,
            itemBuilder: (context, index) {
              final sensorKey = sensorData.keys.elementAt(index);
              final sensorValue = sensorData[sensorKey];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        sensorKey.replaceAll('_', ' '),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        sensorValue!.toStringAsFixed(1),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
