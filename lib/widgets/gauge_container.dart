import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeContainer extends StatelessWidget {
  final String label;
  final double value;
  final List<GaugeRange> ranges;

  const GaugeContainer({
    super.key,
    required this.label,
    required this.value,
    required this.ranges,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 200,
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              canScaleToFit: true,
              showLastLabel: true,
              minimum: 0,
              maximum: ranges.last.endValue,
              interval: ranges.last.endValue / 5,
              startAngle: 180,
              endAngle: 360,
              ranges: ranges,
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: value,
                  needleEndWidth: 2,
                  needleLength: 1,
                  enableAnimation: true,
                  knobStyle: const KnobStyle(
                    knobRadius: 8,
                    sizeUnit: GaugeSizeUnit.logicalPixel,
                  ),
                  tailStyle: const TailStyle(
                    width: 2,
                    lengthUnit: GaugeSizeUnit.logicalPixel,
                    length: 16,
                  ),
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.35,
                  widget: Text(label, style: const TextStyle(fontSize: 10)),
                ),
                GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.8,
                  widget: Text(
                    '  $value  ',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
