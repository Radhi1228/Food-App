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
/**/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/helper/auth_helper.dart';

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final userProfile = {
//       "name": "User",
//       "email": "user24@gmail.com",
//     };
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Profile"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const CircleAvatar(
//               radius: 50,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               userProfile["name"]!,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               userProfile["email"]!,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             const Spacer(),
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text("Edit Profile"),
//               onTap: () {
//                 // Edit profile logic
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.lock),
//               title: const Text("Change Password"),
//               onTap: () {
//                 // Change password logic
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text("Logout"),
//               onTap: () async {
//                 await AuthHelper.helper.signOut();
//                 Navigator.pushNamed(context, '/signin');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
/**/
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final String userId;
//   const ProfileScreen({required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ProfileBloc(FireDbHelper.helper)..add(LoadProfile(userId)),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Profile')),
//         body: BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is ProfileLoaded) {
//               final userProfile = state.userProfile;
//               return Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Name: ${userProfile['name']}', style: const TextStyle(fontSize: 18)),
//                     const SizedBox(height: 8),
//                     Text('Email: ${userProfile['email']}', style: const TextStyle(fontSize: 18)),
//                   ],
//                 ),
//               );
//             } else if (state is ProfileError) {
//               return Center(child: Text('Error: ${state.error}'));
//             } else {
//               return const Center(child: Text('No profile data available'));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
/**/
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/helper/firedb_helper.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = AuthHelper.helper.checkUser();
    final userProfile = {
      "name": "Username", // Replace with actual user data
      "email": "user24@gmail.com",
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/image/user.png"),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                userProfile["name"]!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                userProfile["email"]!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const Divider(height: 30),
            const Text(
              "Your Cart",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('cart')
                    .where('userId', isEqualTo: userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("Nothing to show here."),
                    );
                  }
                  final cartItems = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item['imageUrl']),
                        ),
                        title: Text(item['name']),
                        subtitle: Text(
                          "Quantity: ${item['quantity']}\nPrice: \$${item['price']}",
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('cart')
                                .doc(item.id)
                                .delete();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final TextEditingController nameController =
                        TextEditingController();
                    final TextEditingController emailController =
                        TextEditingController();

                    nameController.text = userProfile['name']!;
                    emailController.text = userProfile['email']!;

                    return AlertDialog(
                      title: const Text("Edit Profile"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            decoration:
                                const InputDecoration(labelText: "Name"),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(labelText: "Email"),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final newName = nameController.text;
                            final newEmail = emailController.text;
                            if (newName.isNotEmpty && newEmail.isNotEmpty) {
                              try {
                                await FireDbHelper.helper.updateUserProfile(
                                  '$userId',
                                  newName,
                                  newEmail,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Profile updated successfully!")),
                                );
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Failed to update profile."),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("All fields are required.")),
                              );
                            }
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text("Change Password"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final TextEditingController currentPasswordController =
                        TextEditingController();
                    final TextEditingController newPasswordController =
                        TextEditingController();
                    final TextEditingController confirmPasswordController =
                        TextEditingController();

                    return AlertDialog(
                      title: const Text("Change Password"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: currentPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Current Password",
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: newPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "New Password",
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: "Confirm New Password",
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final currentPassword =
                                currentPasswordController.text.trim();
                            final newPassword =
                                newPasswordController.text.trim();
                            final confirmPassword =
                                confirmPasswordController.text.trim();

                            if (currentPassword.isEmpty ||
                                newPassword.isEmpty ||
                                confirmPassword.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("All fields are required."),
                                ),
                              );
                              return;
                            }
                            if (newPassword != confirmPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Passwords do not match."),
                                ),
                              );
                              return;
                            }
                            final user = FirebaseAuth.instance.currentUser;

                            if (user == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("User not logged in.")),
                              );
                              return;
                            }
                            final success =
                                await AuthHelper.helper.reAuthenticateUser(
                              user.email!,
                              currentPassword,
                            );
                            if (!success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Invalid current password.")),
                              );
                              return;
                            }
                            try {
                              await user.updatePassword(newPassword);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Password updated successfully!"),
                                ),
                              );
                              Navigator.pop(context); // Close the dialog
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Failed to update password: $e"),
                                ),
                              );
                            }
                          },
                          child: const Text("Change"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                await AuthHelper.helper.signOut();
                Navigator.pushNamed(context, '/signin');
              },
            ),
          ],
        ),
      ),
    );
  }
}
