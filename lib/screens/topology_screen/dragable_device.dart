import 'package:flutter/material.dart';
import 'package:saudi_digital_packet_tracer/providers/connections%20provider.dart';
import './device_list_Item.dart';
import '../../data/topology/topology_device.dart';
import 'package:provider/provider.dart';
import '../../providers/dragable_devices_provider.dart';

class DraggableDevice extends StatefulWidget {
  final Key key;
  Offset initialPosition;
  final String imageUrl;
  late Function(Key) onDelete;
  late Function(Key, String) onEditName;
  String name;
  List<DraggableDevice> availableDevices = [];
  List<DraggableDevice> connectedDevices = [];
  DraggableDevice({
    required this.key,
    required this.initialPosition,
    required this.imageUrl,
    required this.name,
    required this.availableDevices,
  }) : super(key: key);

  @override
  State<DraggableDevice> createState() => _DraggableDeviceState();
}

class _DraggableDeviceState extends State<DraggableDevice> {
  late Offset _position;
  late String type;

  @override
  void initState() {
    super.initState();

    _position = widget.initialPosition;
    type = widget.imageUrl.substring(14, widget.imageUrl.length - 4);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.initialPosition.dx,
      top: widget.initialPosition.dy,
      child: GestureDetector(
        onLongPress: () {
          _showDeviceOptions(context);
        },
        child: Draggable<String>(
          data: widget.name,
          feedback: Image.asset(
            widget.imageUrl,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          onDraggableCanceled: (velocity, offset) {
            // Provider.of<DragableDevicesProvider>(context, listen: false)
            //     .updateDevicePosition(widget.key, offset);
            // context
            //     .watch<DragableDevicesProvider>()
            //     .updateDevicePosition(widget.key, offset);
            // _updatePosition(widget.key, offset);
            // print("NEW POSITION: ${offset}");
            setState(() {
              widget.initialPosition = offset;
            });
          },
          childWhenDragging: Container(),
          child: Column(
            children: [
              Image.asset(
                widget.imageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeviceOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Device Options'),
          // content: type == "pc" || type == "laptop"
          //     ? Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           ListTile(
          //             leading: const Icon(Icons.delete),
          //             title: const Text('Delete'),
          //             onTap: () {
          //               Provider.of<ConnectionsProvider>(context, listen: false)
          //                   .removeDeviceConnections(widget);
          //               widget.onDelete(widget.key);
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //           ListTile(
          //             leading: const Icon(Icons.import_export_sharp),
          //             title: const Text('Set IP'),
          //             onTap: () {
          //               widget.onDelete(widget.key);
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //           ListTile(
          //             leading: const Icon(Icons.compare_arrows),
          //             title: const Text('Connect'),
          //             onTap: () {
          //               _connectToDevice(context, widget);
          //             },
          //           ),
          //           ListTile(
          //             leading: const Icon(Icons.edit),
          //             title: const Text('Edit Name'),
          //             onTap: () {
          //               _editDeviceName(context, widget.name);
          //             },
          //           ),
          //         ],
          //       )
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Provider.of<ConnectionsProvider>(context, listen: false)
                      .removeDeviceConnections(widget);
                  widget.onDelete(widget.key);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.compare_arrows),
                title: const Text('Connect'),
                onTap: () {
                  _connectToDevice(context, widget);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Name'),
                onTap: () {
                  _editDeviceName(context, widget.name);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _editDeviceName(BuildContext context, String currentName) async {
    final newName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String editedName = currentName;
        return AlertDialog(
          title: const Text('Edit Device Name'),
          content: TextField(
            onChanged: (value) {
              editedName = value;
            },
            controller: TextEditingController(text: currentName),
            decoration: const InputDecoration(labelText: 'New Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                widget.onEditName(widget.key, editedName);
                Navigator.of(context).pop(editedName);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (newName != null) {
      setState(() {
        widget.name = newName;
      });
    }
  }

  void _updatePosition(Key key, Offset position) {
    context
        .watch<DragableDevicesProvider>()
        .updateDevicePosition(widget.key, position);
  }

  void _connectToDevice(BuildContext context, Widget device) async {
    final newConnection = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Devices List'),
          content: Container(
            width: double.maxFinite, // Use maximum width available
            height: 100, // Set the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              itemCount: widget.availableDevices.length,
              itemBuilder: (context, index) {
                if (widget.availableDevices[index].key != widget.key) {
                  return DeviceListItem(
                    imageUrl: widget.availableDevices[index].imageUrl,
                    defaultName: widget.availableDevices[index].name,
                    onDeviceTap: (position) {
                      // context.watch<ConnectionsProvider>().addConnection(
                      //     widget, widget.availableDevices[index]);
                      Provider.of<ConnectionsProvider>(context, listen: false)
                          .addConnection(
                              widget, widget.availableDevices[index]);
                      var listOfConnections = Provider.of<ConnectionsProvider>(
                              context,
                              listen: false)
                          .connections;
                      for (var connection in listOfConnections) {
                        print(
                            'Device 1: ${connection.device1.name}, Device 2: ${connection.device2.name}, Connection Type: ${connection.connectionType}, Connection is Live: ${connection.connectionIsLive}');
                      }

                      print(widget.availableDevices[index].name);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  );
                } else {
                  return Container(); // Return an empty container if the keys are the same
                }
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
