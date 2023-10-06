import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'device.dart';

class DeviceManager {
  List<Device> devices = [];

  // Add a device to the list
  void addDevice(Device device) {
    devices.add(device);
    saveDevices();
  }

  // Load devices from a local file
  Future<void> loadDevices() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/devices.json');
      if (file.existsSync()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonString);
        devices = jsonList.map((json) => Device.fromMap(json)).toList();
      }
    } catch (e) {
      print('Error loading devices: $e');
    }
  }

  // Save devices to a local file
  Future<void> saveDevices() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/devices.json');
      final jsonList = devices.map((device) => device.toMap()).toList();
      final jsonString = json.encode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error saving devices: $e');
    }
  }
}
