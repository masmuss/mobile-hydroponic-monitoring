import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydroponic/models/configs.dart';
import 'package:hydroponic/models/device.dart';
import 'package:hydroponic/models/logs.dart';
import 'package:hydroponic/models/record.dart';
import 'package:hydroponic/models/schedule.dart';
import 'package:hydroponic/services/device_storage.dart';

class DeviceService {
  final DatabaseReference _deviceRef = FirebaseDatabase.instance.ref('devices');
  final DeviceStorage _deviceStorage = DeviceStorage();

  /// Stream daftar perangkat yang disimpan
  Stream<List<Device>> getDevicesStream() async* {
    List<String> savedDeviceIds = await _deviceStorage.getDeviceIds();

    yield* _deviceRef.onValue.map((event) {
      final snapshot = event.snapshot;
      if (!snapshot.exists) return [];

      final devices = _parseDevices(snapshot.value);
      return devices
          .where((device) => savedDeviceIds.contains(device.id.toString()))
          .toList();
    });
  }

  /// Stream data terakhir dari sensor perangkat tertentu
  Stream<Record> getLatestRecordStream(int deviceId) {
    return _deviceRef
        .child(deviceId.toString())
        .child('records')
        .onValue
        .map((event) {
      final recordData = event.snapshot.value;
      if (recordData == null) throw Exception('No records found');

      final List<dynamic> records = recordData as List<dynamic>;
      if (records.isEmpty) throw Exception('No records found');

      return Record.fromJson(Map<String, dynamic>.from(records.last));
    });
  }

  /// Mengecek apakah perangkat dengan ID tertentu ada di Firebase
  Future<bool> isDeviceIdExists(String deviceId) async {
    final snapshot = await _deviceRef.child(deviceId).get();
    return snapshot.exists;
  }

  /// Stream satu perangkat berdasarkan ID
  Stream<Device> getDeviceByIdStream(int deviceId) {
    return _deviceRef.child(deviceId.toString()).onValue.map((event) {
      final data = event.snapshot.value;
      if (data == null) throw Exception('Device not found');

      return Device.fromJson(Map<String, dynamic>.from(data as Map));
    });
  }

  /// Mengambil konfigurasi perangkat secara async
  Future<Map<String, dynamic>?> getDeviceConfig(String deviceId) async {
    final snapshot = await _deviceRef.child(deviceId).child('configs').get();
    return snapshot.exists
        ? Map<String, dynamic>.from(snapshot.value as Map)
        : null;
  }

  /// Stream konfigurasi perangkat
  Stream<Configs> getDeviceConfigStream(int deviceId) {
    return _deviceRef
        .child(deviceId.toString())
        .child('configs')
        .onValue
        .map((event) {
      final data = event.snapshot.value;
      if (data == null) throw Exception('Configuration not found');

      return Configs.fromJson(Map<String, dynamic>.from(data as Map));
    });
  }

  /// Stream jadwal perangkat
  Stream<Schedule> getDeviceScheduleStream(int deviceId) {
    return _deviceRef
        .child(deviceId.toString())
        .child('configs')
        .child('schedule')
        .onValue
        .map((event) {
      final data = event.snapshot.value;
      if (data == null) throw Exception('Schedule not found');

      return Schedule.fromJson(Map<String, dynamic>.from(data as Map));
    });
  }

  /// Mengubah mode otomatis/manual perangkat
  Future<void> switchAutoMode(int deviceId, String value) async {
    await _updateDeviceConfig(deviceId, {'mode': value});
    log('Auto mode updated to $value for device $deviceId');
  }

  /// Mengupdate konfigurasi relay manual perangkat
  Future<void> updateRelayConfig(
      int deviceId, String relayKey, bool value) async {
    await _updateDeviceConfig(deviceId, {
      'relays/manual/$relayKey': value,
    });
    log('Relay $relayKey updated to $value for device $deviceId');
  }

  /// Mengubah jadwal perangkat
  Future<void> setDeviceSchedule(
      int deviceId, String scheduleKey, double value) async {
    await _updateDeviceConfig(deviceId, {
      'schedule/$scheduleKey': value,
    });
    log('Schedule $scheduleKey updated to $value for device $deviceId');
  }

  /// Data logs history
   Stream<List<Log>> getLogsStream(int deviceId) {
    final logPath = '/devices/$deviceId/logs';
    log('Fetching logs from path: $logPath');
    return _deviceRef
        .child(deviceId.toString())
        .child('logs')
        .onValue
        .map((event) {
      final data = event.snapshot.value;
      log('Raw log data type for device $deviceId: ${data.runtimeType}');
      log('Raw log data for device $deviceId: $data');
      if (data == null) {
        log('No logs found at path: $logPath');
        return <Log>[];
      }

      try {
        final List<dynamic> logsList = data is List
            ? data
            : [data]; // Handle jika data adalah array atau objek tunggal
        log('Converted logsList type: ${logsList.runtimeType}');
        final List<Log> logs = logsList.map((logData) {
          log('Log entry value type: ${logData.runtimeType}');
          if (logData is Map) {
            final logJson = Map<String, dynamic>.from(logData);
            log('Processing log entry: $logJson');
            return Log.fromJson(logJson);
          } else {
            log('Invalid log data format: $logData');
            throw Exception('Invalid log data format');
          }
        }).toList();

        logs.sort((a, b) {
          try {
            return DateTime.parse(b.datetime)
                .compareTo(DateTime.parse(a.datetime));
          } catch (e) {
            log('Error parsing datetime in log: $e');
            return 0;
          }
        });

        log('Processed ${logs.length} logs for device $deviceId');
        return logs;
      } catch (e) {
        log('Error processing logs for device $deviceId: $e');
        throw Exception('Error processing logs: $e');
      }
    }).handleError((error) {
      log('Stream error in getLogsStream for device $deviceId: $error');
      throw error;
    });
  }

  Future<int> getLogCount(int deviceId) async {
    final logCountPath = '/devices/$deviceId/log_count';
    log('Fetching log count from path: $logCountPath');
    try {
      final snapshot =
          await _deviceRef.child(deviceId.toString()).child('log_count').get();
      if (snapshot.exists) {
        final data = snapshot.value;
        log('Log count data: $data');
        return data is int ? data : 0;
      } else {
        log('Log count does not exist at path: $logCountPath');
        return 0;
      }
    } catch (error) {
      log('Error fetching log count: $error');
      return 0;
    }
  }

  // ======================== HELPER METHODS ========================

  /// Parsing daftar perangkat dari Firebase
  List<Device> _parseDevices(dynamic data) {
    if (data == null) return [];

    final Map<String, dynamic> deviceMap =
        Map<String, dynamic>.from(data as Map);
    return deviceMap.entries.map((entry) {
      final deviceData = Map<String, dynamic>.from(entry.value as Map);
      return Device.fromJson(deviceData);
    }).toList();
  }

  /// Helper untuk memperbarui konfigurasi perangkat di Firebase
  Future<void> _updateDeviceConfig(
      int deviceId, Map<String, dynamic> updates) async {
    try {
      await _deviceRef
          .child(deviceId.toString())
          .child('configs')
          .update(updates);
    } catch (error) {
      log('Failed to update device $deviceId: $error');
      rethrow;
    }
  }
}
