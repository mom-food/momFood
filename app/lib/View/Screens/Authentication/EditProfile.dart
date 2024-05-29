import 'package:flutter/material.dart';


class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Pettrey Smith');
  final TextEditingController _phoneController = TextEditingController(text: '0594534532');
  final TextEditingController _emailController = TextEditingController(text: 'petrey.smith@gmail.com');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _updateProfile() {
    // Here you can handle the logic to update the user profile
    // For example, sending data to a server or updating a local database
    print('Updating profile with:');
    print('Name: ${_nameController.text}');
    print('Phone: ${_phoneController.text}');
    print('Email: ${_emailController.text}');

    // Implement your update logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // Action for more options
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
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف المحمول',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'عنوان البريد الإلكتروني',
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('تحديث'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Action to reset password or other settings
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.orange,
                ),
                child: Text('هل تريد حساب كامل للسرير؟ أعادة تعيين كلمة سر'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}