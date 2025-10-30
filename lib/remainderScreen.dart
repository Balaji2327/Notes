import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homeScreen.dart';
import 'moreScreen.dart';
import 'folderScreen.dart';
import 'statsScreen.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final List<TimeOfDay> _quickTimes = [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 12, minute: 30),
    TimeOfDay(hour: 18, minute: 0),
  ];

  @override
  void initState() {
    super.initState();
    _loadReminder();
  }

  // Load saved date and time
  void _loadReminder() async {
    final prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('reminder_date');
    int? hour = prefs.getInt('reminder_hour');
    int? minute = prefs.getInt('reminder_minute');

    setState(() {
      if (dateString != null) {
        _selectedDate = DateTime.tryParse(dateString);
      }
      if (hour != null && minute != null) {
        _selectedTime = TimeOfDay(hour: hour, minute: minute);
      }
    });
  }

  // Save date and time
  void _saveReminder() async {
    final prefs = await SharedPreferences.getInstance();
    if (_selectedDate != null) {
      prefs.setString('reminder_date', _selectedDate!.toIso8601String());
    }
    if (_selectedTime != null) {
      prefs.setInt('reminder_hour', _selectedTime!.hour);
      prefs.setInt('reminder_minute', _selectedTime!.minute);
    }
  }

  // ✅ Fixed date picker
  Future<void> _pickDate() async {
    final now = DateTime.now();

    // Ensure initialDate is valid
    final initial =
        (_selectedDate != null && _selectedDate!.isAfter(now))
            ? _selectedDate!
            : now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now,
      lastDate: DateTime(2100),
      helpText: "Select reminder date",
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _saveReminder();
    }
  }

  Future<void> _pickCupertinoTime() async {
    DateTime now = DateTime.now();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: DateTime(
              now.year,
              now.month,
              now.day,
              _selectedTime?.hour ?? now.hour,
              _selectedTime?.minute ?? now.minute,
            ),
            use24hFormat: false,
            onDateTimeChanged: (DateTime value) {
              setState(() {
                _selectedTime = TimeOfDay(
                  hour: value.hour,
                  minute: value.minute,
                );
              });
              _saveReminder();
            },
          ),
        );
      },
    );
  }

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
        toolbarHeight: 60,
        title: const Text(
          "Add Reminder!",
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              "When would you like to be reminded?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            // 📅 Date picker
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.date_range, color: Colors.teal),
                    const SizedBox(width: 16),
                    Text(
                      _selectedDate == null
                          ? "Select Date"
                          : "${_selectedDate!.day.toString().padLeft(2, '0')} / ${_selectedDate!.month.toString().padLeft(2, '0')} / ${_selectedDate!.year}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 26),
            const Text(
              "Pick a time",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // ⏰ Quick times
            Wrap(
              spacing: 14,
              children:
                  _quickTimes.map((option) {
                    final isSelected =
                        _selectedTime != null &&
                        _selectedTime!.hour == option.hour &&
                        _selectedTime!.minute == option.minute;
                    return ChoiceChip(
                      selectedColor: Colors.teal,
                      backgroundColor: Colors.teal.shade50,
                      label: Text(
                        option.format(context),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.teal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => _selectedTime = option);
                        _saveReminder();
                      },
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.teal.withOpacity(0.2)),
                      ),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 14),
            Center(
              child: OutlinedButton.icon(
                onPressed: _pickCupertinoTime,
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.teal, width: 2),
                  foregroundColor: Colors.teal,
                ),
                icon: const Icon(Icons.edit, size: 20),
                label: const Text("Custom time"),
              ),
            ),

            if (_selectedTime != null) ...[
              const SizedBox(height: 22),
              Center(
                child: Text(
                  "Selected: ${_selectedTime!.format(context)}",
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ),
            ],
            if (_selectedDate != null) ...[
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "Selected date: "
                  "${_selectedDate!.day.toString().padLeft(2, '0')}/"
                  "${_selectedDate!.month.toString().padLeft(2, '0')}/"
                  "${_selectedDate!.year}",
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            ],
          ],
        ),
      ),

      // ➕ FAB + bottom nav
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const FolderScreen()),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

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
    );
  }
}
