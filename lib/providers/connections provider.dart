import 'dart:math';

import 'package:flutter/material.dart';

import '../screens/topology_screen/dragable_device.dart';

import '../data/topology/connection.dart';

class ConnectionsProvider with ChangeNotifier {
  final List<Connection> _connectionsList = [];
  List<Connection> get connections => _connectionsList;

  void addConnection(DraggableDevice device1, DraggableDevice device2) {
    _connectionsList.add(Connection(
        device1: device1,
        device2: device2,
        connectionType: 'internet',
        connectionIsLive: Random().nextBool()));
    notifyListeners();
  }

  void removeConnection(DraggableDevice device1, DraggableDevice device2) {
    _connectionsList.removeWhere((connection) =>
        connection.device1 == device1 && connection.device2 == device2);
    notifyListeners();
  }

  void removeDeviceConnections(DraggableDevice device) {
    _connectionsList.removeWhere((connection) =>
        connection.device1 == device || connection.device2 == device);
    notifyListeners();
  }

  void editConnection(DraggableDevice device1, DraggableDevice device2,
      String newConnectionType, bool newConnectionIsLive) {
    var connection = _connectionsList.firstWhere((connection) =>
        connection.device1 == device1 && connection.device2 == device2);
    connection.connectionType = newConnectionType;
    connection.connectionIsLive = newConnectionIsLive;
    notifyListeners();
  }

  void changeConnectionIsLive(DraggableDevice device1, DraggableDevice device2,
      bool newConnectionIsLive) {
    var connection = _connectionsList.firstWhere((connection) =>
        connection.device1 == device1 && connection.device2 == device2);
    connection.connectionIsLive = newConnectionIsLive;
    notifyListeners();
  }
}
