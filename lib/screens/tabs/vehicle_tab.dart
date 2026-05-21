import 'package:flutter/material.dart';

class VehicleTab extends StatefulWidget {
  const VehicleTab({super.key});

  @override
  State<VehicleTab> createState() => _VehicleTabState();
}

class _VehicleTabState extends State<VehicleTab>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ✅ Typed Data (NO ERRORS NOW)
  int temperature = 7;
  int humidity = 68;
  int fuel = 35;
  String door = "Closed";
  String network = "Connected";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [

          // 🔥 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vehicle Health",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.local_shipping, color: Colors.white),
              ],
            ),
          ),

          // 🔥 BODY
          Expanded(
            child: FadeTransition(
              opacity: _fade,
              child: GridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [

                  _card(
                    "Temperature",
                    "$temperature°C",
                    _getTempColor(temperature),
                    Icons.thermostat,
                    temperature <= 8 ? "Safe" : "Critical",
                  ),

                  _card(
                    "Humidity",
                    "$humidity%",
                    Colors.blue,
                    Icons.water_drop,
                    "Normal",
                  ),

                  _card(
                    "Fuel Level",
                    "$fuel%",
                    _getFuelColor(fuel),
                    Icons.local_gas_station,
                    fuel < 40 ? "Low" : "Good",
                  ),

                  _card(
                    "Door Status",
                    door,
                    door == "Closed" ? Colors.green : Colors.red,
                    Icons.door_front_door,
                    door,
                  ),

                  _card(
                    "Network",
                    network,
                    Colors.green,
                    Icons.network_check,
                    "Connected",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 CARD WIDGET
  Widget _card(
      String title,
      String value,
      Color color,
      IconData icon,
      String status,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          Column(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 COLOR LOGIC
  Color _getTempColor(int temp) {
    if (temp <= 8) return Colors.green;
    if (temp <= 10) return Colors.orange;
    return Colors.red;
  }

  Color _getFuelColor(int fuel) {
    if (fuel > 50) return Colors.green;
    if (fuel > 30) return Colors.orange;
    return Colors.red;
  }
}