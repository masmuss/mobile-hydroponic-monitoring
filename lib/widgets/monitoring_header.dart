import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonitoringHeader extends StatelessWidget {
  const MonitoringHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<DateTime>(
              stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMEEEEd().format(snapshot.data!),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat.Hms().format(snapshot.data!),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
        const Icon(
          Icons.notifications_outlined,
          size: 32,
        ),
      ],
    );
  }
}
