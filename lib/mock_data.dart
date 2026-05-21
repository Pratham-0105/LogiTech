// lib/mock_data.dart

final List<Map<String, dynamic>> COMPANIES = [
  {
    "id": "CMP001",
    "name": "Sharma Logistics Pvt Ltd",
    "location": "Mumbai",
    "fleet_size": 12,
    "manager_id": "MGR001",
    "status": "Active",
    "email": "sharma.logistics@email.com",
    "phone": "9821001001"
  },
  {
    "id": "CMP002",
    "name": "Patel Transport Co",
    "location": "Ahmedabad",
    "fleet_size": 8,
    "manager_id": "MGR002",
    "status": "Active",
    "email": "patel.transport@email.com",
    "phone": "9824002002"
  },
  {"id": "CMP003", "name": "Verma Freight Services", "location": "Delhi", "fleet_size": 15, "manager_id": "MGR003", "status": "Active", "email": "verma.freight@email.com", "phone": "9811003003"},
  {"id": "CMP004", "name": "Rajput Cargo Solutions", "location": "Indore", "fleet_size": 6, "manager_id": "MGR004", "status": "Active", "email": "rajput.cargo@email.com", "phone": "9826004004"},
  {"id": "CMP005", "name": "Singh Express Logistics", "location": "Pune", "fleet_size": 10, "manager_id": "MGR005", "status": "Inactive", "email": "singh.express@email.com", "phone": "9820005005"},
  {"id": "CMP006", "name": "Malviya Road Carriers", "location": "Bhopal", "fleet_size": 9, "manager_id": "MGR006", "status": "Active", "email": "malviya.carriers@email.com", "phone": "9827006006"},
];


final List<Map<String, dynamic>> MANAGERS = [
  {
    "id": "MGR001",
    "name": "Rakesh Sharma",
    "email": "rakesh.sharma@nexus.com",
    "phone": "9821011001",
    "company_id": "CMP001",
    "status": "Active"
  },
  {"id": "MGR002", "name": "Sunil Patel",     "email": "sunil.patel@nexus.com",     "phone": "9824022002", "company_id": "CMP002", "status": "Active"},
{"id": "MGR003", "name": "Anil Verma",      "email": "anil.verma@nexus.com",      "phone": "9811033003", "company_id": "CMP003", "status": "Active"},
{"id": "MGR004", "name": "Vikram Rajput",   "email": "vikram.rajput@nexus.com",   "phone": "9826044004", "company_id": "CMP004", "status": "Active"},
{"id": "MGR005", "name": "Gurpreet Singh",  "email": "gurpreet.singh@nexus.com",  "phone": "9820055005", "company_id": "CMP005", "status": "Inactive"},
{"id": "MGR006", "name": "Deepak Malviya",  "email": "deepak.malviya@nexus.com",  "phone": "9827066006", "company_id": "CMP006", "status": "Active"},


];

final List<Map<String, dynamic>> DEVICES = [
  {
    "id": "NEXUS-KIT-001",
    "type": "ESP32 Sensor Kit",
    "status": "Active",
    "company_id": "CMP001",
    "truck_id": "TRK-101"
  },
  {"id": "NEXUS-KIT-002", "type": "ESP32 Sensor Kit", "status": "Active",  "company_id": "CMP001", "truck_id": "TRK-102"},
  {"id": "NEXUS-KIT-003", "type": "ESP32 Sensor Kit", "status": "Active",  "company_id": "CMP002", "truck_id": "TRK-201"},
  {"id": "NEXUS-KIT-004", "type": "ESP32 Sensor Kit", "status": "Idle",    "company_id": "CMP002", "truck_id": "TRK-202"},
  {"id": "NEXUS-KIT-005", "type": "ESP32 Sensor Kit", "status": "Active",  "company_id": "CMP003", "truck_id": "TRK-301"},
  {"id": "NEXUS-KIT-006", "type": "ESP32 Sensor Kit", "status": "Offline", "company_id": "CMP003", "truck_id": "TRK-302"},
  {"id": "NEXUS-KIT-007", "type": "ESP32 Sensor Kit", "status": "Active",  "company_id": "CMP004", "truck_id": "TRK-401"},
  {"id": "NEXUS-KIT-008", "type": "ESP32 Sensor Kit", "status": "Active",  "company_id": "CMP005", "truck_id": "TRK-501"},
  {"id": "NEXUS-KIT-009", "type": "ESP32 Sensor Kit", "status": "Active",  "company_id": "CMP006", "truck_id": "TRK-601"},
  {"id": "NEXUS-KIT-010", "type": "ESP32 Sensor Kit", "status": "Idle",    "company_id": "CMP006", "truck_id": "TRK-602"},

];

