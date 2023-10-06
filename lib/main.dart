import 'package:flutter/material.dart';
import './screens/splash_screen/splash_screen.dart';
import './data/device/device_manager.dart'; // Import your DeviceManager class
import 'package:provider/provider.dart';
import './providers/dragable_devices_provider.dart';
import './providers/connections provider.dart'; // Import your ConnectionsProvider class

void main() async {
  final deviceManager = DeviceManager();
  await deviceManager.loadDevices(); // Load devices from storage
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DragableDevicesProvider()),
      ChangeNotifierProvider(create: (context) => ConnectionsProvider()),
    ],
    child: MainApp(deviceManager: deviceManager),
  ));
}

class MainApp extends StatelessWidget {
  final DeviceManager deviceManager;
  const MainApp({required this.deviceManager, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
          deviceManager:
              deviceManager), // Set the splash screen as the initial route
    );
  }
}
