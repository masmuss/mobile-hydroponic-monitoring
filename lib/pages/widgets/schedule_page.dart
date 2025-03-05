import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydroponic/models/nutrient.dart';
import 'package:hydroponic/models/schedule.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/services/device_service.dart';

class SchedulePage extends StatefulWidget {
  final int deviceId;

  const SchedulePage({super.key, required this.deviceId});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final DeviceService _deviceService = DeviceService();

  final Map<String, Nutrient> nutrientData = {
    'Pembibitan': Nutrient(key: 'week_1', ml: 0),
    'Tumbuh Daun': Nutrient(key: 'week_2', ml: 0),
    'Tumbuh Bunga': Nutrient(key: 'week_5', ml: 0),
    'Tumbuh Buah': Nutrient(key: 'week_6', ml: 0),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _AppBarTitle(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: StreamBuilder<Schedule>(
          stream: _deviceService.getDeviceScheduleStream(widget.deviceId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _updateNutrientData(snapshot.data!);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: nutrientData.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PhaseBox(
                    phase: entry.key,
                    nutrient: entry.value,
                    onEdit: (ml) => _setNutrientAmount(
                        widget.deviceId, entry.key, entry.value.key, ml),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  void _updateNutrientData(Schedule schedule) {
    nutrientData['Pembibitan'] =
        Nutrient(key: nutrientData['Pembibitan']!.key, ml: schedule.week1);
    nutrientData['Tumbuh Daun'] =
        Nutrient(key: nutrientData['Tumbuh Daun']!.key, ml: schedule.week2);
    nutrientData['Tumbuh Bunga'] =
        Nutrient(key: nutrientData['Tumbuh Bunga']!.key, ml: schedule.week5);
    nutrientData['Tumbuh Buah'] =
        Nutrient(key: nutrientData['Tumbuh Buah']!.key, ml: schedule.week6);
  }

  void _setNutrientAmount(int deviceId, String phase, String key, num value) {
    showDialog(
      context: context,
      builder: (context) {
        num? ppm = nutrientData[phase]?.ml;

        return AlertDialog(
          title: Text('Set Nutrient for $phase'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Set AB nutrient for the phase in ml'),
              const SizedBox(height: 16),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Jumlah Nutrisi (ml)'),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: TextEditingController(text: value.toString()),
                onChanged: (input) => ppm = num.tryParse(input),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (ppm != null) {
                  setState(() {
                    _deviceService.setDeviceSchedule(
                        deviceId, key, ppm!.toDouble());
                  });
                  Navigator.of(context).pop();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutrient Schedule',
          style: AppStyle.appTextStyles.title3!.copyWith(
            color: BaseColors.neutral950,
          ),
        ),
        Text(
          'Set your nutrient schedule',
          style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
            color: BaseColors.neutral400,
          ),
        ),
      ],
    );
  }
}

class PhaseBox extends StatelessWidget {
  final String phase;
  final Nutrient nutrient;
  final Function(num) onEdit;

  const PhaseBox({
    super.key,
    required this.phase,
    required this.nutrient,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (phase) {
      case 'Pembibitan':
        icon = Icons.spa;
        color = Colors.lightBlueAccent;
        break;
      case 'Tumbuh Daun':
        icon = Icons.eco;
        color = Colors.greenAccent;
        break;
      case 'Tumbuh Bunga':
        icon = Icons.local_florist;
        color = Colors.orangeAccent;
        break;
      case 'Tumbuh Buah':
        icon = Icons.local_pizza;
        color = Colors.redAccent;
        break;
      default:
        icon = Icons.help;
        color = Colors.grey;
    }

    return Card(
      color: BaseColors.neutral100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phase,
                    style: AppStyle.appTextStyles.largeNoneRegular!.copyWith(
                      color: BaseColors.neutral950,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getSubtitle(phase),
                    style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                      color: BaseColors.neutral400,
                    ),
                  ),
                  if (nutrient.ml > 0)
                    Text(
                      'The AB mix solution will be set to ${nutrient.ml} ml',
                      style:
                          AppStyle.appTextStyles.xSmallNormalReguler!.copyWith(
                        color: BaseColors.neutral950,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green, size: 32),
              onPressed: () => onEdit(nutrient.ml),
            ),
          ],
        ),
      ),
    );
  }

  String _getSubtitle(String phase) {
    switch (phase) {
      case 'Pembibitan':
        return 'Minggu 1 (usia 7 hari)';
      case 'Tumbuh Daun':
        return 'Minggu 2 (usia 14 hari)';
      case 'Tumbuh Bunga':
        return 'Minggu 5 (usia 35 hari)';
      case 'Tumbuh Buah':
        return 'Minggu 6 (usia 45 hari)';
      default:
        return 'Unknown phase';
    }
  }
}
