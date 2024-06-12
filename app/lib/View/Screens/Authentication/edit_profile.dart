import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../Services/user_services.dart';
import '../../../colors.dart';
import '../../Widgets/nav_bar.dart';
import '../home_page.dart';
import 'profile.dart';
import '../shopping_cart_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;



  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: UserServices.userData?.name ?? '');
    _phoneController =
        TextEditingController(text: UserServices.userData?.phone ?? '');
    _emailController =
        TextEditingController(text: UserServices.userData?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    // Update the user data from the text controllers
    UserServices.userData?.name = _nameController.text;
    UserServices.userData?.phone = _phoneController.text;

    // Call the updateUserByEmail function to update the user in the database
    bool updated = await UserServices().updateUserByEmail();

    if (updated) {
      // If the update is successful, navigate back to the ProfileScreen
      if (kDebugMode) {
        print('Profile updated successfully.');
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    } else {
      if (kDebugMode) {
        print('Failed to update profile.');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update profile.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  AppColors.textColor2,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color:  AppColors.textColor1),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.orange.shade200,
                child: const Icon(Icons.person, size: 50, color:  AppColors.textColor1),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                maxLength: 10,
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف المحمول',
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _updateProfile, // Assign the _updateProfile function here
                style: ElevatedButton.styleFrom(
                  foregroundColor:  AppColors.textColor2,
                  backgroundColor:  AppColors.primary1,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('تحديث'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2,
        onItemTapped: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePageScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartShopping()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
