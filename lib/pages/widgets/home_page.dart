// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:hydroponic/models/logs.dart';
// import 'package:hydroponic/pages/common/colors.dart';
// import 'package:hydroponic/pages/common/styles.dart';
// import 'package:hydroponic/services/device_service.dart';
// import 'package:hydroponic/models/record.dart';
// import 'package:hydroponic/widgets/overview/overview_card.dart';
// import 'package:intl/intl.dart';

// class Homepage extends StatefulWidget {
//   final int deviceId;

//   const Homepage({super.key, required this.deviceId});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final DeviceService _deviceService = DeviceService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: StreamBuilder<Record>(
//           stream: _deviceService.getLatestRecordStream(widget.deviceId),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               log(snapshot.error.toString());
//               return const Center(child: Text('Error loading data'));
//             } else if (snapshot.hasData) {
//               return _buildContent(snapshot.data!);
//             }
//             return const Center(child: Text('No data available'));
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildContent(Record record) {
//     String formattedDate =
//         DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildOverviewCard(record, formattedDate),
//         _buildLastUpdated(record),
//       ],
//     );
//   }

//   Widget _buildOverviewCard(Record record, String formattedDate) {
//     return StreamBuilder<DateTime>(
//       stream:
//           Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
//       builder: (context, timeSnapshot) {
//         String formattedTime = timeSnapshot.hasData
//             ? DateFormat('hh:mm a').format(timeSnapshot.data!)
//             : 'Loading...';

//         return OverviewCard(
//           sensorInfo: SensorInfo(
//               date: formattedDate,
//               time: formattedTime,
//               sensorData: record.sensorData),
//         );
//       },
//     );
//   }

//   Widget _buildLastUpdated(Record record) {
//     final DateTime lastUpdated = DateTime.parse(record.datetime);

//     return Container(
//       height: 50,
//       margin: const EdgeInsets.only(top: 20),
//       decoration: BoxDecoration(
//         color: BaseColors.neutral200,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Center(
//         child: Text(
//           'Last Updated: ${lastUpdated.day}/${lastUpdated.month}/${lastUpdated.year} ${lastUpdated.hour}:${lastUpdated.minute} ${lastUpdated.timeZoneName}',
//           style: AppStyle.appTextStyles.largeNormalBold!.copyWith(
//             color: BaseColors.neutral500,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogsSection(List<Log> logs) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'History Logs',
//           style: AppStyle.appTextStyles.title3!.copyWith(
//             color: BaseColors.neutral950,
//           ),
//         ),
//         const SizedBox(height: 10),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: logs.length,
//           itemBuilder: (context, index) {
//             final log = logs[index];
//             final DateTime logDateTime = DateTime.parse(log.datetime);
//             return Container(
//               margin: const EdgeInsets.only(bottom: 10),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: BaseColors.neutral100,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         DateFormat('dd MMM yyyy, hh:mm a').format(logDateTime),
//                         style: AppStyle.appTextStyles.smallNormalBold!.copyWith(
//                           color: BaseColors.neutral900,
//                         ),
//                       ),
//                       Text(
//                         'Nutrient: ${log.nutrient}',
//                         style: AppStyle.appTextStyles.xSmallNormalReguler!
//                             .copyWith(
//                           color: BaseColors.neutral700,
//                         ),
//                       ),
//                       Text(
//                         'Category: ${log.outputCategory}',
//                         style: AppStyle.appTextStyles.xSmallNormalReguler!
//                             .copyWith(
//                           color: BaseColors.neutral700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydroponic/models/logs.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/models/record.dart';
import 'package:hydroponic/services/fuzzy.dart';
import 'package:hydroponic/widgets/overview/overview_card.dart';
import 'package:intl/intl.dart';

class Homepage extends StatefulWidget {
  final int deviceId;

  const Homepage({super.key, required this.deviceId});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final DeviceService _deviceService = DeviceService();
<<<<<<< HEAD
  DateTime? _selectedDate; // Tanggal yang dipilih untuk filter
  List<Log> _allLogs = []; // Menyimpan semua logs untuk filtering
  DateTime? _lastUpdateTime; // Tambahan untuk melacak waktu terakhir pembaruan

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(2025, 5, 30); // Tanggal default
    _lastUpdateTime = DateTime.now(); // Inisialisasi waktu terakhir
    log('Homepage initialized with deviceId: ${widget.deviceId}');
  }

  // Fungsi untuk memilih tanggal
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
=======
  final FuzzyService _fuzzyService = FuzzyService();
>>>>>>> d5e654ff8d4d5a96be5149c84b75e724e2fb4fa0

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: StreamBuilder<Record>(
          stream: _deviceService.getLatestRecordStream(widget.deviceId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
              return const Center(child: Text('Error loading data'));
            } else if (snapshot.hasData) {
              return _buildContent(snapshot.data!);
            }
            return const Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Widget _buildContent(Record record) {
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.deviceId.toString() == "7452706212")
          _buildFuzzyResult(record),
        _buildOverviewCard(record, formattedDate),
        _buildLastUpdated(record),
        const SizedBox(height: 20),
        // Tambahkan bagian logs dengan filter tanggal
        _buildLogsWithFilter(),
      ],
    );
  }

  Widget _buildFuzzyResult(Record record) {
    // Ambil nilai sensor terbaru
    final num tds = record.sensorData["tank_tds"]!;
    final num ph = record.sensorData["ph"]!;
    final num temp = record.sensorData["water_temp"]!;

    // Jalankan fuzzy logic
    final fuzzyResult = _fuzzyService.analyzeEnvironment(tds, ph, temp);

    // Ambil status dan sensor tidak normal
    final String status = fuzzyResult["status"];
    final List<Map<String, String>> abnormalSensors =
        fuzzyResult["abnormal_sensors"];

    // Tentukan warna dan ikon berdasarkan status
    final Color bgColor =
        status == "Normal" ? BaseColors.success500 : BaseColors.danger500;
    final IconData icon =
        status == "Normal" ? Icons.check_circle : Icons.warning;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status == "Normal"
                      ? "Lingkungan Normal"
                      : "Lingkungan Tidak Normal",
                  style: AppStyle.appTextStyles.largeNormalBold!
                      .copyWith(color: Colors.white),
                ),
                if (status != "Normal") ...[
                  const SizedBox(height: 2.0),
                  ...abnormalSensors.map((sensor) {
                    return Text(
                      "- ${sensor['sensor']} (${sensor['status']})",
                      style: AppStyle.appTextStyles.smallNormalReguler!
                          .copyWith(color: Colors.white),
                    );
                  }),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(Record record, String formattedDate) {
    return StreamBuilder<DateTime>(
      stream:
          Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, timeSnapshot) {
        String formattedTime = timeSnapshot.hasData
            ? DateFormat('hh:mm a').format(timeSnapshot.data!)
            : 'Loading...';

        return OverviewCard(
          sensorInfo: SensorInfo(
              date: formattedDate,
              time: formattedTime,
              sensorData: record.sensorData),
        );
      },
    );
  }

  Widget _buildLastUpdated(Record record) {
    final DateTime lastUpdated = DateTime.parse(record.datetime);

    // Format waktu dengan leading zero untuk menit
    final String formattedTime =
        '${lastUpdated.hour}:${lastUpdated.minute.toString().padLeft(2, '0')}';

    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: BaseColors.neutral200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          'Last Updated: ${lastUpdated.day}/${lastUpdated.month}/${lastUpdated.year} $formattedTime WIB',
          style: AppStyle.appTextStyles.largeNormalBold!.copyWith(
            color: BaseColors.neutral500,
          ),
        ),
      ),
    );
  }

  // Bagian baru untuk logs dengan filter tanggal
  Widget _buildLogsWithFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0), // Tambahkan padding di sekitar teks
              child: Text(
                'History Activity',
                style: AppStyle.appTextStyles.largeNormalBold!.copyWith(
                  color: BaseColors.neutral950,
                ),
              ),
            ),
            TextButton(
              onPressed: () => _pickDate(context),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                _selectedDate != null
                    ? DateFormat('dd MMM yyyy').format(_selectedDate!)
                    : 'Select Date',
                style: AppStyle.appTextStyles.xSmallNormalReguler!.copyWith(
                  color: BaseColors.neutral700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        StreamBuilder<List<Log>>(
          stream:
              _deviceService.getLogsStream(widget.deviceId).cast<List<Log>>(),
          builder: (context, snapshot) {
            log('Logs StreamBuilder state: ${snapshot.connectionState}');
            log('Logs StreamBuilder hasData: ${snapshot.hasData}');
            if (snapshot.hasData) {
              log('Logs StreamBuilder data length: ${snapshot.data!.length}');
              log('Logs StreamBuilder data: ${snapshot.data}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              log('Error loading logs: ${snapshot.error}');
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(child: Text('Error loading logs')),
              );
            } else if (snapshot.hasData) {
              final currentTime = DateTime.now();
              if (_lastUpdateTime == null ||
                  currentTime.difference(_lastUpdateTime!).inSeconds >= 5) {
                _allLogs = snapshot.data!;
                _lastUpdateTime = currentTime; // Perbarui waktu terakhir
              }
              // Filter logs berdasarkan tanggal yang dipilih
              final filteredLogs = _allLogs.where((log) {
                try {
                  if (_selectedDate == null) return true;
                  final logDate = DateTime.parse(log.datetime);
                  return logDate.year == _selectedDate!.year &&
                      logDate.month == _selectedDate!.month &&
                      logDate.day == _selectedDate!.day;
                } catch (e) {
                  log;
                  return false;
                }
              }).toList();
              if (filteredLogs.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(child: Text('No logs for selected date')),
                );
              }
              return _buildLogsSection(filteredLogs);
            }
            log('No logs available for device ${widget.deviceId}');
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(child: Text('No logs available')),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLogsSection(List<Log> logs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            final DateTime logDateTime = DateTime.parse(log.datetime);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: BaseColors.neutral100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy, hh:mm a').format(logDateTime),
                        style: AppStyle.appTextStyles.smallNormalBold!.copyWith(
                          color: BaseColors.neutral900,
                        ),
                      ),
                      Text(
                        'Nutrient: ${log.nutrient}',
                        style: AppStyle.appTextStyles.xSmallNormalReguler!
                            .copyWith(
                          color: BaseColors.neutral700,
                        ),
                      ),
                      Text(
                        'Category: ${log.outputCategory}',
                        style: AppStyle.appTextStyles.xSmallNormalReguler!
                            .copyWith(
                          color: BaseColors.neutral700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
