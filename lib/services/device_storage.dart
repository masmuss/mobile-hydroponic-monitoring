import 'package:shared_preferences/shared_preferences.dart';

class DeviceStorage {
  static const String _deviceIdsKey = 'device_ids';

  Future<void> saveDeviceIds(List<String> deviceIds) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_deviceIdsKey, deviceIds);
  }

  Future<void> addDeviceId(String deviceId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? deviceIds = prefs.getStringList(_deviceIdsKey) ?? [];

    if (!deviceIds.contains(deviceId)) {
      deviceIds.add(deviceId);
      await prefs.setStringList(_deviceIdsKey, deviceIds);
    }
  }

  Future<List<String>> getDeviceIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_deviceIdsKey) ?? [];
  }

  Future<void> removeDeviceId(String deviceId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? deviceIds = prefs.getStringList(_deviceIdsKey) ?? [];

    deviceIds.remove(deviceId);
    await prefs.setStringList(_deviceIdsKey, deviceIds);
  }

  Future<void> clearDeviceIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_deviceIdsKey);
  }
}
