import 'package:flutter/material.dart';

import '../Home/Homepage.dart';



class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Whole page white
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove default back button padding
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false, // Align to left
        title: Row(
          mainAxisSize: MainAxisSize.min, // Take minimal width
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
              padding: EdgeInsets.zero, // Remove internal padding
              constraints: const BoxConstraints(), // Remove default constraints
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 8), // Small gap between icon and text
            const Text(
              'Complete',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),


      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Green check icon
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: const Icon(Icons.check, color: Colors.white, size: 48),
                    ),
                    const SizedBox(height: 24),

                    // Main confirmation message
                    const Text(
                      'Your order is placed successfully.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600, // 600
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Subtext with order ID
                    Text(
                      'Your order ID: 2456',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500, // 500
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // "Track order" link-style text
                    TextButton(
                      onPressed: () {
                        // Navigate to tracking page
                      },
                      child: const Text(
                        'Track order',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500, // 500
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer Home button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF243BCD),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    // Navigate to HomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: const Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
