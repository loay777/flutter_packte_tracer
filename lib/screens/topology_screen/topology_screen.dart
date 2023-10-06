import 'package:flutter/material.dart';
import './dragable_device.dart';
import './device_list_Item.dart';
import 'package:provider/provider.dart';
import '../../providers/dragable_devices_provider.dart';
import '../../providers/connections provider.dart';
import '../../data/topology/connection.dart';

class TopologyScreen extends StatefulWidget {
  const TopologyScreen({Key? key}) : super(key: key);

  @override
  State<TopologyScreen> createState() => _TopologyScreenState();
}

class _TopologyScreenState extends State<TopologyScreen> {
  final List<DraggableDevice> _draggedDevices = [];
  final List<String> _devicesNames = [
    // Add more static devices names as needed
    'switch',
    'router',
    'pc',
    'laptop',
    'server',
  ];
  final List<String> _connectionNames = [
    'ic_launcher',
  ];
  int _currentIndex = 0; // Added to track the selected tab index
  Offset _lineStart = Offset.zero; //for
  Offset _lineEnd = Offset.zero;
  bool _isLive = false;
  bool _playButtonClicked = false; // Added to track if play button is clicked

  @override
  Widget build(BuildContext context) {
    var draggedDevicesList =
        context.watch<DragableDevicesProvider>().draggedDevices;
    var connectionsList = context.watch<ConnectionsProvider>().connections;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topology'),
        actions: [
          IconButton(
            icon: Icon(_playButtonClicked ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _playButtonClicked = !_playButtonClicked;
              });
            },
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ClipRect(
          child: Stack(
            children: <Widget>[
              // Display all the dragged images on the screen.

              for (final image in draggedDevicesList) image,
              for (final connection in connectionsList) _drawLine(connection),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.devices),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Connections',
          ),
        ],
      ),
      bottomSheet: _currentIndex == 0
          ? Container(
              height: 100,
              color: Colors.grey[300],
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _devicesNames.length,
                itemBuilder: (context, index) {
                  return DeviceListItem(
                    imageUrl: 'assets/images/${_devicesNames[index]}.png',
                    defaultName: _devicesNames[index],
                    onDeviceTap: (position) {
                      _addDraggableDevice(
                          position,
                          'assets/images/${_devicesNames[index]}.png',
                          _devicesNames[index]);
                    },
                  );
                },
              ),
            )
          : Container(
              height: 100,
              color: Colors.grey[300],
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _connectionNames.length,
                itemBuilder: (context, index) {
                  return DeviceListItem(
                    imageUrl: 'assets/images/${_connectionNames[index]}.png',
                    defaultName: _connectionNames[index],
                    onDeviceTap: (position) {
                      _addDraggableDevice(
                          position,
                          'assets/images/${_connectionNames[index]}.png',
                          _connectionNames[index]);
                    },
                  );
                },
              ),
            ),
    );
  }

  void _addDraggableDevice(
      Offset position, String imageUrl, String defaultName) {
    var draggedDeviceslist =
        context.read<DragableDevicesProvider>().draggedDevices;
    final draggableDevice = DraggableDevice(
      key: GlobalKey(),
      availableDevices: draggedDeviceslist,
      initialPosition: position,
      imageUrl: imageUrl, // Added imageUrl argument
      name: defaultName,
      // onDelete: (String name) {
      //   _deleteDraggableDevice(draggableDevice.key!);
      // },
      // onEditName: (String name, String newName) {
      //   _editDeviceName(name, newName);
      // },
    );
    draggableDevice.onDelete = (Key key) => _deleteDraggableDevice(key);
    draggableDevice.onEditName =
        (Key key, String name) => _editDeviceName(key, name);
    // _draggedDevices.add(draggableDevice);
    context.read<DragableDevicesProvider>().addtoList(draggableDevice);
  }

  void _deleteDraggableDevice(Key key) {
    if (mounted) {
      setState(() {
        context.read<DragableDevicesProvider>().removeFromList(key);
        var list = context.read<DragableDevicesProvider>().draggedDevices;
        print("LIST IS: ${list}");
      });
    }
  }

  void _editDeviceName(Key key, String newName) {
    if (mounted) {
      context.read<DragableDevicesProvider>().editFromList(key, newName);
      var list = context.read<DragableDevicesProvider>().draggedDevices;
      print("LIST IS: ${list}");
    }
  }

  CustomPaint _drawLine(Connection connection) {
    _setLineStart(connection.device1.initialPosition);
    _setLineEnd(connection.device2.initialPosition);
    _isLive = connection.connectionIsLive; // Added line to set _isLive
    final line = CustomPaint(
      painter: LinePainter(_lineStart, _lineEnd, _isLive, _playButtonClicked),
    );
    return line;
  }

  void _setLineStart(Offset end) {
    setState(() {
      _lineStart = Offset(end.dx + 25, end.dy + 25); // Center of the image
    });
  }

  void _setLineEnd(Offset end) {
    setState(() {
      _lineEnd = Offset(end.dx + 25, end.dy + 25); // Center of the image
    });
  }
}

class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final bool isLive;
  final bool playButtonClicked;

  LinePainter(this.start, this.end, this.isLive, this.playButtonClicked);

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = playButtonClicked
          ? Colors.black
          : Colors
              .grey // Added ternary operator to set color based on play button click
      ..strokeWidth = 2;

    final paintCircle = Paint()
      ..color = playButtonClicked
          ? (isLive ? Colors.green : Colors.red)
          : Colors
              .grey // Added ternary operator to set color based on play button click
      ..strokeWidth = 0.3;

    canvas.drawLine(Offset(start.dx + 34, start.dy),
        Offset(end.dx - 34, end.dy), paintLine);
    canvas.drawCircle(Offset(start.dx + 34, start.dy), 2, paintCircle);
    canvas.drawCircle(Offset(end.dx - 34, end.dy), 2, paintCircle);
    canvas.drawCircle(Offset(start.dx + 34, start.dy), 5, paintCircle);
    canvas.drawCircle(Offset(end.dx - 34, end.dy), 5, paintCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
