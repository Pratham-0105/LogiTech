import 'package:flutter/material.dart';
import 'tabs/overview_tab.dart';
import 'tabs/navigation_tab.dart';
import 'tabs/alerts_tab.dart';
import 'tabs/vehicle_tab.dart';
import 'tabs/emergency_tab.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, required Map<String, dynamic> driverData});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    OverviewTab(),
    NavigationTab(),
    AlertsTab(),
    VehicleTab(),
    EmergencyTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Overview",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Navigation",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: "Alerts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: "Vehicle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency),
            label: "Emergency",
          ),
        ],
      ),
    );
  }
}