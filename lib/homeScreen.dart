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

      // ✅ Body
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gradient Header
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

            // 🔹 Pinned Folders Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              pinnedFolders.map((folder) {
                                return Padding(
                                  padding: EdgeInsets.only(right: width * 0.05),
                                  child: GestureDetector(
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
                                    child: _FolderItem(
                                      icon: Icons.folder,
                                      label: folder,
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FolderItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FolderItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Icon(icon, size: width * 0.12, color: Colors.black),
        SizedBox(height: width * 0.02),
        Text(label, style: TextStyle(fontSize: width * 0.035)),
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
