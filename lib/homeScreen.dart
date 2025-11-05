import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<String> groceryList = [];
  String displayName = '';
  String email = '';
  StreamSubscription<User?>? _userSub;

  @override
  void initState() {
    super.initState();
    _loadPinnedFolders();
    _loadGroceryList();
    _loadUser();
    _userSub = FirebaseAuth.instance.userChanges().listen(_updateFromUser);
  }

  @override
  void dispose() {
    _userSub?.cancel();
    super.dispose();
  }

  void _updateFromUser(User? user) {
    if (!mounted) return;
    setState(() {
      email = user?.email ?? '';
      displayName =
          (user?.displayName != null && user!.displayName!.trim().isNotEmpty)
              ? user.displayName!
              : _extractNameFromEmail(user?.email ?? '');
    });
  }

  void _loadUser() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      email = user?.email ?? '';
      displayName =
          (user?.displayName != null && user!.displayName!.trim().isNotEmpty)
              ? user.displayName!
              : _extractNameFromEmail(user?.email ?? '');
    });
  }

  String _extractNameFromEmail(String email) {
    if (email.isEmpty) return '';
    final local = email.split('@').first;
    // Replace dots/underscores with spaces and capitalize first letter
    final cleaned = local.replaceAll(RegExp(r'[._]'), ' ');
    if (cleaned.isEmpty) return '';
    return '${cleaned[0].toUpperCase()}${cleaned.substring(1)}';
  }

  Future<void> _loadPinnedFolders() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pinnedFolders = prefs.getStringList('pinnedFolders') ?? [];
    });
  }

  Future<void> _loadGroceryList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      groceryList = prefs.getStringList('groceryList') ?? [];
    });
  }

  Future<void> _addGroceryItem(String item) async {
    if (item.trim().isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      groceryList.add(item.trim());
    });
    await prefs.setStringList('groceryList', groceryList);
  }

  Future<void> _removeGroceryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      groceryList.removeAt(index);
    });
    await prefs.setStringList('groceryList', groceryList);
  }

  void _showAddGroceryDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Add Grocery Item"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Enter item name"),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 135, 219, 101),
                  foregroundColor: Colors.black, // optional for better contrast
                ),
                onPressed: () {
                  _addGroceryItem(controller.text);
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
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
          ).then((_) {
            _loadPinnedFolders();
            _loadGroceryList();
          });
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
            // 🔹 Header Section
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
                      "Hello, ${displayName.isNotEmpty ? displayName : 'User'}",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      email.isNotEmpty ? email : '',
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
                  // 🔹 Pinned Folders
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

                  // 🔹 Recent Notes
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

                  // 🔹 Grocery List Section (Dynamic)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grocery List",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.045,
                        ),
                      ),
                      IconButton(
                        onPressed: _showAddGroceryDialog,
                        icon: const Icon(Icons.add, color: Colors.black87),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
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
                    child:
                        groceryList.isEmpty
                            ? const Text(
                              "No grocery items yet.",
                              style: TextStyle(color: Colors.grey),
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  groceryList.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final item = entry.value;
                                    return Dismissible(
                                      key: Key(item),
                                      direction: DismissDirection.endToStart,
                                      onDismissed:
                                          (_) => _removeGroceryItem(index),
                                      background: Container(
                                        color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.only(
                                          right: width * 0.05,
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      child: _BulletText(text: item),
                                    );
                                  }).toList(),
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

// 🔹 Pinned Folder Card
class _PinnedFolderCard extends StatelessWidget {
  final String label;
  const _PinnedFolderCard({required this.label});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
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
          Icon(Icons.folder, size: width * 0.12, color: Colors.black),
          SizedBox(height: width * 0.02),
          Text(
            label,
            style: TextStyle(fontSize: width * 0.035, color: Colors.black),
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
