import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';
import 'moreScreen.dart';
import 'statsScreen.dart';
import 'folderScreen.dart';

class FolderDetailScreen extends StatefulWidget {
  final String folderName;

  const FolderDetailScreen({super.key, required this.folderName});

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  bool isPinned = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadPinnedStatus();
    _loadFavoriteStatus();
  }

  // Load pinned status
  Future<void> _loadPinnedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final pinnedFolders = prefs.getStringList('pinnedFolders') ?? [];
    setState(() {
      isPinned = pinnedFolders.contains(widget.folderName);
    });
  }

  // Load favorite status
  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteFolders = prefs.getStringList('favoriteFolders') ?? [];
    setState(() {
      isFavorite = favoriteFolders.contains(widget.folderName);
    });
  }

  // Toggle pin
  Future<void> _togglePin() async {
    final prefs = await SharedPreferences.getInstance();
    final pinnedFolders = prefs.getStringList('pinnedFolders') ?? [];

    setState(() {
      if (isPinned) {
        pinnedFolders.remove(widget.folderName);
        isPinned = false;
      } else {
        pinnedFolders.add(widget.folderName);
        isPinned = true;
      }
    });

    await prefs.setStringList('pinnedFolders', pinnedFolders);
  }

  // Toggle favorite
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteFolders = prefs.getStringList('favoriteFolders') ?? [];

    setState(() {
      if (isFavorite) {
        favoriteFolders.remove(widget.folderName);
        isFavorite = false;
      } else {
        favoriteFolders.add(widget.folderName);
        isFavorite = true;
      }
    });

    await prefs.setStringList('favoriteFolders', favoriteFolders);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ✅ Gradient AppBar with heart & pin buttons
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height * 0.08,
        title: Text(
          widget.folderName,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: width * 0.065),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
              size: width * 0.07,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: Icon(
              isPinned ? Icons.push_pin : Icons.push_pin_outlined,
              color: isPinned ? Colors.orange : Colors.black,
              size: width * 0.07,
            ),
            onPressed: _togglePin,
          ),
        ],
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

      // Floating Action Button
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

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: width * 0.02,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.home, size: width * 0.07, color: Colors.blue),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                  ),
                  SizedBox(width: width * 0.05),
                  IconButton(
                    icon: Icon(Icons.bar_chart, size: width * 0.07, color: Colors.green),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const StatsScreen()),
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_month, size: width * 0.07, color: Colors.red),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AddReminderScreen()),
                      );
                    },
                  ),
                  SizedBox(width: width * 0.05),
                  IconButton(
                    icon: Icon(Icons.more_vert, size: width * 0.07, color: Colors.black87),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MoreScreen()),
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
      body: Center(
        child: Text(
          "This is the '${widget.folderName}' folder",
          style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
