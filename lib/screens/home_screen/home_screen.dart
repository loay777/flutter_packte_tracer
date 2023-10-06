import 'package:flutter/material.dart';
import 'package:saudi_digital_packet_tracer/screens/topology_screen/topology_screen.dart';
import '../configure_devices_screen/configure_devices.dart';
import '../../data/device/device_manager.dart';

class HomeScreen extends StatelessWidget {
  final DeviceManager deviceManager;
  const HomeScreen({required this.deviceManager, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saudi Digital Packet Tracer '),
      ),
      body: ListView(
        shrinkWrap: true, // Ensures the ListView takes up the full screen
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Configure Devices Card
          Card(
            elevation: 5.0,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ConfigureDevicesPage(deviceManager: deviceManager),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 48.0,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Configure Devices',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Create Topology Card
          Card(
            elevation: 5.0,
            child: InkWell(
              onTap: () {
                // Navigate to a screen to create network topologies

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const TopologyScreen(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.dns,
                      size: 48.0,
                      color: Colors.green,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Create Topology',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),

          // Network Simulation Card
          // Card(
          //   elevation: 5.0,
          //   child: InkWell(
          //     onTap: () {
          //       // Navigate to a screen to perform network simulations
          //     },
          //     child: const Padding(
          //       padding: EdgeInsets.all(16.0),
          //       child: Column(
          //         children: [
          //           Icon(
          //             Icons.timeline,
          //             size: 48.0,
          //             color: Colors.orange,
          //           ),
          //           SizedBox(height: 10.0),
          //           Text(
          //             'Network Simulation',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20.0),

          // // View Simulations Card
          // Card(
          //   elevation: 5.0,
          //   child: InkWell(
          //     onTap: () {
          //       // Navigate to a screen to view previous simulations
          //     },
          //     child: const Padding(
          //       padding: EdgeInsets.all(16.0),
          //       child: Column(
          //         children: [
          //           Icon(
          //             Icons.history,
          //             size: 48.0,
          //             color: Colors.blueGrey,
          //           ),
          //           SizedBox(height: 10.0),
          //           Text(
          //             'View Simulations',
          //             style: TextStyle(fontSize: 18.0),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // // Add more Card widgets with appropriate icons for other features as needed
        ],
      ),
    );
  }
}
