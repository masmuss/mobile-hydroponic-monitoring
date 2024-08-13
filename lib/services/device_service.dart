import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponic/models/device.dart';

class DeviceService {
  final DatabaseReference _deviceRef = FirebaseDatabase.instance.ref('devices');

  /* Future<List<Device>> getAllDevices() async {
    DataSnapshot snapshot = await _deviceRef.get();

    if (snapshot.exists) {
      final data = await _deviceRef.once();

      List<String> deviceNames = [];

      for (DataSnapshot deviceSnapshot in snapshot.children) {
        Map<String, dynamic> deviceData = Map<String, dynamic>.from(deviceSnapshot.value as Map);

        String deviceName = deviceData['name'];
        deviceNames.add(deviceName);
      }

      log("devices ${deviceNames.join(', ')}");

      // get devices name only
      Map<String, dynamic> devicesMap = _castToMap<String, dynamic>(data.snapshot.value);

      List<Device> devices = devicesMap.entries
          .map((entry) => Device(
                id: entry.key,
                name: entry.value['name'],
                data: entry.value['data'],
              ))
          .toList();

      log("length ${devicesMap.length}");

      return devices;
    } else {
      return [];
    }
  } */

  Stream<List<Device>> getDevicesStream() {
    return _deviceRef.onValue.map((event) {
      List<Device> devices = [];
      DataSnapshot snapshot = event.snapshot;

      for (DataSnapshot deviceSnapshot in snapshot.children) {
        final deviceData = deviceSnapshot.value as Map<Object?, Object?>;
        final deviceDataMap = deviceData.map((key, value) => MapEntry(key as String, value));

        Device device = Device.fromJson(Map<String, dynamic>.from(deviceDataMap));
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
    return _deviceRef.child(deviceId).onValue.map((event) {
      final deviceData = event.snapshot.value as Map<Object?, Object?>;
      final deviceDataMap = deviceData.map((key, value) => MapEntry(key as String, value));

      return Device.fromJson(Map<String, dynamic>.from(deviceDataMap));
    });
  }

}