final List<Map<String, dynamic>> DRIVERS = [
  {
    "id": "DRV001",
    "username": "DRV001",
    "password": "1234",
    "name": "Suresh Patel",
    "phone": "9898001001",
    "company_id": "CMP001",
    "truck_id": "TRK-101",
    "rating": 4.5,
    "prior_delays": 2
  },
  {
    "id": "DRV002",
    "username": "DRV002",
    "password": "1234",
    "name": "Ramesh Verma",
    "phone": "9898002002",
    "company_id": "CMP001",
    "truck_id": "TRK-102",
    "rating": 4.2,
    "prior_delays": 4
  },
  {
    "id": "DRV003",
    "username": "DRV003",
    "password": "1234",
    "name": "Anil Chouhan",
    "phone": "9898003003",
    "company_id": "CMP002",
    "truck_id": "TRK-201",
    "rating": 4.7,
    "prior_delays": 1
  },
  {
    "id": "DRV004",
    "username": "DRV004",
    "password": "1234",
    "name": "Vijay Malviya",
    "phone": "9898004004",
    "company_id": "CMP002",
    "truck_id": "TRK-202",
    "rating": 3.9,
    "prior_delays": 6
  },
  {
    "id": "DRV005",
    "username": "DRV005",
    "password": "1234",
    "name": "Deepak Rathore",
    "phone": "9898005005",
    "company_id": "CMP003",
    "truck_id": "TRK-301",
    "rating": 4.6,
    "prior_delays": 2
  },
  {
    "id": "DRV006",
    "username": "DRV006",
    "password": "1234",
    "name": "Manoj Tiwari",
    "phone": "9898006006",
    "company_id": "CMP003",
    "truck_id": "TRK-302",
    "rating": 4.1,
    "prior_delays": 3
  },
  {
    "id": "DRV007",
    "username": "DRV007",
    "password": "1234",
    "name": "Rajesh Kumar",
    "phone": "9898007007",
    "company_id": "CMP004",
    "truck_id": "TRK-401",
    "rating": 4.8,
    "prior_delays": 0
  },
  {
    "id": "DRV008",
    "username": "DRV008",
    "password": "1234",
    "name": "Dinesh Yadav",
    "phone": "9898008008",
    "company_id": "CMP005",
    "truck_id": "TRK-501",
    "rating": 4.3,
    "prior_delays": 5
  },
  {
    "id": "DRV009",
    "username": "DRV009",
    "password": "1234",
    "name": "Prakash Joshi",
    "phone": "9898009009",
    "company_id": "CMP006",
    "truck_id": "TRK-601",
    "rating": 4.4,
    "prior_delays": 3
  },
  {
    "id": "DRV010",
    "username": "DRV010",
    "password": "1234",
    "name": "Santosh Pandey",
    "phone": "9898010010",
    "company_id": "CMP006",
    "truck_id": "TRK-602",
    "rating": 4.0,
    "prior_delays": 7
  },
];

