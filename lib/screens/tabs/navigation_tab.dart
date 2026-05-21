import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NavigationTab extends StatefulWidget {
  const NavigationTab({super.key});

  @override
  State<NavigationTab> createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {

  GoogleMapController? mapController;

  final LatLng startLocation = const LatLng(19.0760, 72.8777);
  final LatLng destination = const LatLng(18.5204, 73.8567);

  List<LatLng> polylineCoordinates = [];

  Location location = Location();
  LatLng? liveLocation;

  FlutterTts tts = FlutterTts();

  double currentBearing = 0;

  String nextDirection = "Turn Right";
  String nextDistance = "500 m";
  IconData directionIcon = Icons.turn_right;

  @override
  void initState() {
    super.initState();

    _getPolyline();
    _startTracking();
    _simulateNavigation();

    tts.setLanguage("en-US");
    tts.setSpeechRate(0.5);
  }

  // 🔥 GET ROUTE
  Future<void> _getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineRequest request = PolylineRequest(
      origin: PointLatLng(startLocation.latitude, startLocation.longitude),
      destination: PointLatLng(destination.latitude, destination.longitude),
      mode: TravelMode.driving,
    );

    PolylineResult result =
    await polylinePoints.getRouteBetweenCoordinates(
      request: request,
      googleApiKey: "AlzaSyDAUUNUt4ONtwA3jMCuRdspf4jcJ16WTcc",
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }

  // 🚗 LIVE TRACKING + ROTATION
  void _startTracking() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {

        double bearing = currentLocation.heading ?? 0;

        setState(() {
          liveLocation = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!,
          );
          currentBearing = bearing;
        });

        // 🎯 CAMERA FOLLOW + ROTATION
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: liveLocation!,
              zoom: 17,
              tilt: 60,
              bearing: currentBearing,
            ),
          ),
        );
      }
    });
  }

  // 🔊 SPEAK
  Future<void> _speak(String text) async {
    await tts.speak(text);
  }

  // 🔄 SIMULATION
  void _simulateNavigation() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        nextDirection = "Go Straight";
        nextDistance = "1 km";
        directionIcon = Icons.straight;
      });

      _speak("Go straight for 1 kilometer");
    });

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        nextDirection = "Turn Left";
        nextDistance = "300 m";
        directionIcon = Icons.turn_left;
      });

      _speak("Turn left in 300 meters");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 🗺️ MAP
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: startLocation,
              zoom: 10,
            ),
            onMapCreated: (controller) {
              mapController = controller;
            },

            markers: {
              if (liveLocation != null)
                Marker(
                  markerId: const MarkerId("live"),
                  position: liveLocation!,
                  rotation: currentBearing,
                  anchor: const Offset(0.5, 0.5),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                ),

              Marker(
                markerId: const MarkerId("destination"),
                position: destination,
              ),
            },

            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 6,
              ),
            },
          ),

          // 🔝 TOP NAV CARD
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: _topCard(),
          ),

          // 🔻 BOTTOM PANEL
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: _bottomCard(),
          ),
        ],
      ),
    );
  }

  // 🔹 TOP CARD
  Widget _topCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 8),
        ],
      ),
      child: Row(
        children: [

          Icon(directionIcon, size: 32, color: Colors.blue),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nextDirection,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text("In $nextDistance"),
              ],
            ),
          ),

          Text(
            nextDistance,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 BOTTOM PANEL
  Widget _bottomCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3A7BD5), Color(0xFF6A11CB)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              InfoItem("ETA", "1h 20m"),
              InfoItem("Distance", "60 km"),
              InfoItem("Traffic", "Heavy"),
            ],
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Take Alternate Route"),
          ),
        ],
      ),
    );
  }
}

// 🔹 INFO ITEM
class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}