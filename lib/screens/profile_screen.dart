import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

import '../services/firebase_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseService _service = FirebaseService();

  bool isNotificationOn = true;

  // 🔥 IMAGE PICKER OPTIONS
  Future<void> _showImagePickerOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Cancel"),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 PICK IMAGE (SAFE)
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile =
      await picker.pickImage(source: source);

      if (pickedFile != null) {
        File file = File(pickedFile.path);

        await _service.uploadProfileImage(file);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile image updated"),
            ),
          );
        }
      }
    } catch (e) {
      print("Image Picker Error: $e");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to pick image"),
          ),
        );
      }
    }
  }

  // 🔹 EDIT PROFILE
  void _editProfile(String name, String phone) {
    TextEditingController nameCtrl =
    TextEditingController(text: name);
    TextEditingController phoneCtrl =
    TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Profile"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await _service.updateProfile(
                nameCtrl.text,
                phoneCtrl.text,
              );
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // 🔹 CHANGE PASSWORD
  void _changePassword() {
    TextEditingController passCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Change Password"),
        content: TextField(
          controller: passCtrl,
          obscureText: true,
          decoration:
          const InputDecoration(labelText: "New Password"),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.currentUser!
                  .updatePassword(passCtrl.text);
              Navigator.pop(context);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  // 🔹 LOGOUT
  void _logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _service.getDriverProfile(),
      builder: (context, snapshot) {

        // 🔄 LOADING
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ NO DATA
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text("No Profile Found")),
          );
        }

        var data =
        snapshot.data!.data() as Map<String, dynamic>;

        String name = data['name'] ?? "No Name";
        String phone = data['phone'] ?? "No Phone";
        String driverId = data['id'] ?? "No ID";

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: Column(
            children: [

              // 🔥 HEADER
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.fromLTRB(20, 50, 20, 25),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6A11CB),
                      Color(0xFF2575FC)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [

                    Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    // 🔥 PROFILE IMAGE + EDIT ICON
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: data['image'] != null
                                ? MemoryImage(
                                base64Decode(data['image']))
                                : const AssetImage(
                                "assets/profile.png")
                            as ImageProvider,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _showImagePickerOptions,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Driver ID: $driverId",
                      style:
                      const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 BODY
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [

                    Row(
                      children: [
                        Expanded(child: _statCard("Trips", "128")),
                        const SizedBox(width: 10),
                        Expanded(child: _statCard("Rating", "4.5 ⭐")),
                      ],
                    ),

                    const SizedBox(height: 15),

                    _sectionCard(
                      title: "Vehicle Info",
                      children: const [
                        ListTile(
                          leading: Icon(Icons.local_shipping),
                          title: Text("Truck Number"),
                          subtitle: Text("TRK-101"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    _sectionCard(
                      title: "Settings",
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text("Edit Profile"),
                          onTap: () =>
                              _editProfile(name, phone),
                        ),
                        ListTile(
                          leading: const Icon(Icons.lock),
                          title:
                          const Text("Change Password"),
                          onTap: _changePassword,
                        ),
                        SwitchListTile(
                          value: isNotificationOn,
                          onChanged: (val) {
                            setState(() {
                              isNotificationOn = val;
                            });
                          },
                          title:
                          const Text("Notifications"),
                          secondary:
                          const Icon(Icons.notifications),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize:
                        const Size(double.infinity, 50),
                      ),
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 STAT CARD
  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value,
              style: const TextStyle(
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(title),
        ],
      ),
    );
  }

  // 🔹 SECTION CARD
  Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const Divider(),
          ...children,
        ],
      ),
    );
  }
}