import 'package:flutter/material.dart';
import 'package:untitled/screen/repair/repair_inf..dart';
import 'package:untitled/screen/repair/track_repair.dart';

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Repair Status")),
    body: const Center(
      child: Text(
        "Your repair status will appear here",
        style: TextStyle(fontSize: 18),
      ),
    ),
  );
}

class RepairOptionsPage extends StatefulWidget {
  const RepairOptionsPage({super.key});

  @override
  State<RepairOptionsPage> createState() => _RepairOptionsPageState();
}

class _RepairOptionsPageState extends State<RepairOptionsPage> {
  int? selectedIndex; // null if no option selected

  final List<Map<String, dynamic>> repairOptions = [
    {'label': 'Battery Replacement', 'icon': Icons.battery_full},
    {'label': 'Motherboard repair', 'icon': Icons.memory},
    {'label': 'Keyboard repair', 'icon': Icons.keyboard},
    {'label': 'Storage repair', 'icon': Icons.storage},
    {'label': 'Developer board repair', 'icon': Icons.developer_board},
    {'label': 'Software Troubleshooting', 'icon': Icons.bug_report},
    {'label': 'Power/Charging Port', 'icon': Icons.power},
    {'label': 'CPU/GPU Upgrade', 'icon': Icons.speed},
    {'label': 'Internal Cleaning / Dusting', 'icon': Icons.cleaning_services},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isOptionSelected = selectedIndex != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              const SizedBox(width: 20),
              const Text(
                'Repair',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
          children: [
            const SizedBox(height: 16),
            const Text(
              'Repair Your Electronics With Confidence',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              'Pick the part. Schedule the service. Get it fixed.',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Grid of Repair Options
            Expanded(
              child: GridView.builder(
                itemCount: repairOptions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8, // safe fixed ratio
                ),
                itemBuilder: (context, index) {
                  final item = repairOptions[index];
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedIndex == index) {
                          selectedIndex = null; // deselect on second tap
                        } else {
                          selectedIndex = index;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF2D60FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.black12,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item['icon'],
                            color: isSelected ? Colors.white : Colors.black54,
                            size: 32,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['label'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RepairStatusPage(),
                    ),
                  );
                },
                child: const Text(
                  "View Repair Status",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2D60FF),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 20),

            // Book Button
            ElevatedButton(
              onPressed: isOptionSelected
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RepairRequestPage(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isOptionSelected
                    ? const Color(0xFF2D60FF)
                    : Colors.white,
                foregroundColor: isOptionSelected
                    ? Colors.white
                    : Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(
                    color: isOptionSelected
                        ? Colors.transparent
                        : Colors.black12,
                  ),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Book a Repair',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
