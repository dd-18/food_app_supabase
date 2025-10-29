import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_supabase/Core/Utils/consts.dart';
import 'package:food_app_supabase/pages/Screens/FoodAppHomeScreen/food_app_home_screen.dart';
import 'package:food_app_supabase/pages/Screens/profile_screen.dart';
import 'package:iconsax/iconsax.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int currentIndex = 0;
  final List<Widget> _pages = [
    FoodAppHomeScreen(),
    Scaffold(),
    ProfileScreen(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: _pages[currentIndex],
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItems(Iconsax.home_15, 'A', 0),
              SizedBox(width: 10),
              _buildNavItems(Iconsax.heart, 'B', 1),
              SizedBox(width: 90),
              _buildNavItems(Icons.person_2_outlined, 'C', 2),
              SizedBox(width: 10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  _buildNavItems(Iconsax.shopping_cart, 'D', 3),
                  Positioned(
                    top: 16,
                    right: -10,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: red,
                      child: Text(
                        '0',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -25,
                    right: 130,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: red,
                      child: Icon(
                        CupertinoIcons.search,
                        size: 35,
                        color: Colors.white,
                      ),
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

  Widget _buildNavItems(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: currentIndex == index ? red : Colors.grey,
          ),
          SizedBox(height: 4),
          CircleAvatar(
            radius: 3,
            backgroundColor: currentIndex == index ? red : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
