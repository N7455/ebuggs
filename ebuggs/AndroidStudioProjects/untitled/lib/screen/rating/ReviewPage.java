import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedOption = 1; // 1 = Yes, 0 = No

  Widget buildStarRow(String title, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              color: Color(0xFF121212),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(
              5,
              (index) => const Icon(
                Icons.star,
                color: Colors.amber,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Review",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            color: Color(0xFF121212),
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStarRow("Product Condition:", w * 0.06),
            buildStarRow("Quality Testing:", w * 0.06),
            buildStarRow("Delivery Experience:", w * 0.06),
            buildStarRow("Photo Accuracy:", w * 0.06),
            buildStarRow("Customer Support:", w * 0.06),
            const SizedBox(height: 14),

            // Text Field
            const Text(
              "Write your experience:",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: Color(0xFF121212),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Share your experience...",
                  hintStyle: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Recommendation
            const Text(
              "Would you recommend Ebuggs?",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: Color(0xFF121212),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Radio<int>(
                  value: 1,
                  groupValue: selectedOption,
                  onChanged: (val) {
                    setState(() {
                      selectedOption = val!;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                const Text("Yes",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF121212),
                    )),
                const SizedBox(width: 16),
                Radio<int>(
                  value: 0,
                  groupValue: selectedOption,
                  onChanged: (val) {
                    setState(() {
                      selectedOption = val!;
                    });
                  },
                  activeColor: Colors.blue,
                ),
                const Text("No",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF121212),
                    )),
              ],
            ),

            const SizedBox(height: 25),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A36F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
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
