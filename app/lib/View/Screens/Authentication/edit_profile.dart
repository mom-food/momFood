import 'package:flutter/material.dart';
import '../../../Services/user_services.dart';
import '../../Widgets/nav_bar.dart';
import '../home_page.dart';
import 'Profile.dart';
import '../shopping_cart_screen.dart';

class EditProfileScreen extends StatefulWidget {
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
      print('Profile updated successfully.');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    } else {
      // If the update fails, print an error message
      print('Failed to update profile.');
      // You can handle the error here, for example, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile.'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
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
                child: Icon(Icons.person, size: 50, color: Colors.black),
              ),
              SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLength: 10,
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف المحمول',
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _updateProfile, // Assign the _updateProfile function here
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('تحديث'),
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
                MaterialPageRoute(builder: (context) => HomePageScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
