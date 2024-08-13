import 'package:flutter/material.dart';
import 'package:hydroponic/models/ph_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PhLevelChart extends StatelessWidget {
  const PhLevelChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PhData> chartData = List.generate(24, (index) {
      double value = 7.0 + (index % 3) * 0.1;
      return PhData(index, value);
    });

    return SizedBox(
      height: 300,
      child: SfCartesianChart(
        title: const ChartTitle(text: 'Ph Level'),
        primaryXAxis: const DateTimeAxis(),
        series: <CartesianSeries>[
          LineSeries<PhData, DateTime>(
            width: 2.4,
            dataSource: chartData,
            xValueMapper: (PhData time, _) => DateTime(time.time),
            yValueMapper: (PhData value, _) => value.value,
          ),
        ],
      ),
    );
  }
}
