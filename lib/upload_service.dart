import 'package:cloud_firestore/cloud_firestore.dart';
import 'mock_data.dart';

Future<void> uploadAllMockData() async {
  final db = FirebaseFirestore.instance;

  print("🚀 Uploading FULL dataset...");

  // -------------------------
  // COMPANIES
  // -------------------------
  for (var c in COMPANIES) {
    await db.collection('companies').doc(c['id']).set({
      "name": c["name"],
      "location": c["location"],
      "fleetSize": c["fleet_size"],
      "managerId": c["manager_id"],
      "status": c["status"],
      "email": c["email"],
      "phone": c["phone"],
    });
  }

  // -------------------------
  // MANAGERS
  // -------------------------
  for (var m in MANAGERS) {
    await db.collection('managers').doc(m['id']).set({
      "name": m["name"],
      "email": m["email"],
      "phone": m["phone"],
      "companyId": m["company_id"],
      "status": m["status"],
    });
  }

  // -------------------------
  // DEVICES
  // -------------------------
  for (var d in DEVICES) {
    await db.collection('devices').doc(d['id']).set({
      "type": d["type"],
      "status": d["status"],
      "companyId": d["company_id"],
      "truckId": d["truck_id"],
    });
  }

  // -------------------------
  // DRIVERS
  // -------------------------
  for (var d in DRIVERS) {
    await db.collection('drivers').doc(d['id']).set({
      "id": d["id"],

      // 🔐 LOGIN FIELDS (IMPORTANT)
      "username": d["username"],
      "password": d["password"],

      // 👤 DRIVER INFO
      "name": d["name"],
      "phone": d["phone"],

      // 🏢 COMPANY + TRUCK
      "companyId": d["company_id"],
      "truckId": d["truck_id"],

      // 📊 STATS
      "rating": d["rating"],
      "priorDelays": d["prior_delays"],
    });
  }
  // -------------------------
  // TRUCKS
  // -------------------------
  for (var t in TRUCKS) {
    await db.collection('trucks').doc(t['id']).set({
      "driverId": t["driver_id"],
      "companyId": t["company_id"],
      "deviceId": t["device_id"],

      "route": t["route"],
      "origin": t["origin"],
      "destination": t["destination"],

      "originLat": t["origin_lat"],
      "originLng": t["origin_lng"],
      "destinationLat": t["dest_lat"],
      "destinationLng": t["dest_lng"],

      "currentLat": t["current_lat"],
      "currentLng": t["current_lng"],

      "status": t["status"],
      "eta": t["eta"],

      "speed": t["speed"],
      "fuel": t["fuel"],

      "cargoTemp": t["cargo_temp"],
      "humidity": t["humidity"],
      "door": t["door"],
      "battery": t["battery"],

      "distanceKm": t["distance_km"],
      "trafficLevel": t["traffic_level"],
      "weatherCondition": t["weather_condition"],
    });
  }

  // -------------------------
  // ALERTS
  // -------------------------
  for (var a in ALERTS) {
    await db.collection('alerts').doc(a['id']).set({
      "truckId": a["truck_id"],
      "company": a["company"],
      "type": a["type"],
      "message": a["message"],
      "severity": a["severity"],
      "timestamp": a["timestamp"],
    });
  }

  // -------------------------
  // ANALYTICS
  // -------------------------

  for (var t in TRIPS_PER_DAY) {
    await db.collection('trips_per_day').doc(t['day']).set({
      "trips": t["trips"],
    });
  }

  for (var c in CARBON_EMISSIONS) {
    await db.collection('carbon_emissions').doc(c['month']).set({
      "emitted": c["emitted"],
      "saved": c["saved"],
    });
  }

  for (var f in FLEET_GROWTH) {
    await db.collection('fleet_growth').doc(f['month']).set({
      "trucks": f["trucks"],
    });
  }

  print("✅ FULL DATA UPLOADED SUCCESSFULLY");
}