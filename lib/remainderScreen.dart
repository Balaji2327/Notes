import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'homeScreen.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({super.key});

  @override
  State<AddReminderScreen> createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeOfDay? selectedTime;

  Future<void> _pickTime({TimeOfDay? initialTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
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
          "Add Remainder!",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
        ),
        actions: const [
          Icon(Icons.more_vert, size: 28, color: Colors.black),
          SizedBox(width: 12),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.tealAccent, Colors.green],
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
              "Select date & time",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            // Real Calendar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.green.shade50,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Time for reminding",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    _pickTime(
                      initialTime: const TimeOfDay(hour: 10, minute: 30),
                    );
                  },
                  child: const Text("10.30 AM"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    _pickTime(
                      initialTime: const TimeOfDay(hour: 18, minute: 0),
                    );
                  },
                  child: const Text("6.00 PM"),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  _pickTime(); // opens with current time
                },
                child: const Text("Or input manual"),
              ),
            ),

            if (selectedTime != null) ...[
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Selected Time: ${selectedTime!.format(context)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),

      // ✅ Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save reminder then go back
          Navigator.pop(context);
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ✅ Bottom Navigation Bar with 5 icons
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
              // Home
              IconButton(
                icon: Icon(Icons.home, color: Colors.blue, size: width * 0.07),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),

              // Stats
              Icon(Icons.bar_chart, color: Colors.green, size: width * 0.07),

              SizedBox(width: width * 0.12), // gap for FAB
              // Calendar (stays on same screen)
              IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.red,
                  size: width * 0.07,
                ),
                onPressed: () {
                  // Already in AddReminderScreen
                },
              ),

              // More
              Icon(Icons.more_vert, color: Colors.black, size: width * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}