final List<Map<String, dynamic>> TRUCKS = [
  {
    "id": "TRK-101",
    "driver_id": "DRV001",
    "company_id": "CMP001",
    "device_id": "NEXUS-KIT-001",
    "route": "Mumbai → Pune",
    "origin": "Mumbai",
    "destination": "Pune",
    "origin_lat": 19.0760,
    "origin_lng": 72.8777,
    "dest_lat": 18.5204,
    "dest_lng": 73.8567,
    "current_lat": 18.9,
    "current_lng": 73.2,
    "status": "On Time",
    "eta": "5:30 PM",
    "speed": 72,
    "fuel": 68
  },
  {"id": "TRK-102", "driver_id": "DRV002", "company_id": "CMP001", "device_id": "NEXUS-KIT-002",
    "route": "Mumbai → Nashik",      "origin": "Mumbai",   "destination": "Nashik",
    "origin_lat": 19.0760, "origin_lng": 72.8777, "dest_lat": 20.0059, "dest_lng": 73.7898,
    "current_lat": 19.5000, "current_lng": 73.3000,
    "status": "Delayed",   "eta": "7:45 PM", "speed": 45, "fuel": 38,
    "cargo_temp": 9.2,  "humidity": 74, "door": "Closed", "battery": 61,
    "distance_km": 167, "traffic_level": 3, "weather_condition": 2},

  {"id": "TRK-201", "driver_id": "DRV003", "company_id": "CMP002", "device_id": "NEXUS-KIT-003",
    "route": "Ahmedabad → Surat",    "origin": "Ahmedabad","destination": "Surat",
    "origin_lat": 23.0225, "origin_lng": 72.5714, "dest_lat": 21.1702, "dest_lng": 72.8311,
    "current_lat": 22.3000, "current_lng": 72.7000,
    "status": "On Time",   "eta": "4:15 PM", "speed": 78, "fuel": 71,
    "cargo_temp": 4.8,  "humidity": 58, "door": "Closed", "battery": 90,
    "distance_km": 265, "traffic_level": 1, "weather_condition": 1},

  {"id": "TRK-202", "driver_id": "DRV004", "company_id": "CMP002", "device_id": "NEXUS-KIT-004",
    "route": "Surat → Vadodara",     "origin": "Surat",    "destination": "Vadodara",
    "origin_lat": 21.1702, "origin_lng": 72.8311, "dest_lat": 22.3072, "dest_lng": 73.1812,
    "current_lat": 21.8000, "current_lng": 73.0000,
    "status": "En Route",  "eta": "6:00 PM", "speed": 64, "fuel": 52,
    "cargo_temp": 6.1,  "humidity": 65, "door": "Closed", "battery": 74,
    "distance_km": 141, "traffic_level": 2, "weather_condition": 1},

  {"id": "TRK-301", "driver_id": "DRV005", "company_id": "CMP003", "device_id": "NEXUS-KIT-005",
    "route": "Delhi → Agra",         "origin": "Delhi",    "destination": "Agra",
    "origin_lat": 28.6139, "origin_lng": 77.2090, "dest_lat": 27.1767, "dest_lng": 78.0081,
    "current_lat": 27.9000, "current_lng": 77.6000,
    "status": "On Time",   "eta": "3:45 PM", "speed": 85, "fuel": 79,
    "cargo_temp": 3.2,  "humidity": 55, "door": "Closed", "battery": 88,
    "distance_km": 206, "traffic_level": 2, "weather_condition": 1},

  {"id": "TRK-302", "driver_id": "DRV006", "company_id": "CMP003", "device_id": "NEXUS-KIT-006",
    "route": "Delhi → Jaipur",       "origin": "Delhi",    "destination": "Jaipur",
    "origin_lat": 28.6139, "origin_lng": 77.2090, "dest_lat": 26.9124, "dest_lng": 75.7873,
    "current_lat": 27.8000, "current_lng": 76.5000,
    "status": "Delayed",   "eta": "8:20 PM", "speed": 38, "fuel": 22,
    "cargo_temp": 11.5, "humidity": 78, "door": "Open",   "battery": 45,
    "distance_km": 281, "traffic_level": 3, "weather_condition": 3},

  {"id": "TRK-401", "driver_id": "DRV007", "company_id": "CMP004", "device_id": "NEXUS-KIT-007",
    "route": "Indore → Bhopal",      "origin": "Indore",   "destination": "Bhopal",
    "origin_lat": 22.7196, "origin_lng": 75.8577, "dest_lat": 23.2599, "dest_lng": 77.4126,
    "current_lat": 22.9500, "current_lng": 76.5000,
    "status": "On Time",   "eta": "4:50 PM", "speed": 76, "fuel": 88,
    "cargo_temp": 5.0,  "humidity": 60, "door": "Closed", "battery": 95,
    "distance_km": 187, "traffic_level": 1, "weather_condition": 1},

  {"id": "TRK-501", "driver_id": "DRV008", "company_id": "CMP005", "device_id": "NEXUS-KIT-008",
    "route": "Pune → Mumbai",        "origin": "Pune",     "destination": "Mumbai",
    "origin_lat": 18.5204, "origin_lng": 73.8567, "dest_lat": 19.0760, "dest_lng": 72.8777,
    "current_lat": 18.8000, "current_lng": 73.2000,
    "status": "En Route",  "eta": "6:30 PM", "speed": 68, "fuel": 55,
    "cargo_temp": 7.1,  "humidity": 63, "door": "Closed", "battery": 78,
    "distance_km": 149, "traffic_level": 2, "weather_condition": 2},

  {"id": "TRK-601", "driver_id": "DRV009", "company_id": "CMP006", "device_id": "NEXUS-KIT-009",
    "route": "Bhopal → Indore",      "origin": "Bhopal",   "destination": "Indore",
    "origin_lat": 23.2599, "origin_lng": 77.4126, "dest_lat": 22.7196, "dest_lng": 75.8577,
    "current_lat": 23.0000, "current_lng": 76.8000,
    "status": "On Time",   "eta": "5:10 PM", "speed": 71, "fuel": 63,
    "cargo_temp": 4.5,  "humidity": 59, "door": "Closed", "battery": 85,
    "distance_km": 187, "traffic_level": 1, "weather_condition": 1},

  {"id": "TRK-602", "driver_id": "DRV010", "company_id": "CMP006", "device_id": "NEXUS-KIT-010",
    "route": "Indore → Ujjain",      "origin": "Indore",   "destination": "Ujjain",
    "origin_lat": 22.7196, "origin_lng": 75.8577, "dest_lat": 23.1793, "dest_lng": 75.7849,
    "current_lat": 22.9000, "current_lng": 75.8000,
    "status": "Delayed",   "eta": "7:00 PM", "speed": 42, "fuel": 18,
    "cargo_temp": 8.8,  "humidity": 71, "door": "Closed", "battery": 52,
    "distance_km": 55,  "traffic_level": 3, "weather_condition": 2},

];

