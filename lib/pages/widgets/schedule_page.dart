import 'package:flutter/material.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final Map<String, Map<String, String>> nutrientData = {
    'Pembibitan': {'status': 'Nutrisi AB Mix', 'ppm': ''},
    'Tumbuh Daun': {'status': 'Nutrisi AB Mix', 'ppm': ''},
    'Tumbuh Bunga': {'status': 'Nutrisi AB Mix', 'ppm': ''},
    'Tumbuh Buah': {'status': 'Nutrisi AB Mix', 'ppm': ''},
  };

  void _showInputDialog(String phase) {
    String? ppm = nutrientData[phase]?['ppm'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Nutrient for $phase'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                const InputDecoration(labelText: 'Nutrisi AB Mix (Status)'),
                controller: TextEditingController(text: 'Nutrisi AB Mix'),
                enabled: false,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration:
                const InputDecoration(labelText: 'Jumlah Nutrisi (PPM)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => ppm = value,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (ppm != null) {
                  setState(() {
                    nutrientData[phase]?['ppm'] = ppm!;
                  });
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
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
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPhaseBox(
              title: 'Pembibitan',
              subtitle: 'Minggu 1 (usia 7 hari)',
              phaseKey: 'Pembibitan',
              icon: Icons.spa,
              color: Colors.lightBlueAccent,
            ),
            const SizedBox(height: 20),
            _buildPhaseBox(
              title: 'Tumbuh Daun',
              subtitle: 'Minggu 2 (usia 14 hari)',
              phaseKey: 'Tumbuh Daun',
              icon: Icons.eco,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 20),
            _buildPhaseBox(
              title: 'Tumbuh Bunga',
              subtitle: 'Minggu 5 (usia 35 hari)',
              phaseKey: 'Tumbuh Bunga',
              icon: Icons.local_florist,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 20),
            _buildPhaseBox(
              title: 'Tumbuh Buah',
              subtitle: 'Minggu 6 (usia 45 hari)',
              phaseKey: 'Tumbuh Buah',
              icon: Icons.local_pizza,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseBox({
    required String title,
    required String subtitle,
    required String phaseKey,
    required IconData icon,
    required Color color,
  }) {
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
                    title,
                    style: AppStyle.appTextStyles.largeNoneRegular!.copyWith(
                      color: BaseColors.neutral950,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                      color: BaseColors.neutral400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (nutrientData[phaseKey]?['ppm']!.isNotEmpty ?? false)
                    Text(
                      'Status: ${nutrientData[phaseKey]?['status']!}, PPM: ${nutrientData[phaseKey]?['ppm']!}',
                      style:
                      AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                        color: BaseColors.neutral950,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.green, size: 32),
              onPressed: () => _showInputDialog(phaseKey),
            ),
          ],
        ),
      ),
    );
  }
}
