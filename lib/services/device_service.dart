import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponic/models/configs.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/models/record.dart';
import 'package:hydroponic/services/device_storage.dart';
import 'package:intl/intl.dart';

class DeviceService {
  final DatabaseReference _deviceRef = FirebaseDatabase.instance.ref('devices');
  final DeviceStorage _deviceStorage = DeviceStorage();

  Stream<List<Device>> getDevicesStream() async* {
    List<String> savedDeviceIds = await _deviceStorage.getDeviceIds();

    yield* _deviceRef.onValue.map((event) {
      List<Device> devices = [];
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        final deviceData = snapshot.value as Map<Object?, Object?>;
        // log('deviceData1 $deviceData');

        final deviceDataMap =
            deviceData.map((key, value) => MapEntry(key as String, value));

        devices = deviceDataMap.entries
            .map((entry) {
              final deviceData = entry.value as Map<Object?, Object?>;
              // log('deviceData2 $deviceData');

              final deviceDataMap = deviceData
                  .map((key, value) => MapEntry(key.toString(), value));

              return Device.fromJson(Map<String, Object?>.from(deviceDataMap));
            })
            .where((device) => savedDeviceIds.contains(device.id.toString()))
            .toList();
      }

      return devices;
    });
  }

  Stream<Record> getLatestRecordStream(int deviceId) {
    return _deviceRef
        .child(deviceId.toString())
        .child('records')
        .onValue
        .map((event) {
      final recordData = event.snapshot.value as List<Object?>;

      if (recordData.isNotEmpty) {
        final recordMap = recordData.last as Map<Object?, Object?>;
        final record = Record.fromJson(recordMap);

        return record;
      } else {
        throw Exception('No records found');
      }
    });
  }

  Future<bool> isDeviceIdExists(String deviceId) async {
    DataSnapshot snapshot = await _deviceRef.child(deviceId).get();
    return snapshot.exists;
  }

  Stream<Device> getDeviceByIdStream(int deviceId) {
    return _deviceRef.child(deviceId.toString()).onValue.map((event) {
      final deviceData = event.snapshot.value as Map<Object?, Object?>;

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

  Stream<Configs> getDeviceConfigStream(int deviceId) {
    return _deviceRef
        .child(deviceId.toString())
        .child('configs')
        .onValue
        .map((event) {
      final configData = event.snapshot.value as Map<Object?, Object?>;

      final configDataMap = configData.map((key, value) {
        return MapEntry(key as String, value);
      });

      return Configs.fromJson(configDataMap);
    });
  }

  Future<void> switchAutoMode(int deviceId, String value) async {
    try {
      await _deviceRef
          .child(deviceId.toString())
          .child('configs')
          .update({
        'mode': value,
      });
      log('Auto mode updated to $value for device $deviceId');
    } catch (error) {
      log('Failed to update auto mode for device $deviceId: $error');
      rethrow;
    }
  }

  Future<void> updateRelayConfig(
      int deviceId, String relayKey, bool value) async {
    try {
      await _deviceRef
          .child(deviceId.toString())
          .child('configs')
          .child('relays')
          .child('manual')
          .update({
        relayKey: value,
      });
      log('Relay $relayKey updated to $value for device $deviceId');
    } catch (error) {
      log('Failed to update relay $relayKey for device $deviceId: $error');
      rethrow;
    }
  }
}
