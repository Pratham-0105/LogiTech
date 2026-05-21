import 'package:flutter/material.dart';

class AlertsTab extends StatefulWidget {
  const AlertsTab({super.key});

  @override
  State<AlertsTab> createState() => _AlertsTabState();
}

class _AlertsTabState extends State<AlertsTab>
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

    _fade = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🔥 Dummy Alerts
  final List<Map<String, dynamic>> alerts = [
    {
      "title": "Cold Chain Alert",
      "desc": "Temperature is 11°C (Safe limit: 8°C)",
      "type": "critical"
    },
    {
      "title": "Fuel Low",
      "desc": "Fuel station 12 km ahead",
      "type": "warning"
    },
    {
      "title": "Route Suggestion",
      "desc": "Alternate route can save 18 minutes",
      "type": "info"
    },
  ];

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
                colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
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
                  "Alerts",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.notifications, color: Colors.white),
              ],
            ),
          ),

          // 🔥 ALERT LIST
          Expanded(
            child: FadeTransition(
              opacity: _fade,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  return _alertCard(alert);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 ALERT CARD
  Widget _alertCard(Map<String, dynamic> alert) {

    Color color;
    IconData icon;

    switch (alert["type"]) {
      case "critical":
        color = Colors.red;
        icon = Icons.warning;
        break;
      case "warning":
        color = Colors.orange;
        icon = Icons.error_outline;
        break;
      default:
        color = Colors.blue;
        icon = Icons.info;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  alert["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(alert["desc"]),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              // 🔥 ACTION BUTTON
              TextButton(
                onPressed: () {},
                child: const Text("View"),
              ),

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                ),
                child: const Text("Action"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}