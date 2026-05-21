// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'tabs/overview_tab.dart';
import 'tabs/navigation_tab.dart';
import 'tabs/alerts_tab.dart';
import 'tabs/vehicle_tab.dart';
import 'tabs/emergency_tab.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> driverData;
  const HomeScreen({super.key, required this.driverData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  // Flattened list of all screens
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      const OverviewTab(),
      const NavigationTab(),
      const AlertsTab(), // Ensure naming matches your file
      const VehicleTab(),
      const EmergencyTab(),
      buildProfileScreen(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget buildProfileScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Name: ${widget.driverData['name'] ?? 'N/A'}"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Logout"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Required for more than 3 items
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Overview"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Navigation"),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: "Alerts"),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Vehicle"),
          BottomNavigationBarItem(icon: Icon(Icons.emergency), label: "Emergency"),
          // BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}