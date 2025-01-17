// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
//**********************
// Profile Screen
// import 'package:flutter/material.dart';
// import '../../utils/helper/auth_helper.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);override;
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('assets/image/profile.png'),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Riaz',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const Text('uiriaz24@gmail.com'),
//             const SizedBox(height: 24),
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text('Edit Profile'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.favorite),
//               title: const Text('Favorite'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.location_on),
//               title: const Text('Location'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.history),
//               title: const Text('History'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text('About'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.lock),
//               title: const Text('Change Password'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () {
//                 AuthHelper.helper.signOut();
//                 Navigator.pushNamed(context, '/signin');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProfile = {
      "name": "Riazul Islam",
      "email": "riazul24@gmail.com",
      // "profileImage":
      // "https://via.placeholder.com/150", // Placeholder for profile image
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
               //backgroundImage: NetworkImage(userProfile["profileImage"]!),
            ),
            const SizedBox(height: 16),
            Text(
              userProfile["name"]!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userProfile["email"]!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              onTap: () {
                // Edit profile logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Change Password"),
              onTap: () {
                // Change password logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Logout logic
              },
            ),
          ],
        ),
      ),
    );
  }
}

