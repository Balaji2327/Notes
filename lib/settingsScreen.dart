import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';
import 'folderScreen.dart';
import 'statsScreen.dart';
import 'moreScreen.dart';
import 'theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Profile picture (default)
  String? profileImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height * 0.08,
        title: Text(
          "Settings",
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

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FolderScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.02),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              children: [
                _buildOption(
                  icon: Icons.person,
                  text: "Edit Profile",
                  color: Colors.blue.shade100,
                  onTap: () => _showEditProfileDialog(context),
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  icon: Icons.timer,
                  text: "Time Management",
                  color: Colors.green.shade100,
                  onTap: () {},
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  icon: Icons.color_lens,
                  text: "Theme",
                  color: Colors.purple.shade100,
                  onTap: () {
                    _showThemeDialog(context);
                  },
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  icon: Icons.language,
                  text: "Language",
                  color: Colors.orange.shade100,
                  onTap: () => _showLanguageDialog(context),
                ),
                SizedBox(height: height * 0.012),
                _buildOption(
                  icon: Icons.accessibility,
                  text: "Accessibility",
                  color: Colors.red.shade100,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Edit Profile Popup (Light theme only)
  /// ✅ Edit Profile Popup (Light theme only)
  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController();
    final bioController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  const SizedBox(height: 20),

                  // Profile Picture
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          profileImage = profileImage == null ? "local" : null;
                        });
                      },
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            profileImage != null
                                ? const AssetImage("assets/profile.jpg")
                                : null,
                        child:
                            profileImage == null
                                ? const Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                  color: Colors.black54,
                                )
                                : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Bio
                  TextField(
                    controller: bioController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Bio",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Age
                  TextField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Age",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ✅ Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color.fromARGB(
                            195,
                            22,
                            1,
                            139,
                          ), // same as logout popup
                        ),
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          String name = nameController.text.trim();
                          String bio = bioController.text.trim();
                          String age = ageController.text.trim();

                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Profile Updated\nName: $name\nBio: $bio\nAge: $age",
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            135,
                            219,
                            101,
                          ), // ✅ green
                          foregroundColor: const Color.fromARGB(
                            195,
                            22,
                            1,
                            139,
                          ), // ✅ white text
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Choose Theme"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.phone_android, color: Colors.blue),
                title: const Text("System Default"),
                onTap: () {
                  ThemeManager.themeNotifier.value = ThemeMode.system;
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(Icons.wb_sunny, color: Colors.orange),
                title: const Text("Light"),
                onTap: () {
                  ThemeManager.themeNotifier.value = ThemeMode.light;
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.nightlight_round,
                  color: Colors.purple,
                ),
                title: const Text("Dark"),
                onTap: () {
                  ThemeManager.themeNotifier.value = ThemeMode.dark;
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Language Dialog
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Choose Language"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _languageTile(ctx, "English"),
                _languageTile(ctx, "தமிழ் (Tamil)"),
                _languageTile(ctx, "हिंदी (Hindi)"),
                _languageTile(ctx, "తెలుగు (Telugu)"),
                _languageTile(ctx, "ಕನ್ನಡ (Kannada)"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _languageTile(BuildContext ctx, String lang) {
    return ListTile(
      leading: const Icon(Icons.language, color: Colors.black87),
      title: Text(lang),
      onTap: () {
        Navigator.pop(ctx);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("$lang Selected")));
      },
    );
  }

  /// Reusable Option
  Widget _buildOption({
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
            color: Colors.black.withOpacity(0.1),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          radius: width * 0.055,
          child: Icon(icon, color: Colors.black87, size: width * 0.055),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
