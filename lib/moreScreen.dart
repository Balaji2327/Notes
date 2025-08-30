import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white, size: width * 0.08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BOTTOM NAV BAR (Icons)
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
                    onPressed: () {},
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

      // BODY
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Container(
            padding: EdgeInsets.all(width * 0.04),
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
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: width * 0.09,
                  backgroundColor: const Color.fromARGB(224, 233, 230, 230),
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
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: width * 0.07,
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

          // Options List (ICONS)
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              children: [
                _buildOption(
                  context,
                  icon: Icons.phone_in_talk,
                  text: "Contact us",
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.share,
                  text: "Share this app",
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.privacy_tip,
                  text: "Privacy policy",
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  context,
                  icon: Icons.logout,
                  text: "Log Out",
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: height * 0.012),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Color color,
  }) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Container(
      margin: EdgeInsets.only(bottom: width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.02),
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
        onTap: () {},
      ),
    );
  }
}
