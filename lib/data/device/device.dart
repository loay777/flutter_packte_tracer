class Device {
  String name;
  String ipAddress;
  // Add more properties as needed

  Device({
    required this.name,
    required this.ipAddress,
  });

  // Convert the Device object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ipAddress': ipAddress,
    };
  }

  // Create a Device object from a Map
  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      name: map['name'],
      ipAddress: map['ipAddress'],
    );
  }
}