final List<Map<String, dynamic>> ALERTS = [
  {
    "id": "ALT001",
    "truck_id": "TRK-101",
    "type": "Fuel Low",
    "message": "Fuel level low",
    "severity": "Warning",
    "timestamp": "2026-03-17 14:32:00"
  },

{"id": "ALT002", "company": "Verma Freight",     "truck_id": "TRK-302", "type": "Cold Chain Breach",  "message": "Cargo temp 11.5°C — cold chain compromised",     "severity": "Critical", "timestamp": "2026-03-17 14:28:00"},
{"id": "ALT003", "company": "Verma Freight",     "truck_id": "TRK-302", "type": "Fuel Low Warning",   "message": "Fuel level 22% — immediate refueling required",  "severity": "Warning",  "timestamp": "2026-03-17 14:15:00"},
{"id": "ALT004", "company": "Malviya Carriers",  "truck_id": "TRK-602", "type": "Fuel Low Warning",   "message": "Fuel level 18% — critical fuel level",           "severity": "Critical", "timestamp": "2026-03-17 13:58:00"},
{"id": "ALT005", "company": "Verma Freight",     "truck_id": "TRK-302", "type": "Door Open Alert",    "message": "Cargo door opened at Jaipur bypass",             "severity": "Warning",  "timestamp": "2026-03-17 13:45:00"},
{"id": "ALT006", "company": "Verma Freight",     "truck_id": "TRK-302", "type": "Route Deviation",    "message": "Truck deviated 2.1km from planned route",        "severity": "Warning",  "timestamp": "2026-03-17 13:30:00"},
{"id": "ALT007", "company": "Sharma Logistics",  "truck_id": "TRK-102", "type": "Delivery Delay",     "message": "AI predicts 45 min delay — heavy traffic NH-60", "severity": "Info",     "timestamp": "2026-03-17 13:10:00"},
{"id": "ALT008", "company": "Malviya Carriers",  "truck_id": "TRK-602", "type": "Delivery Delay",     "message": "AI predicts 30 min delay — low fuel + traffic",  "severity": "Info",     "timestamp": "2026-03-17 12:55:00"},
];
// -------------------------
// ANALYTICS
// -------------------------

final List<Map<String, dynamic>> TRIPS_PER_DAY = [
  {"day": "Mon", "trips": 112},
  {"day": "Tue", "trips": 128},
  {"day": "Wed", "trips": 135},
  {"day": "Thu", "trips": 119},
  {"day": "Fri", "trips": 142},
  {"day": "Sat", "trips": 98},
  {"day": "Sun", "trips": 76},
];

final List<Map<String, dynamic>> CARBON_EMISSIONS = [
  {"month": "Oct", "emitted": 4800, "saved": 620},
  {"month": "Nov", "emitted": 4600, "saved": 680},
  {"month": "Dec", "emitted": 5100, "saved": 590},
  {"month": "Jan", "emitted": 4900, "saved": 710},
  {"month": "Feb", "emitted": 4700, "saved": 740},
  {"month": "Mar", "emitted": 4400, "saved": 780},
];

final List<Map<String, dynamic>> FLEET_GROWTH = [
  {"month": "Oct", "trucks": 38},
  {"month": "Nov", "trucks": 41},
  {"month": "Dec", "trucks": 43},
  {"month": "Jan", "trucks": 45},
  {"month": "Feb", "trucks": 47},
  {"month": "Mar", "trucks": 50},
];
// lib/mock_data.dart

