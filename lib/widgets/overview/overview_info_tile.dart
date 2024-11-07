import 'package:flutter/material.dart';

class OverviewInfoTile extends StatelessWidget {
  final String label;
  final String value;

  const OverviewInfoTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 4.0),
        Text(label,
            style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
