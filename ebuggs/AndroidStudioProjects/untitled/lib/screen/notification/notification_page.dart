import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0, // 👈 spacing control
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Container(
        color: Colors.white, // 👈 background white
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _notificationCard(
                context,
                title: "New day, new deal. Don’t miss out!",
                subtitle: "Min. 50% off",
                description: "Shop @ Right To Electronic Sale Reloaded",
                timeAgo: "20 minutes ago",
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Shop Now clicked")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 👇 Yeh function properly define kiya gaya hai
  Widget _notificationCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required String description,
        required String timeAgo,
        required VoidCallback onTap,
      }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 👈 white background
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 140,
                width: double.infinity,
                color: const Color(0xFFD9D9D9), // Placeholder color
              ),
            ),
            const SizedBox(height: 10),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 4),

            // Subtitle
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 4),

            // Description
            Text(
              description,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            // Time ago
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  timeAgo,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Shop Now Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: const BorderSide(color: Color(0xFF243BCD)),
                ),
                child: const Text(
                  "Shop Now",
                  style: TextStyle(
                      color: Color(0xFF243BCD),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
