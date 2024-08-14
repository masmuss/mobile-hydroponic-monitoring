import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/services/device_storage.dart';

class DeviceService {
  final DatabaseReference _deviceRef = FirebaseDatabase.instance.ref('devices');
  final DeviceStorage _deviceStorage = DeviceStorage();

  Stream<List<Device>> getDevicesStream() async* {
    List<String> savedDeviceIds = await _deviceStorage.getDeviceIds();

    yield* _deviceRef.onValue.map((event) {
      List<Device> devices = [];
      DataSnapshot snapshot = event.snapshot;

      for (DataSnapshot deviceSnapshot in snapshot.children) {
        final deviceData = deviceSnapshot.value as Map<Object?, Object?>;
        final deviceDataMap =
            deviceData.map((key, value) => MapEntry(key as String, value));

        Device device =
            Device.fromJson(Map<String, dynamic>.from(deviceDataMap));

        log(device.toString());

        if (savedDeviceIds.contains(device.id)) {
          devices.add(device);
        }
      }

      return devices;
    });
  }

  Future<bool> isDeviceIdExists(String deviceId) async {
    DataSnapshot snapshot = await _deviceRef.child(deviceId).get();
    return snapshot.exists;
  }

  Stream<Device> getDeviceByIdStream(String deviceId) {
    return _deviceRef.child(deviceId).onValue.map((event) {
      final deviceData = event.snapshot.value as Map<Object?, Object?>;
      log(deviceData.values.toString());

      final deviceDataMap =
          deviceData.map((key, value) => MapEntry(key as String, value));

      return Device.fromJson(Map<String, dynamic>.from(deviceDataMap));
    });
  }

  Future<Map<String, dynamic>?> getDeviceConfig(String deviceId) async {
    DataSnapshot snapshot =
        await _deviceRef.child(deviceId).child('configs').get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map<Object?, Object?>);
    }
    return null;
  }

  Future<void> updateRelayConfig(String deviceId, String relayKey, bool value) async {
    try {
      await _deviceRef.child(deviceId).child('configs').update({
        relayKey: value,
      });
      log('Relay $relayKey updated to $value for device $deviceId');
    } catch (error) {
      log('Failed to update relay $relayKey for device $deviceId: $error');
      rethrow;
    }
  }
}
