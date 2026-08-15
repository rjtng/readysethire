import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:readysethire/models/resume_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_theme.dart';
import '../../widgets/gradient_background.dart' show GradientBackground;
import 'Resume/basic_info_screen.dart';



// --- Account Screen ---
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isEditing = false;
  bool _isSaving = false;
  bool _isUploadingPicture = false;

  User? _currentUser;
  File? _profileImageFile; // To hold the image from local storage or picker

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    // Listen for auth changes to keep data fresh
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (mounted) {
        setState(() {
          _currentUser = user;
          if (_currentUser != null) {
            _emailController.text = _currentUser!.email ?? 'No Email Provided';
            _fullNameController.text = _currentUser!.displayName ?? '';
            _loadProfileImage(); // Load local image after getting user
          }
        });
      }
    });
  }

  Future<void> _loadProfileImage() async {
    if (_currentUser == null) return;
    final prefs = await SharedPreferences.getInstance();
    // Use a user-specific key to store the image path
    final imagePath = prefs.getString('profile_picture_${_currentUser!.uid}');
    if (imagePath != null && mounted) {
      final imageFile = File(imagePath);
      if (await imageFile.exists()) {
        setState(() {
          _profileImageFile = imageFile;
        });
      }
    }
  }

  // Copies the picked image to a permanent directory on the device
  Future<File> _copyImageToAppDirectory(File sourceFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(sourceFile.path);
    final copiedFile = File('${appDir.path}/$fileName');
    return await sourceFile.copy(copiedFile.path);
  }

  Future<void> _saveProfileChanges() async {
    if (_currentUser == null) return;
    setState(() => _isSaving = true);

    try {
      // If a new image was picked, copy it and save its path
      if (_profileImageFile != null) {
        // Ensure the file path is not the same as the one stored to avoid unnecessary copies
        final prefs = await SharedPreferences.getInstance();
        final storedPath = prefs.getString('profile_picture_${_currentUser!.uid}');
        if (storedPath != _profileImageFile!.path) {
          final permanentImage = await _copyImageToAppDirectory(_profileImageFile!);
          await prefs.setString('profile_picture_${_currentUser!.uid}', permanentImage.path);
        }
      }

      final fullName = _fullNameController.text.trim();

      // Update Firebase Auth profile (name only)
      await _currentUser!.updateDisplayName(fullName);

      // Update Firestore document (without photoURL)
      // Split fullName into first and last for Firestore fields (best-effort)
      final parts = fullName.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
      final firstName = parts.isNotEmpty ? parts.first : '';
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'displayName': fullName,
        'email': _currentUser!.email,
      }, SetOptions(merge: true));

      await _currentUser!.reload();
      if(mounted) {
        setState(() {
          _isEditing = false;
        });
        _loadUserData();
      }

      // Also sync full name and email into the resume provider so BasicInfoScreen shows them
      try {
        final provider = Provider.of<ResumeDataProvider>(context, listen: false);
        provider.updateBasicInfo(
          fullName: fullName,
          contact: provider.resumeData.contactNumber,
          email: _currentUser!.email ?? provider.resumeData.emailAddress,
          address: provider.resumeData.address,
          summary: provider.resumeData.professionalSummary,
        );
      } catch (_) {
        // Non-fatal: provider might not be available in some contexts
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e'), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // This method now just picks the image and holds it in the state
  Future<void> _pickImage() async {
    setState(() => _isUploadingPicture = true);
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 90,
      );

      if (pickedFile != null && mounted) {
        setState(() {
          _profileImageFile = File(pickedFile.path);
        });
      }
    } catch(e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e'), backgroundColor: Colors.redAccent),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploadingPicture = false);
    }
  }

  // --- FIX: This method now uses a local asset as the fallback ---
  ImageProvider _getProfileImageProvider() {
    // Display the local file image if it exists
    if (_profileImageFile != null) {
      return FileImage(_profileImageFile!);
    }
    // Fallback to the local asset image to prevent network errors
    return const AssetImage('assets/placeholder_profile.png');
  }

  void _showChangePasswordDialog() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
    bool isCurrentPasswordVisible = false;
    bool isNewPasswordVisible = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Change Password'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTextField(
                      label: 'Current Password',
                      controller: _currentPasswordController,
                      obscureText: !isCurrentPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(isCurrentPasswordVisible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setDialogState(() => isCurrentPasswordVisible = !isCurrentPasswordVisible),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'New Password',
                      controller: _newPasswordController,
                      obscureText: !isNewPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(isNewPasswordVisible ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => setDialogState(() => isNewPasswordVisible = !isNewPasswordVisible),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Confirm New Password',
                      controller: _confirmPasswordController,
                      obscureText: !isNewPasswordVisible,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
                ElevatedButton(onPressed: _changePassword, child: const Text('Update')),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _changePassword() async {
    FocusScope.of(context).unfocus();
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match.'), backgroundColor: Colors.redAccent),
      );
      return;
    }
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || user.email == null) throw Exception('User not found.');
      AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: _currentPasswordController.text);
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(_newPasswordController.text);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed successfully!'), backgroundColor: Colors.green),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = e.code == 'wrong-password' ? 'The current password is incorrect.' : 'An error occurred.';
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change password: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: const Text('Account'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: AppTheme.fontColor),
              label: const Text('Log Out', style: TextStyle(color: AppTheme.fontColor)),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
        ],
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 120, 24, 24),
          child: Column(
            children: [
              Text('Manage your account information',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.fontColor.withAlpha(179))),
              const SizedBox(height: 16),
              const Divider(color: AppTheme.primaryColor),
              const SizedBox(height: 32),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppTheme.cardColor,
                    backgroundImage: _getProfileImageProvider(),
                  ),
                  if (_isEditing)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _isUploadingPicture ? null : _pickImage,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppTheme.primaryColor,
                          child: _isUploadingPicture
                              ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(_currentUser?.displayName ?? 'User Name', style: Theme.of(context).textTheme.titleLarge),
              if (!_isEditing)
                TextButton(
                  onPressed: () => setState(() => _isEditing = true),
                  child: const Text('Edit Profile', style: TextStyle(color: AppTheme.primaryColor)),
                ),
              const SizedBox(height: 32),
              _buildTextField(label: 'Full Name', controller: _fullNameController, readOnly: !_isEditing),
              const SizedBox(height: 16),
              _buildTextField(label: 'Email', controller: _emailController, readOnly: true),
              const SizedBox(height: 24),
              if (!_isEditing)
                TextButton(onPressed: _showChangePasswordDialog, child: const Text('Change Password')),

              // --- ADDED BUTTON ---
              if (!_isEditing)
                TextButton(
                  onPressed: () {
                    // Sync current full name and email into provider so BasicInfoScreen displays them
                    try {
                      final provider = Provider.of<ResumeDataProvider>(context, listen: false);
                      provider.updateBasicInfo(
                        fullName: _fullNameController.text.trim().isNotEmpty ? _fullNameController.text.trim() : (provider.resumeData.fullName),
                        contact: provider.resumeData.contactNumber,
                        email: _emailController.text.trim().isNotEmpty ? _emailController.text.trim() : (provider.resumeData.emailAddress),
                        address: provider.resumeData.address,
                        summary: provider.resumeData.professionalSummary,
                      );
                    } catch (_) {}

                    // Navigate to the BasicInfoScreen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const BasicInfoScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'View Background Information',
                    style: TextStyle(color: AppTheme.primaryColor), // Match style of other buttons
                  ),
                ),
              // --- END ADDED BUTTON ---


              const SizedBox(height: 24),
              if (_isEditing)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isSaving ? null : () {
                          _loadUserData(); // Revert any changes
                          setState(() {
                            _isEditing = false;
                            _profileImageFile = null; // Clear picked image on cancel
                          });
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _saveProfileChanges,
                        child: _isSaving
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    bool readOnly = false,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppTheme.fontColor.withAlpha(179))),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: readOnly ? Colors.grey[200] : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}