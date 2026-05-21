import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyTab extends StatefulWidget {
  const EmergencyTab({super.key});

  @override
  State<EmergencyTab> createState() => _EmergencyTabState();
}

class _EmergencyTabState extends State<EmergencyTab>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🚨 SOS BUTTON FUNCTION
  void _triggerSOS() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("🚨 SOS Activated!")),
    );
  }

  // 📞 CALL FUNCTION
  Future<void> _callEmergency() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '9322538152');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot make call")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEA),

      body: Column(
        children: [

          // 🔥 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD32F2F), Color(0xFFF44336)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              children: [
                Icon(Icons.warning, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Emergency",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 🚨 SOS BUTTON
          ScaleTransition(
            scale: _pulseAnimation,
            child: GestureDetector(
              onTap: _triggerSOS,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: const Center(
                  child: Text(
                    "SOS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // 🔻 ACTION BUTTONS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                _actionButton(
                  icon: Icons.call,
                  text: "Call Emergency Contact",
                  color: Colors.red,
                  onTap: _callEmergency, // ✅ CALL ADDED
                ),

                const SizedBox(height: 15),

                _actionButton(
                  icon: Icons.location_on,
                  text: "Share Live Location",
                  color: Colors.orange,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Location feature coming soon")),
                    );
                  },
                ),

                const SizedBox(height: 15),

                _actionButton(
                  icon: Icons.volume_up,
                  text: "Trigger Alarm",
                  color: Colors.deepPurple,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Alarm triggered")),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 BUTTON WIDGET
  Widget _actionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}