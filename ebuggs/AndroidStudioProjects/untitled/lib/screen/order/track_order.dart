import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  int selectedOption = 1; // 1 = Yes, 0 = No

  final orderSteps = const [
    {"title": "Processing", "subtitle": "Warehouse, Mirpur 12, Dhaka"},
    {"title": "In Transit", "subtitle": "Warehouse, Mirpur 12, Dhaka"},
    {"title": "Out of Delivery", "subtitle": "Warehouse, Mirpur 12, Dhaka"},
    {"title": "Delivered", "subtitle": "Warehouse, Mirpur 12, Dhaka"},
  ];

  double getResponsiveFont(double baseSize, double w) {
    return baseSize * (w / 375); // 375 is base width of iPhone X / common design
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leadingWidth: 40,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: getResponsiveFont(20, w),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Text(
          "Track Order",
          style: GoogleFonts.inter(
            fontSize: getResponsiveFont(18, w),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------- Order Journey --------
              Text(
                "Your Order Journey",
                style: GoogleFonts.inter(
                  fontSize: getResponsiveFont(16, w),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: h * 0.015),
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: List.generate(orderSteps.length, (index) {
                    final step = orderSteps[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == 0 ? Colors.blue : Colors.grey[300],
                              ),
                            ),
                            if (index != orderSteps.length - 1)
                              Container(
                                width: 2,
                                height: h * 0.06,
                                color: Colors.grey[300],
                              ),
                          ],
                        ),
                        SizedBox(width: w * 0.04),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: index == 0 ? 0 : 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step["title"]!,
                                  style: GoogleFonts.inter(
                                    fontSize: getResponsiveFont(14, w),
                                    fontWeight: index == 0 ? FontWeight.w700 : FontWeight.w500,
                                    color: index == 0 ? Colors.black : Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  step["subtitle"]!,
                                  style: GoogleFonts.inter(
                                    fontSize: getResponsiveFont(12, w),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: h * 0.02),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: h * 0.025),

              // -------- Order Status --------
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.03,
                            vertical: h * 0.006,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Processing",
                            style: GoogleFonts.inter(
                              fontSize: getResponsiveFont(12, w),
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * 0.03,
                            vertical: h * 0.006,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Successfully Paid",
                            style: GoogleFonts.inter(
                              fontSize: getResponsiveFont(12, w),
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID: #1234567",
                          style: GoogleFonts.inter(
                            fontSize: getResponsiveFont(13, w),
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          "Date: 02 May 2025",
                          style: GoogleFonts.inter(
                            fontSize: getResponsiveFont(13, w),
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.008),
                    Text(
                      "Estimated Delivery by: 06 May 2025, 6:00 pm",
                      style: GoogleFonts.inter(
                        fontSize: getResponsiveFont(13, w),
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * 0.025),

              // -------- Courier Info --------
              Text(
                "Courier Information",
                style: GoogleFonts.inter(
                  fontSize: getResponsiveFont(16, w),
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: h * 0.015),
              Container(
                padding: EdgeInsets.all(w * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage("assets/images/photo.jpg"),
                    ),
                    SizedBox(width: w * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Rakesh Kumar",
                              style: GoogleFonts.inter(
                                fontSize: getResponsiveFont(14, w),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.verified,
                              color: Colors.blue,
                              size: 18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.call,
                              size: 14,
                              color: Colors.black87,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "+91 2345678",
                              style: GoogleFonts.inter(
                                fontSize: getResponsiveFont(13, w),
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
