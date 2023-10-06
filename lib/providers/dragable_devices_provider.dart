import 'package:flutter/material.dart';

import '../screens/topology_screen/dragable_device.dart';

class DragableDevicesProvider with ChangeNotifier {
  final List<DraggableDevice> _draggedDevicesList = [];
  List<DraggableDevice> get draggedDevices => _draggedDevicesList;

  void addtoList(DraggableDevice device) {
    _draggedDevicesList.add(device);
    notifyListeners();
  }

  void removeFromList(Key key) {
    _draggedDevicesList.removeWhere((device) => device.key == key);

    notifyListeners();
  }

  void editFromList(Key key, String newName) {
    var device =
        _draggedDevicesList.firstWhere((element) => element.key == key);
    device.name = newName;
    notifyListeners();
  }

  void updateDevicePosition(Key key, Offset newPosition) {
    var device =
        _draggedDevicesList.firstWhere((element) => element.key == key);
    device.initialPosition = newPosition;
    notifyListeners();
  }

  void clearList() {
    draggedDevices.clear();
  }
}
