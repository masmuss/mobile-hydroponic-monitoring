import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponic/models/device.dart';

class DeviceService {
  final DatabaseReference _deviceRef = FirebaseDatabase.instance.ref('devices');

  Stream<List<Device>> getDevicesStream() {
    return _deviceRef.onValue.map((event) {
      List<Device> devices = [];
      DataSnapshot snapshot = event.snapshot;

      for (DataSnapshot deviceSnapshot in snapshot.children) {
        final deviceData = deviceSnapshot.value as Map<Object?, Object?>;
        final deviceDataMap =
            deviceData.map((key, value) => MapEntry(key as String, value));

        Device device =
            Device.fromJson(Map<String, dynamic>.from(deviceDataMap));
        devices.add(device);
      }

      log("devices ${devices.map((device) => {
            print('Device ID: ${device.id}'),
            print('Device Name: ${device.name}'),
            print('Device Config Relay 1: ${device.configs.relay1}'),
          })}");

      return devices;
    });
  }

  Stream<Device> getDeviceByIdStream(String deviceId) {
    return _deviceRef
        .child(deviceId)
        .onValue
        .map((event) {
      final deviceData = event.snapshot.value as Map<Object?, Object?>;
      log(deviceData.values.toString());

      final deviceDataMap =
          deviceData.map((key, value) => MapEntry(key as String, value));

      return Device.fromJson(Map<String, dynamic>.from(deviceDataMap));
    });
  }
}
