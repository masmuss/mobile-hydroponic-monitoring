import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/models/record.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/common/styles.dart';
import 'package:hydroponic/pages/component/monitoring_graph.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:intl/intl.dart';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

class AnalyticPage extends StatefulWidget {
  final int deviceId;

  const AnalyticPage({super.key, required this.deviceId});

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  String selectedMonth = 'July';
  final DeviceService _deviceService = DeviceService();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;

  String getTodayDateString() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }

  List<dynamic> filterRecordsByDate(dynamic records, String date) {
    var filteredRecords = records.where((record) {
      return record['datetime'].toString().contains(date);
    }).toList();

    return filteredRecords;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: StreamBuilder(
            stream: _deviceService.getDeviceByIdStream(widget.deviceId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              }

              final device = snapshot.data as Device;
              final data =
                  filterRecordsByDate(device.records, getTodayDateString());


              final time = data.map((record) {
                return record['datetime']
                    .toString()
                    .split(' ')[1]
                    .substring(0, 5);
              }).toList();

              final waterTemperature = data.map((record) {
                if (record['water_temp'] == null) {
                  return 0;
                }
                return num.parse(record['water_temp'].toStringAsFixed(1));
              }).toList();

              final ph = data.map((record) {
                if (record['ph'] == null) {
                  return 0;
                }
                return num.parse(record['ph'].toStringAsFixed(1));
              }).toList();

              final fieldTds = data.map((record) {
                if (record['field_tds'] == null) {
                  return 0;
                }
                return record['field_tds'].floor();
              }).toList();

              final tankTds = data.map((record) {
                if (record['tank_tds'] == null) {
                  return 0;
                }
                return record['tank_tds'].floor();
              }).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Graphic History',
                        style: AppStyle.appTextStyles.title3!.copyWith(
                          color: BaseColors.neutral950,
                        ),
                      ),
                      Text(
                        'See melon health statistics',
                        style:
                            AppStyle.appTextStyles.smallNormalReguler!.copyWith(
                          color: BaseColors.neutral400,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 30),
                  Row(
                    children: [
                      // Text(
                      //   'Step',
                      //   style: AppStyle.appTextStyles.largeNoneMedium!.copyWith(
                      //     color: BaseColors.neutral600,
                      //   ),
                      // ),
                      // const Spacer(),
                      // CompositedTransformTarget(
                      //   link: _layerLink,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       _toggleDropdown();
                      //     },
                      //     child: Container(
                      //       width: 150,
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 16, vertical: 8),
                      //       decoration: BoxDecoration(
                      //         color: BaseColors.success100,
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             selectedMonth,
                      //             style: AppStyle.appTextStyles.largeNoneMedium!
                      //                 .copyWith(
                      //               color: BaseColors.neutral600,
                      //             ),
                      //           ),
                      //           Icon(
                      //             Icons.arrow_drop_down,
                      //             color: BaseColors.neutral600,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: BaseColors.neutral200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle,
                                  color: BaseColors.success500, size: 10),
                              const SizedBox(width: 8),
                              const Text('Normal'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.circle,
                                  color: BaseColors.danger500, size: 10),
                              const SizedBox(width: 8),
                              const Text('High'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.circle,
                                  color: BaseColors.warning500, size: 10),
                              const SizedBox(width: 8),
                              const Text('Low'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MonitoringGraph(
                      title: "Water Temperature",
                      axisTitle: "Celcius",
                      timestamp: time,
                      data: waterTemperature),
                  const SizedBox(height: 20),
                  MonitoringGraph(
                      title: "Acidity",
                      axisTitle: "pH",
                      timestamp: time,
                      data: ph),
                  const SizedBox(height: 20),
                  MonitoringGraph(
                      title: "Tank TDS",
                      axisTitle: "ppm",
                      timestamp: time,
                      data: tankTds),
                  const SizedBox(height: 20),
                  MonitoringGraph(
                      title: "Field TDS",
                      axisTitle: "ppm",
                      timestamp: time,
                      data: fieldTds),
                ],
              );
            }),
      ),
    );
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0.0, 40),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: months.map((month) {
                  return Container(
                    width: 200,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMonth = month;
                        });
                        _toggleDropdown();
                      },
                      child: Text(
                        month,
                        style: AppStyle.appTextStyles.largeNoneMedium!.copyWith(
                          color: BaseColors.neutral600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
