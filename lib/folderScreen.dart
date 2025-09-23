import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';
import 'moreScreen.dart';
import 'statsScreen.dart';
import 'folderDetailsScreen.dart'; // Make sure you have this screen

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  List<String> folders = [];
  List<String> tasksEndingToday = ["Submit assignment", "Evening workout"];
  bool showRecorder = false; // State to show original recorder

  @override
  void initState() {
    super.initState();
    _loadFolders();
  }

  // Load folders from SharedPreferences
  Future<void> _loadFolders() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      folders =
          prefs.getStringList("folders") ?? ["Home work", "Workout", "Sports"];
    });
  }

  // Save folders to SharedPreferences
  Future<void> _saveFolders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("folders", folders);
  }

  // Create new folder
  void _createFolder() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("Create New Folder"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Enter folder name"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    setState(() {
                      folders.add(controller.text.trim());
                    });
                    _saveFolders();
                    Navigator.pop(ctx);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 135, 219, 101),
                ),
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }

  // Delete folder
  void _deleteFolder(int index) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("Delete Folder"),
            content: Text(
              "Are you sure you want to delete '${folders[index]}'?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    folders.removeAt(index);
                  });
                  _saveFolders();
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(201, 255, 0, 0),
                ),
                child: const Text("Delete"),
              ),
            ],
          ),
    );
  }

  // Open voice recorder popup
  void _openRecorderPopup() async {
    setState(
      () => showRecorder = false,
    ); // Hide original recorder while popup is open

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Voice Recorder",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Recording started...")),
                      );
                      // After popup closes, show original recorder
                      setState(() => showRecorder = true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mic,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Tap mic to start recording"),
                ],
              ),
            ),
          ),
    );

    // If user dismissed popup by tapping outside
    setState(() => showRecorder = true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        title: const Text(
          "Create Folder",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
        ),
        actions: const [
          Icon(Icons.more_vert, size: 28, color: Colors.black),
          SizedBox(width: 12),
        ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: _createFolder,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: folders.length + 1,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final buttonSize = width * 0.18; // responsive size
                    final iconSize = width * 0.09; // responsive icon size

                    if (index == 0) {
                      return GestureDetector(
                        onTap: _createFolder,
                        child: Column(
                          children: [
                            Container(
                              height: buttonSize,
                              width: buttonSize,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.add,
                                size: iconSize,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text("New folder"),
                          ],
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => FolderDetailScreen(
                                    folderName: folders[index - 1],
                                  ),
                            ),
                          );
                        },
                        onLongPress: () => _deleteFolder(index - 1),
                        child: FolderItem(
                          icon: Icons.folder,
                          title: folders[index - 1],
                        ),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),
                // Voice note card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add voice note",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              size: 32,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Text(
                                  "🎵 Voice waveform",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("Done"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.save, color: Colors.grey),
                          const SizedBox(width: 16),
                          IconButton(
                            icon: const Icon(Icons.mic, color: Colors.green),
                            onPressed: _openRecorderPopup,
                          ),
                        ],
                      ),
                      // Show original recorder if state is true
                      if (showRecorder)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.mic, size: 30, color: Colors.green),
                                SizedBox(width: 12),
                                Text(
                                  "Voice recorder ready...",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                if (tasksEndingToday.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.shade300, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.warning, color: Colors.red, size: 28),
                            SizedBox(width: 8),
                            Text(
                              "Tasks Ending Today!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...tasksEndingToday.map(
                          (task) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.task_alt,
                                  size: 20,
                                  color: Colors.black54,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  task,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Folder Item Widget
class FolderItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const FolderItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 50, color: Colors.black87),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
