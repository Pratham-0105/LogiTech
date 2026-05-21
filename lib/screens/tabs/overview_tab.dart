import 'package:flutter/material.dart';
import 'package:loditech/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  Map<String, dynamic>? driver;
  Map<String, dynamic>? truck;

  String errorMessage = "";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _slide = Tween(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    loadData();
  }

  // 🔥 FIREBASE LOAD
  void loadData() async {
    try {
      var driverDoc = await FirebaseFirestore.instance
          .collection('drivers')
          .doc('DRV001')
          .get();

      if (!driverDoc.exists) {
        setState(() {
          errorMessage = "❌ Driver not found";
        });
        return;
      }

      var driverData = driverDoc.data();

      if (driverData == null || driverData['truckId'] == null) {
        setState(() {
          errorMessage = "❌ truckId missing";
        });
        return;
      }

      String truckId = driverData['truckId'];

      FirebaseFirestore.instance
          .collection('trucks')
          .doc(truckId)
          .snapshots()
          .listen((snapshot) {

        if (!snapshot.exists) {
          setState(() {
            errorMessage = "❌ Truck not found";
          });
          return;
        }

        setState(() {
          driver = driverData;
          truck = snapshot.data();
          errorMessage = "";
        });
      });

    } catch (e) {
      setState(() {
        errorMessage = "❌ Error: $e";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(errorMessage,
              style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    if (driver == null || truck == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    double progress = 0.6;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      body: Column(
        children: [

          // 🔥 HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(35),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("🚛 Dashboard",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),

                    const SizedBox(height: 6),

                    Text("${driver!['name']}",
                        style: const TextStyle(color: Colors.white70)),

                    Text("Truck: ${driver!['truckId']}",
                        style: const TextStyle(color: Colors.white70)),

                    Text("Status: ${truck!['status']}",
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),

          // 🔥 CONTENT
          Expanded(
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [

                    // 🚛 ROUTE CARD
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("📍 Current Route",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const SizedBox(height: 10),

                          Text("Route: ${truck!['route']}"),
                          Text("Truck: ${driver!['truckId']}"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 📊 STATS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _animatedStat(Icons.speed,
                            "${truck!['speed']} km/h", "Speed"),
                        _animatedStat(Icons.local_gas_station,
                            "${truck!['fuel']}%", "Fuel"),
                        _animatedStat(Icons.access_time,
                            truck!['eta'], "ETA"),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 📈 PROGRESS
                    _glassCard(
                      child: Column(
                        children: [
                          const Text("Trip Progress",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold)),

                          const SizedBox(height: 15),

                          TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: progress),
                            duration: const Duration(seconds: 1),
                            builder: (context, double value, _) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: CircularProgressIndicator(
                                      value: value,
                                      strokeWidth: 10,
                                      backgroundColor:
                                      Colors.grey.shade300,
                                    ),
                                  ),
                                  Text(
                                    "${(value * 100).toInt()}%",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 📦 SUMMARY
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Trip Summary",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const SizedBox(height: 10),

                          _row("Route", truck!['route']),
                          _row("ETA", truck!['eta']),
                          _row("Status", truck!['status']),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 GLASS CARD
  Widget _glassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            Colors.white.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: child,
    );
  }

  // 🔥 ANIMATED STAT
  Widget _animatedStat(IconData icon, String value, String label) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: _statCard(icon, value, label),
        );
      },
    );
  }

  Widget _statCard(IconData icon, String value, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // 🔹 ROW
  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}