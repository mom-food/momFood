import 'package:app/Services/user_services.dart';
import 'package:app/View/Screens/Authentication/edit_profile.dart';
import 'package:app/View/Screens/Authentication/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../Widgets/nav_bar.dart';
import '../home_page.dart';
import '../shopping_cart_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {

  void _refreshProfile() async {
    // Call the getUserByEmail function to fetch updated user data
    bool success = await UserServices().getUserByEmail(UserServices.userData!.email!);
    if (success) {
      // If user data is fetched successfully, update the UI
      setState(() {});
    } else {
      // Handle error if user data fetching fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch user data.'),
        ),
      );
    }
  }
  @override
  void initState() {
    _refreshProfile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserServices>(
      builder: (context, userServices, child) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 1),
              Center(
                child: Container(
                  width: 250,
                  height: 250.93,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/Profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 1),
              Container(
                width: 400,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('المعلومات الشخصية',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(UserServices.userData!.name!,
                            style: TextStyle(fontSize: 15)),
                        SizedBox(width: 15),
                        Text(':الاسم ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(UserServices.userData!.email!,
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        SizedBox(width: 15),
                        Text(':البريد الإلكتروني ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(UserServices.userData!.phone!,
                            style: TextStyle(fontSize: 15)),
                        SizedBox(width: 15),
                        Text(':رقم الهاتف   ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  //context.go('/edit-profile');
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>EditProfileScreen() ,));
                },
                child: Container(
                  width: 301,
                  height: 53,
                  alignment: Alignment.center,
                  child: Text(
                    "تعديل المعلومات",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6BD60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 20,),

              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return SignInScreen();
                  },));
                },
                child: Container(
                  width: 301,
                  height: 53,
                  alignment: Alignment.center,
                  child: Text(
                    " تسجيل الخروج",
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6BD60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
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
      ),
    );
  }
}