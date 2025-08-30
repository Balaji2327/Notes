import 'package:flutter/material.dart';
import 'remainderScreen.dart';
import 'moreScreen.dart'; // 👈 Import MoreScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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

      // Body
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 74, 186, 121),
                      Color.fromARGB(255, 1, 94, 104),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Siddharth P",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      "siddu2017@gmail.com",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: width * 0.035,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "search",
                        prefixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),

              // My Folders
              Text(
                "My Folders",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _FolderItem(
                    icon: Icons.folder,
                    label: "Home work",
                    size: width * 0.12,
                  ),
                  _FolderItem(
                    icon: Icons.folder,
                    label: "Workout",
                    size: width * 0.12,
                  ),
                  _FolderItem(
                    icon: Icons.folder,
                    label: "Sports",
                    size: width * 0.12,
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),

              // Recent Notes
              Text(
                "Recent Notes",
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: height * 0.015),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Voice Note Card
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.03),
                      margin: EdgeInsets.only(right: width * 0.02),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4F5D4),
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Voice note",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.04,
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            children: [
                              Icon(
                                Icons.play_arrow,
                                size: width * 0.08,
                                color: Colors.black,
                              ),
                              SizedBox(width: width * 0.02),
                              Expanded(
                                child: Icon(
                                  Icons.multitrack_audio,
                                  size: width * 0.15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // List of plans Card
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.03),
                      margin: EdgeInsets.only(left: width * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      child: Text(
                        "List of plans for this week\n"
                        "Going to bangalore in this weekend and also explore the famous Temple at karnataka. "
                        "On this week end there is a CSK vs RCB match at chinnaswamy stadium...",
                        style: TextStyle(fontSize: width * 0.03),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),

              // Grocery List
              Container(
                padding: EdgeInsets.all(width * 0.03),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Grocery Lists",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: width * 0.04,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    const _BulletText(text: "Apple 1kg"),
                    const _BulletText(text: "Vegetables"),
                    const _BulletText(text: "Snacks"),
                    const _BulletText(text: "Milk"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FolderItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double size;
  const _FolderItem({required this.icon, required this.label, this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: size, color: const Color.fromARGB(255, 0, 0, 0)),
        SizedBox(height: size * 0.12),
        Text(label, style: TextStyle(fontSize: size * 0.3)),
      ],
    );
  }
}

class _BulletText extends StatelessWidget {
  final String text;
  const _BulletText({required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Icon(Icons.circle, size: width * 0.02, color: Colors.black),
        SizedBox(width: width * 0.02),
        Text(text, style: TextStyle(fontSize: width * 0.035)),
      ],
    );
  }
}
