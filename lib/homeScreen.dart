import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'moreScreen.dart';
import 'remainderScreen.dart';
import 'folderScreen.dart';
import 'statsScreen.dart';
import 'folderDetailsScreen.dart'; // ✅ Make sure this file exists

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> pinnedFolders = [];

  @override
  void initState() {
    super.initState();
    _loadPinnedFolders();
  }

  Future<void> _loadPinnedFolders() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pinnedFolders = prefs.getStringList('pinnedFolders') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ Floating Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FolderScreen()),
          ).then((_) => _loadPinnedFolders());
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white, size: width * 0.08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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

      // ✅ Body Redesigned
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header Section (Gradient + Profile)
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * 0.06),
                bottomRight: Radius.circular(width * 0.06),
              ),
              child: Container(
                width: double.infinity,
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
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
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
                        hintText: "Search",
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
            ),

            SizedBox(height: height * 0.03),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Pinned Folders Section
                  Text(
                    "Pinned Folders",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  pinnedFolders.isEmpty
                      ? Text(
                        "No pinned folders yet.",
                        style: TextStyle(
                          fontSize: width * 0.035,
                          color: Colors.grey,
                        ),
                      )
                      : SizedBox(
                        height: width * 0.3,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: pinnedFolders.length,
                          separatorBuilder:
                              (_, __) => SizedBox(width: width * 0.04),
                          itemBuilder: (context, index) {
                            final folder = pinnedFolders[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => FolderDetailScreen(
                                          folderName: folder,
                                        ),
                                  ),
                                );
                              },
                              child: _PinnedFolderCard(label: folder),
                            );
                          },
                        ),
                      ),

                  SizedBox(height: height * 0.03),

                  // 🔹 Recent Notes Section
                  Text(
                    "Recent Notes",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  Column(
                    children: [
                      _RecentNoteCard(
                        title: "Voice Note",
                        icon: Icons.mic,
                        color: Colors.green.shade100,
                      ),
                      SizedBox(height: height * 0.015),
                      _RecentNoteCard(
                        title: "Plans for the Week",
                        content:
                            "Going to Bangalore this weekend and exploring famous temples. CSK vs RCB match at Chinnaswamy stadium!",
                        color: Colors.orange.shade100,
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.03),

                  // 🔹 Grocery List Section
                  Container(
                    padding: EdgeInsets.all(width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(width * 0.03),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Grocery Lists",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        _BulletText(text: "Apple 1kg"),
                        _BulletText(text: "Vegetables"),
                        _BulletText(text: "Snacks"),
                        _BulletText(text: "Milk"),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Pinned Folder Card (Black Style)
class _PinnedFolderCard extends StatelessWidget {
  final String label;
  const _PinnedFolderCard({required this.label});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.25,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255), // Black background
        borderRadius: BorderRadius.circular(width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(width * 0.03),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder,
            size: width * 0.12,
            color: const Color.fromARGB(255, 0, 0, 0),
          ), // White icon
          SizedBox(height: width * 0.02),
          Text(
            label,
            style: TextStyle(
              fontSize: width * 0.035,
              color: const Color.fromARGB(255, 0, 0, 0), // White text
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// 🔹 Recent Note Card
class _RecentNoteCard extends StatelessWidget {
  final String title;
  final String? content;
  final IconData? icon;
  final Color color;
  const _RecentNoteCard({
    required this.title,
    this.content,
    this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child:
          icon != null
              ? Row(
                children: [
                  Icon(icon, size: width * 0.08),
                  SizedBox(width: width * 0.03),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    content ?? "",
                    style: TextStyle(
                      fontSize: width * 0.035,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
    );
  }
}

// 🔹 Bullet Text
class _BulletText extends StatelessWidget {
  final String text;
  const _BulletText({required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.01),
      child: Row(
        children: [
          Icon(Icons.circle, size: width * 0.025, color: Colors.black87),
          SizedBox(width: width * 0.03),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: width * 0.035)),
          ),
        ],
      ),
    );
  }
}
