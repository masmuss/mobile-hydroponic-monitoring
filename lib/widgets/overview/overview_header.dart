import 'package:flutter/material.dart';

class OverviewHeader extends StatelessWidget {
  final String date;
  final String time;

  const OverviewHeader({super.key, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: const TextStyle(color: Colors.white)),
          Text(time, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
