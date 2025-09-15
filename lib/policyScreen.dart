import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';
import 'folderScreen.dart';
import 'statsScreen.dart';
import 'moreScreen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ Custom AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height * 0.08,
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: width * 0.065,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 74, 186, 121),
                Color.fromARGB(255, 1, 94, 104),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),

      // ✅ Privacy Policy Content
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to Notes App",
              style: TextStyle(
                fontSize: width * 0.055,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: height * 0.015),
            Text(
              "This Privacy Policy explains how we handle your personal data while using our Notes App. "
              "By using the app, you agree to this policy.",
              style: TextStyle(fontSize: width * 0.045, height: 1.5),
            ),

            SizedBox(height: height * 0.03),
            Text(
              "1. Information We Collect",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.05,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "• Notes content you create inside the app (stored locally on your device).\n"
              "• Reminders you set for tasks.\n"
              "• App usage statistics (for analytics and improvement).",
              style: TextStyle(fontSize: width * 0.045, height: 1.5),
            ),

            SizedBox(height: height * 0.03),
            Text(
              "2. How We Use Your Data",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.05,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "• To provide a smooth note-taking and reminder experience.\n"
              "• To improve app performance and add new features.\n"
              "• We never sell or share your personal data with third parties.",
              style: TextStyle(fontSize: width * 0.045, height: 1.5),
            ),

            SizedBox(height: height * 0.03),
            Text(
              "3. Data Storage & Security",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.05,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "• All notes are stored securely on your device.\n"
              "• You may choose to backup notes manually.\n"
              "• We apply best practices to protect your information.",
              style: TextStyle(fontSize: width * 0.045, height: 1.5),
            ),

            SizedBox(height: height * 0.03),
            Text(
              "4. Your Rights",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.05,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "• You can delete your notes at any time.\n"
              "• You can uninstall the app to remove all stored data.\n"
              "• You may contact us for privacy-related questions.",
              style: TextStyle(fontSize: width * 0.045, height: 1.5),
            ),

            SizedBox(height: height * 0.03),
            Text(
              "5. Contact Us",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.05,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              "If you have any questions about this Privacy Policy, please contact us at:\n"
              "📧 support@notesapp.com",
              style: TextStyle(fontSize: width * 0.045, height: 1.5),
            ),

            SizedBox(height: height * 0.05),
          ],
        ),
      ),

      // ✅ Bottom Navigation Bar
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

      // ✅ Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FolderScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: width * 0.08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
