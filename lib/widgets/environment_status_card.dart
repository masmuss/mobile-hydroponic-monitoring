import 'package:flutter/material.dart';

class EnvironmentStatusCard extends StatelessWidget {
  const EnvironmentStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Normal',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text('Kondisi lingkungan tidak terdeteksi adanya gangguan'),
        ],
      ),
    );
  }
}
