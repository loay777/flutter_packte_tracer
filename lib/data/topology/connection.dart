import 'package:saudi_digital_packet_tracer/screens/topology_screen/dragable_device.dart';

final List connectionType = ["ssh", "internet"];

class Connection {
  final DraggableDevice device1;
  final DraggableDevice device2;
  final String connectionType;
  final bool connectionIsLive;

  Connection({
    required this.device1,
    required this.device2,
    required this.connectionType,
    required this.connectionIsLive,
  });

  set device1(DraggableDevice device) {
    this.device1 = device;
  }

  set device2(DraggableDevice device) {
    this.device2 = device;
  }

  set connectionType(String type) {
    this.connectionType = type;
  }

  set connectionIsLive(bool isLive) {
    this.connectionIsLive = isLive;
  }
}
