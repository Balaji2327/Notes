import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'homeScreen.dart';
import 'moreScreen.dart';
import 'remainderScreen.dart';
import 'folderScreen.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  Map<DateTime, int> usageData = {
    DateTime(2025, 2, 10): 2,
    DateTime(2025, 2, 11): 3,
    DateTime(2025, 2, 12): 1,
  };

  int calculateStreak(Map<DateTime, int> data) {
    if (data.isEmpty) return 0;

    List<DateTime> dates = data.keys.toList()..sort();
    int streak = 0;
    int maxStreak = 0;

    for (int i = 1; i < dates.length; i++) {
      if (dates[i].difference(dates[i - 1]).inDays == 1) {
        streak++;
        maxStreak = streak > maxStreak ? streak : maxStreak;
      } else {
        streak = 0;
      }
    }
    return maxStreak + 1;
  }

  void addUsage() {
    setState(() {
      DateTime today = DateTime.now();
      DateTime day = DateTime(today.year, today.month, today.day);
      usageData[day] = (usageData[day] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final height = media.size.height;
    final streak = calculateStreak(usageData);

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height * 0.08,
        title: Text(
          "Daily Stats",
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
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FolderScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: width * 0.08),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            children: [
              // Horizontally scrollable HeatMap
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: HeatMap(
                  startDate: DateTime(DateTime.now().year, 1, 1),
                  endDate: DateTime(DateTime.now().year, 12, 31),
                  datasets: usageData,
                  colorMode: ColorMode.color,
                  defaultColor: Colors.grey[200]!,
                  showColorTip: true,
                  showText: false,
                  colorsets: const {
                    1: Color.fromARGB(255, 0, 255, 8),
                    2: Color.fromARGB(255, 22, 110, 47),
                    3: Color.fromARGB(255, 125, 227, 140),
                    4: Color.fromARGB(255, 5, 86, 10),
                  },
                  size: width * 0.08, // smaller to fit
                  textColor: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.03),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.015,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: width * 0.06,
                      ),
                      SizedBox(width: width * 0.025),
                      Flexible(
                        child: Text(
                          "Current Streak: $streak days 🔥",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
