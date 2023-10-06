import 'package:flutter/material.dart';
import '../../data/device/device.dart'; // Import your Device class
import '../../data/device/device_manager.dart'; // Import your DeviceManager class

class ConfigureDevicesPage extends StatefulWidget {
  final DeviceManager deviceManager;

  const ConfigureDevicesPage({required this.deviceManager, super.key});

  @override
  State<ConfigureDevicesPage> createState() => _ConfigureDevicesPageState();
}

class _ConfigureDevicesPageState extends State<ConfigureDevicesPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ipAddressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ipAddressController.dispose();
    super.dispose();
  }

  void _addDevice() {
    final name = _nameController.text;
    final ipAddress = _ipAddressController.text;

    if (name.isNotEmpty && ipAddress.isNotEmpty) {
      final newDevice = Device(name: name, ipAddress: ipAddress);
      widget.deviceManager.addDevice(newDevice);
      _nameController.clear();
      _ipAddressController.clear();
      setState(() {}); // Update the list of devices
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Device Name'),
            ),
            TextField(
              controller: _ipAddressController,
              decoration: const InputDecoration(labelText: 'IP Address'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addDevice,
              child: const Text('Add Device'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Devices:',
              style: TextStyle(fontSize: 18.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.deviceManager.devices.length,
                itemBuilder: (context, index) {
                  final device = widget.deviceManager.devices[index];
                  return ListTile(
                    title: Text(device.name),
                    subtitle: Text(device.ipAddress),
                    // You can add more actions here if needed
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
