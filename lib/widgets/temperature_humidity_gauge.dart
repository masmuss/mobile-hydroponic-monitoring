import 'package:flutter/material.dart';
import 'package:hydroponic/widgets/gauge_container.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TemperatureHumidityGauge extends StatefulWidget {
  final int humidity;
  final double temperature;

  const TemperatureHumidityGauge({
    super.key,
    required this.humidity,
    required this.temperature,
  });

  @override
  State<TemperatureHumidityGauge> createState() => _TemperatureHumidityGaugeState();
}

class _TemperatureHumidityGaugeState extends State<TemperatureHumidityGauge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          GaugeContainer(
            label: 'Temp.°C',
            value: widget.temperature,
            ranges: [
              GaugeRange(startValue: 0, endValue: 25, color: Colors.green),
              GaugeRange(startValue: 25, endValue: 40, color: Colors.orange),
              GaugeRange(startValue: 40, endValue: 50, color: Colors.red),
            ],
          ),
          GaugeContainer(
            label: 'Humidity',
            value: widget.humidity.toDouble(),
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
