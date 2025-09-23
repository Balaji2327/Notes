import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';
import 'folderScreen.dart';
import 'statsScreen.dart';
import 'settingsScreen.dart';
import 'helpScreen.dart';
import 'policyScreen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ✅ AppBar matching your snippet (transparent + gradient flexibleSpace + rounded bottom corners)
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height * 0.08,
        title: Text(
          "Settings and Activity",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.065,
          ),
        ),
        // ClipRRect ensures the rounded bottom corners are visible
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 74, 186, 121),
                  Color.fromARGB(255, 1, 94, 104),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FolderScreen()),
          );
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white, size: width * 0.08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: width * 0.02,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      size: width * 0.07,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: width * 0.05),
                  IconButton(
                    icon: Icon(
                      Icons.bar_chart,
                      size: width * 0.07,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StatsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(width: width * 0.05),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.calendar_month,
                      size: width * 0.07,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddReminderScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: width * 0.05),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      size: width * 0.07,
                      color: Colors.black87,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoreScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Body (kept your list of options)
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // small spacer to separate from AppBar
          SizedBox(height: height * 0.02),

          // Optional profile row below AppBar (if you want to show name/email here)
          // If you'd rather have the profile inside the AppBar, remove this block.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                CircleAvatar(
                  radius: width * 0.08,
                  backgroundColor: const Color.fromARGB(212, 177, 209, 170),
                  child: Icon(
                    Icons.person,
                    size: width * 0.1,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: width * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Siddharth P",
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "siddu2017@gmail.com",
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // IconButton(
                //   icon: Icon(
                //     Icons.more_vert,
                //     color: Colors.black,
                //     size: width * 0.07,
                //   ),
                //   onPressed: () {
                //     // extra options
                //   },
                // ),
              ],
            ),
          ),

          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Text(
              "More",
              style: TextStyle(
                fontSize: width * 0.055,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: height * 0.015),

          // Options List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              children: [
                _buildOption(
                  context,
                  icon: Icons.favorite,
                  text: "Favorites",
                  color: Colors.pinkAccent.shade100, // ❤️ Pink
                  onTap: () {},
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.settings,
                  text: "Settings",
                  color: Colors.blue.shade200, // ⚙️ Blue
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.share,
                  text: "Share this app",
                  color: Colors.orange.shade200, // 📤 Orange
                  onTap: () {},
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.privacy_tip,
                  text: "Privacy policy",
                  color: Colors.teal.shade200, // 🛡️ Teal
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.help,
                  text: "Help & Support",
                  color: Colors.amber.shade200, // ❓ Amber
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HelpSupportScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.logout,
                  text: "Log Out",
                  color: Colors.red.shade300, // 🔴 Red
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
                SizedBox(height: height * 0.012),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable option widget
  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
    VoidCallback? onTap,
  }) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      margin: EdgeInsets.only(bottom: width * 0.02),
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          radius: width * 0.055,
          child: Icon(icon, color: Colors.black, size: width * 0.055),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  /// Logout confirmation popup
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // close popup
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // close popup

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logged out successfully")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 135, 219, 101),
              ),
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
