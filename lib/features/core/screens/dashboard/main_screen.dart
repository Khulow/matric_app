import 'package:flutter/material.dart';
import 'package:matric_app/features/core/provider/bottom_nav_bar.dart';
import 'package:matric_app/features/core/screens/dashboard/dashboard%20_screen.dart';
import 'package:matric_app/features/core/screens/dashboard/profile_screen.dart';


import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
        builder: (context, navigationProvider, child) {
          switch (navigationProvider.currentIndex) {
            case 0:
              return const DashboardScreen();
            case 1:
              return const ProfileScreen(); // ProfileScreen();
            default:
              return const DashboardScreen();
          }
        },
      ),
      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (context, navigationProvider, child) {
          return BottomNavigationBar(
            //backgroundColor: Colors.blue.withOpacity(0.8),
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            backgroundColor: Color.fromARGB(207, 0, 2, 3),
            elevation: 10.0,
            currentIndex: navigationProvider.currentIndex,
            onTap: (index) {
              navigationProvider.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                //backgroundColor: Colors.,
                icon: Icon(Icons.menu_book,),
                label: 'Learn',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_4_rounded),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
