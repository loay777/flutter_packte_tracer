import 'package:flutter/material.dart';
import '../home_screen/home_screen.dart';
import '../../data/device/device_manager.dart';

class SplashScreen extends StatefulWidget {
  final DeviceManager deviceManager;
  const SplashScreen({required this.deviceManager, super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Create an animation controller with a duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Adjust the duration as needed
    )..repeat(); // Repeat the animation

    // Simulate some loading time (e.g., fetching data or initializing resources)
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the main screen after the splash screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen(
          deviceManager: widget.deviceManager,
        ),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 252, 252, 252), // Customize your splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Use RotationTransition to make the container and its contents spin
            ScaleTransition(
              scale: _controller,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/ic_launcher.png', // Replace with your image asset path
                    width: 220.0, // Customize the image size
                    height: 220.0, // Customize the image size
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Welcome!',
              style: TextStyle(
                color: Color.fromARGB(
                    255, 255, 255, 255), // Customize the text color
                fontSize: 24.0, // Customize the text size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
