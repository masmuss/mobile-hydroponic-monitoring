import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydroponic/models/device.dart';
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
      appBar: AppBar(
        title: const Text('Devices List'),
      ),
      body: _buildDeviceList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            showAddDeviceDialog(context, _deviceService, _deviceStorage, () {
          setState(() {});
        }),
        child: const Icon(Icons.add),
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
          return const Center(child: Text('Error loading devices'));
        } else if (!snapshot.hasData ||
            snapshot.data!.isEmpty ||
            // ignore: unnecessary_null_comparison
            _deviceStorage.getDeviceIds() == null) {
          return const Center(child: Text('No devices available'));
        } else {
          final devices = snapshot.data!;
          return ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return DeviceListItem(
                device: device,
                onEdit: () =>
                    showEditDeviceDialog(context, _deviceService, device, () {
                  setState(() {});
                }),
                onDelete: () =>
                    showDeleteDeviceDialog(context, _deviceStorage, device, () {
                  setState(() {});
                }),
              );
            },
          );
        }
      },
    );
  }
}
