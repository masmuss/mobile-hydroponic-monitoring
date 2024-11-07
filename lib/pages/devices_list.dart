import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/pages/common/colors.dart';
import 'package:hydroponic/pages/component/custom_appbar.dart';
import 'package:hydroponic/pages/widgets/qr_scan.dart';
import 'package:hydroponic/services/device_service.dart';
import 'package:hydroponic/services/device_storage.dart';
import 'package:hydroponic/widgets/device_list_dialogs.dart';
import 'package:hydroponic/widgets/device_list_item.dart';

class DevicesList extends StatefulWidget {
  const DevicesList({super.key});

  @override
  State<DevicesList> createState() => _DevicesListState();
}

class _DevicesListState extends State<DevicesList> {
  final DeviceService _deviceService = DeviceService();
  final DeviceStorage _deviceStorage = DeviceStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: _buildDeviceList(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: BaseColors.success700,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QRScanPage(),
        )),
        child: Icon(Icons.add, color: BaseColors.gray100),
      ),
    );
  }

  Widget _buildDeviceList(BuildContext context) {
    return StreamBuilder<List<Device>>(
      stream: _deviceService.getDevicesStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          log('Error loading devices: ${snapshot.error}');
          return Center(
              child: Text('Error loading devices: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text('No devices available'));
        } else {
          final devices = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2
              ),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return DeviceListItem(
                  device: device,
                  onDelete: () =>
                      showDeleteDeviceDialog(context, _deviceStorage, device, () {
                    setState(() {});
                  }),
                );
              },
            ),
          );
        }
      },
    );
  }
}
