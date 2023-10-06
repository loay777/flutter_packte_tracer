import 'package:flutter/material.dart';

class DeviceListItem extends StatelessWidget {
  final String imageUrl;
  final String defaultName;
  final Function(Offset) onDeviceTap;

  const DeviceListItem({super.key, 
    required this.imageUrl,
    required this.defaultName,
    required this.onDeviceTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          final size = MediaQuery.of(context).size;
          final centerX = size.width / 2 - 25; // Adjust for image size
          final centerY = size.height / 2 - 25; // Adjust for image size
          onDeviceTap(Offset(centerX, centerY));
        },
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Text(
              defaultName,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
