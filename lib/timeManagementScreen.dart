import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'remainderScreen.dart';
import 'folderScreen.dart';
import 'statsScreen.dart';
import 'moreScreen.dart';

class TimeManagementScreen extends StatefulWidget {
  const TimeManagementScreen({super.key});

  @override
  State<TimeManagementScreen> createState() => _TimeManagementScreenState();
}

class _TimeManagementScreenState extends State<TimeManagementScreen> {
  // Mock usage data
  final List<double> usageData = [2.5, 0.3, 0.5, 1.5, 1.4, 0.8, 0.1];
  final List<String> days = ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Today"];

  // Dynamic settings
  bool dailyLimitEnabled = false;
  Duration dailyLimit = const Duration(hours: 1);
  bool sleepModeEnabled = true;
  TimeOfDay sleepStart = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay sleepEnd = const TimeOfDay(hour: 7, minute: 0);

  Future<void> _pickTime(BuildContext context, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? sleepStart : sleepEnd,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          sleepStart = picked;
        } else {
          sleepEnd = picked;
        }
      });
    }
  }

  Future<void> _pickDailyLimit(BuildContext context) async {
    int hours = dailyLimit.inHours;
    int minutes = dailyLimit.inMinutes % 60;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Set Daily Limit"),
          content: Row(
            children: [
              Expanded(
                child: DropdownButton<int>(
                  value: hours,
                  isExpanded: true,
                  items: List.generate(
                    6,
                    (i) => DropdownMenuItem(value: i, child: Text("$i h")),
                  ),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        hours = val;
                        dailyLimit = Duration(hours: hours, minutes: minutes);
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<int>(
                  value: minutes,
                  isExpanded: true,
                  items:
                      [0, 15, 30, 45]
                          .map(
                            (m) =>
                                DropdownMenuItem(value: m, child: Text("$m m")),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        minutes = val;
                        dailyLimit = Duration(hours: hours, minutes: minutes);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    double dailyAverage = usageData.reduce((a, b) => a + b) / usageData.length;

    return Scaffold(
      // ✅ Your custom AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: height * 0.08,
        title: Text(
          "Time management",
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Average
            Text(
              "${dailyAverage.toStringAsFixed(1)} hours",
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "Daily average",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Chart
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(usageData.length, (index) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: usageData[index] * 60,
                          width: 30,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 114, 34),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(days[index]),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 25),

            // Manage your time
            Text(
              "Manage your time",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),

            // Daily limit
            SwitchListTile(
              title: const Text("Daily limit"),
              subtitle:
                  dailyLimitEnabled
                      ? Text(
                        "Limit set: ${dailyLimit.inHours}h ${dailyLimit.inMinutes % 60}m",
                      )
                      : const Text("Off"),
              value: dailyLimitEnabled,
              onChanged: (val) {
                setState(() => dailyLimitEnabled = val);
                if (val) _pickDailyLimit(context);
              },
              secondary: const Icon(Icons.timer_outlined),
            ),

            // Sleep mode
            SwitchListTile(
              title: const Text("Sleep mode"),
              subtitle:
                  sleepModeEnabled
                      ? Text(
                        "From ${sleepStart.format(context)} to ${sleepEnd.format(context)}",
                      )
                      : const Text("Off"),
              value: sleepModeEnabled,
              onChanged: (val) {
                setState(() => sleepModeEnabled = val);
              },
              secondary: const Icon(Icons.nightlight_round),
            ),
            const SizedBox(height: 5),

            if (sleepModeEnabled)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickTime(context, true),
                    child: Text("Start: ${sleepStart.format(context)}"),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickTime(context, false),
                    child: Text("End: ${sleepEnd.format(context)}"),
                  ),
                ],
              ),
          ],
        ),
      ),

      // ✅ Your custom BottomNavigationBar with FAB
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
