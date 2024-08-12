import 'package:flutter/material.dart';
import 'package:hydroponic/widgets/gauge_container.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureHumidityGauge extends StatelessWidget {
  const TemperatureHumidityGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          GaugeContainer(
            label: 'Temp.°C',
            value: 22.5,
            ranges: [
              GaugeRange(startValue: 0, endValue: 25, color: Colors.green),
              GaugeRange(startValue: 25, endValue: 40, color: Colors.orange),
              GaugeRange(startValue: 40, endValue: 50, color: Colors.red),
            ],
          ),
          GaugeContainer(
            label: 'Humidity',
            value: 27.5,
            ranges: [
              GaugeRange(startValue: 0, endValue: 25, color: Colors.green),
              GaugeRange(startValue: 25, endValue: 40, color: Colors.orange),
              GaugeRange(startValue: 40, endValue: 50, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }
}
