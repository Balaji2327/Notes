import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';
import 'folderScreen.dart';
import 'statsScreen.dart';
import 'moreScreen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          "Help & Support",
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

      // ✅ Help & Support Content
      body: ListView(
        padding: EdgeInsets.all(width * 0.05),
        children: [
          Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: width * 0.055,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: height * 0.02),

          // FAQ Expandable
          ExpansionTile(
            leading: const Icon(Icons.question_answer, color: Colors.green),
            title: const Text("How do I create a new note?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Tap on the + button at the bottom center of the screen to create a new note.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ExpansionTile(
            leading: const Icon(Icons.question_answer, color: Colors.green),
            title: const Text("Can I set reminders for notes?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Yes, go to the Reminder section from the bottom navigation bar to set reminders.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ExpansionTile(
            leading: const Icon(Icons.question_answer, color: Colors.green),
            title: const Text("How do I organize my notes?"),
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You can create folders in the Folder section and move notes inside them.",
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.02),

          // Contact Support
          Text(
            "Contact Support",
            style: TextStyle(
              fontSize: width * 0.055,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.blue),
            title: const Text("Email Us"),
            subtitle: const Text("support@notesapp.com"),
            onTap: () {
              // You can integrate url_launcher for mailto
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.red),
            title: const Text("Call Us"),
            subtitle: const Text("+91 98765 43210"),
            onTap: () {
              // You can integrate url_launcher for tel:
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.youtube_searched_for_outlined,
              color: Color.fromARGB(172, 255, 0, 166),
            ),
            title: const Text("YouTube us"),
            subtitle: const Text("youtube.com/notesapp"),
            onTap: () {
              // You can integrate url_launcher for mailto
            },
          ),

          SizedBox(height: height * 0.03),

          // Feedback
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(
                vertical: height * 0.02,
                horizontal: width * 0.1,
              ),
            ),
            onPressed: () {
              // Navigate to feedback form or open dialog
              
            },
            icon: const Icon(Icons.feedback, color: Colors.white),
            label: const Text(
              "Send Feedback",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 16,
              ),
            ),
          ),
        ],
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
