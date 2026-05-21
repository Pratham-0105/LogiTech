import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:io';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String driverId = "DRV001";

  // 🔹 Get Profile
  Stream<DocumentSnapshot> getDriverProfile() {
    return _db.collection('drivers').doc(driverId).snapshots();
  }

  // 🔹 Update Profile
  Future<void> updateProfile(String name, String phone) async {
    await _db.collection('drivers').doc(driverId).update({
      'name': name,
      'phone': phone,
    });
  }

  // 🔥 Upload Image as Base64
  Future<void> uploadProfileImage(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    await _db.collection('drivers').doc(driverId).update({
      'image': base64Image,
    });
  }
}