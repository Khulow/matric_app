import 'package:flutter/material.dart';
import 'package:matric_app/common_widgets/circle_painter.dart';
import 'package:matric_app/services/helper_user.dart';
import 'package:matric_app/services/user_service.dart';
import 'package:provider/provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserService>(context);
    final username = authProvider.currentUser?.displayName ?? 'Guest';
    final userEmail = authProvider.currentUser?.email ?? '';

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 188, 75, 0.1),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: authProvider.currentUser?.photoURL != null
                    ? NetworkImage(authProvider.currentUser!.photoURL!)
                    : null,
                child: authProvider.currentUser?.photoURL == null
                    ? const Icon(
                        Icons.person,
                        size: 50,
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatisticItem('0', 'Questions Completed'),
                ],
              ),
              const SizedBox(height: 16),
           
              _buildProfileOption(Icons.settings, 'Settings', false),
              _buildProfileOption(Icons.help, 'Help & Support', false),
              _buildProfileOption(Icons.logout, 'Logout', false, onTap : () => logoutUserInUI(context)
              ,
              ),
              ]),
          ),
        ),
      );
    
  }

  Widget _buildStatisticItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String title, bool isSwitch, {Function()? onTap})  {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing:isSwitch ? Switch(value: false, onChanged: (bool value) {}) : null,
      onTap : onTap,
    );
  }
}
