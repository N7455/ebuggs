
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int selectedOption = 1; // 1 = Yes, 0 = No
  final TextEditingController _experienceController = TextEditingController();

  // ratings ke liye map
  final Map<String, int> ratings = {
    "Product Condition": 0,
    "Quality Testing": 0,
    "Delivery Experience": 0,
    "Photo Accuracy": 0,
    "Customer Support": 0,
  };

  bool get isFormValid {
    return ratings.values.every((rate) => rate > 0) &&
        _experienceController.text.trim().isNotEmpty;
  }

  Widget buildStarRow(String title, double w) {
    int currentRating = ratings[title]!;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              color: const Color(0xFF121212),
              fontSize: w * 0.045,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(
              5,
                  (index) => IconButton(
                onPressed: () {
                  setState(() {
                    ratings[title] = index + 1;
                  });
                },
                icon: Icon(
                  index < currentRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: w * 0.07,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        toolbarHeight: 50, // ✅ Height fix
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Review",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            color: const Color(0xFF121212),
            fontSize: w * 0.05,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: w * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStarRow("Product Condition", w),
            buildStarRow("Quality Testing", w),
            buildStarRow("Delivery Experience", w),
            buildStarRow("Photo Accuracy", w),
            buildStarRow("Customer Support", w),
            SizedBox(height: w * 0.04),

            // Text Field
            Text(
              "Write your experience:",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: const Color(0xFF121212),
                fontSize: w * 0.045,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _experienceController,
                maxLines: 3,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
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
            SizedBox(height: w * 0.05),

            // Recommendation
            Text(
              "Would you recommend Ebuggs?",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                color: const Color(0xFF121212),
                fontSize: w * 0.045,
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
                SizedBox(width: w * 0.1), // ✅ Responsive gap
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

            SizedBox(height: w * 0.07),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isFormValid
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Review Submitted ✅")),
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormValid
                      ? const Color(0xFF1A36F5)
                      : Colors.grey.shade400,
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
