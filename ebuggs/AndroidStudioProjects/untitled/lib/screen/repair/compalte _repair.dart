
import 'package:flutter/material.dart';
import 'package:untitled/screen/repair/track_repair.dart';

import '../Home/Homepage.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0, // 🔥 divider line remove
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true, // ✅ AppBar ke text bhi center aa jaayenge (agar title add ho)
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center, // ✅ all center
                  children: [
                    SizedBox(height: height * 0.05),

                    // ✅ Success Icon
                    Container(
                      width: width * 0.3,
                      height: width * 0.3,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: width * 0.15,
                      ),
                    ),
                    SizedBox(height: height * 0.04),

                    // ✅ Success Text
                    Center(
                      child: Text(
                        'Your order is placed successfully.',
                        style: TextStyle(
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 0.01),

                    // ✅ Request ID
                    Center(
                      child: Text(
                        'Request ID: 2456',
                        style: TextStyle(
                          fontSize: width * 0.04,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: height * 0.03),

                    // ✅ Repair Status Text (GestureDetector)
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RepairStatusPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Repair Status Screen",
                          style: TextStyle(
                            fontSize: width * 0.042,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A3CCC),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.1), // space for bottom button
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // ✅ Home Button fixed at bottom
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) =>  HomePage()),
                  (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A3CCC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: Size(double.infinity, height * 0.07),
          ),
          child: Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: width * 0.045,
            ),
          ),
        ),
      ),
    );
  }
}


