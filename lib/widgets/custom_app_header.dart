import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/placeholders/account_screen.dart';

// It's good practice to define constants used in the widget here
const Color profileIconColor = Color(0xFFCE3D7C);

// This is a helper widget to load the local profile picture
class LocalProfilePicture extends StatefulWidget {
  final String? userId;
  final double radius;
  const LocalProfilePicture({super.key, required this.userId, this.radius = 20});

  @override
  State<LocalProfilePicture> createState() => _LocalProfilePictureState();
}

class _LocalProfilePictureState extends State<LocalProfilePicture> {
  File? _profileImageFile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  @override
  void didUpdateWidget(covariant LocalProfilePicture oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userId != oldWidget.userId) {
      _loadProfileImage();
    }
  }

  Future<void> _loadProfileImage() async {
    setState(() => _isLoading = true);
    if (widget.userId == null) {
      setState(() {
        _isLoading = false;
        _profileImageFile = null;
      });
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_picture_${widget.userId}');
    File? imageFile;
    if (imagePath != null) {
      final file = File(imagePath);
      if (await file.exists()) {
        imageFile = file;
      }
    }
    if (mounted) {
      setState(() {
        _profileImageFile = imageFile;
        _isLoading = false;
      });
    }
  }

  ImageProvider _getProvider() {
    if (_profileImageFile != null) {
      return FileImage(_profileImageFile!);
    }
    return const AssetImage('assets/placeholder_profile.png');
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: Colors.white,
      backgroundImage: _isLoading ? null : _getProvider(),
      child: _isLoading ? const CircularProgressIndicator(strokeWidth: 2) : null,
    );
  }
}


class CustomAppHeader extends StatefulWidget {
  const CustomAppHeader({super.key});

  @override
  State<CustomAppHeader> createState() => _CustomAppHeaderState();
}

class _CustomAppHeaderState extends State<CustomAppHeader> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  /// Fetches the current user from FirebaseAuth and updates the state.
  void _loadCurrentUser() {
    // Using authStateChanges() is better as it listens for login/logout events
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // A light pink color to be used for the background, similar to the design.
    const Color lightPinkBackground = Color(0xFFFFD4E7);

    // Safely get the user's first name, with fallbacks.
    final String firstName = _currentUser?.displayName?.split(' ').firstWhere((s) => s.isNotEmpty, orElse: () => 'There') ?? 'There';

    return Container(
      padding: EdgeInsets.fromLTRB(
          24, MediaQuery.of(context).padding.top + 10, 24, 20),
      decoration: BoxDecoration(
        color: lightPinkBackground,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // Display the dynamic user name
                'Hi, $firstName!',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF3F3F3F),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Land the Job You Deserve',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF8C8C8C),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const AccountScreen())),
            // --- FIX: Using the new LocalProfilePicture widget ---
            child: LocalProfilePicture(userId: _currentUser?.uid, radius: 20),
          ),
        ],
      ),
    );
  }
}

