import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonitoringGraph extends StatefulWidget {
  final List<String> timestamp;
  final List<dynamic> data;
  final String title;
  final String axisTitle;

  const MonitoringGraph({
    super.key,
    required this.timestamp,
    required this.data,
    required this.title,
    required this.axisTitle,
  });

  @override
  State<MonitoringGraph> createState() => _MonitoringGraphState();
}

class _MonitoringGraphState extends State<MonitoringGraph> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: widget.timestamp.length * 60,
            height: 256,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: widget.axisTitle),
              ),
              series: <FastLineSeries<GraphData, String>>[
                FastLineSeries<GraphData, String>(
                  dataSource: [
                    for (int i = 0; i < widget.timestamp.length; i++)
                      GraphData(widget.timestamp[i], widget.data[i])
                  ],
                  xValueMapper: (GraphData graphData, _) => graphData.time,
                  yValueMapper: (GraphData graphData, _) => graphData.data,
                  markerSettings: MarkerSettings(
                      isVisible: true, shape: DataMarkerType.circle),
                  dataLabelSettings:
                      DataLabelSettings(isVisible: true, showZeroValue: false),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GraphData {
  GraphData(this.time, this.data);

  final String time;
  final dynamic data;
}
