import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RepairStatusPage extends StatelessWidget {
  const RepairStatusPage({super.key});

  final List<String> statuses = const [
    'Scheduled',
    'Picked up',
    'In progress',
    'Repaired',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    const activeIndex = 0;
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          'Repair Status Screen',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: width * 0.05,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track the progress of your repair',
              style: GoogleFonts.inter(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Progress Tracker
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: List.generate(statuses.length, (index) {
                  bool isActive = index == activeIndex;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: isActive
                                ? const Color(0xFF2D60FF)
                                : Colors.grey[300],
                          ),
                          if (index < statuses.length - 1)
                            Container(
                              width: 2,
                              height: 32,
                              color: Colors.grey[300],
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                statuses[index],
                                style: GoogleFonts.inter(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w600,
                                  color: isActive ? Colors.black : Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Warehouse, Mirpur 12, Dhaka',
                                style: GoogleFonts.inter(
                                  fontSize: width * 0.032,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            // ✅ Status Info Box with Chips on Top
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ✅ Chips on top
                  Row(
                    children: [
                      Chip(
                        visualDensity: VisualDensity.compact,
                        labelPadding:
                        const EdgeInsets.symmetric(horizontal: 6),
                        label: Text(
                          'Processing',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        backgroundColor: const Color(0xFFFFDADA),
                      ),
                      const Spacer(),
                      Chip(
                        visualDensity: VisualDensity.compact,
                        labelPadding:
                        const EdgeInsets.symmetric(horizontal: 6),
                        label: Text(
                          'Successfully Paid',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID: #1234567',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.04,
                        ),
                      ),
                      Text(
                        'Date: 02 May 2025',
                        style: GoogleFonts.inter(fontSize: width * 0.035),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Estimated Delivery by: 06 May 2025, 6:00 pm',
                    style: GoogleFonts.inter(fontSize: width * 0.035),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Contact Support',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.045,
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Contact Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/photo.jpg',
                    ),
                    radius: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rakesh Kumar',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.04,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.call_outlined, // ✅ नया icon
                              size: 18,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Text(
                                '+91 23456 78',
                                style: GoogleFonts.inter(
                                  fontSize: width * 0.035,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
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
