import 'package:flutter/material.dart';

class DealDetailsPage extends StatelessWidget {
  const DealDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,

        // 🔹 Back icon aur title ke bich ka gap control
        leadingWidth: 40,
        titleSpacing: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Deals Details',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: responsiveFont(context, 18),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Deal Image (center aligned)
            Center(
              child: Image.asset(
                'assets/images/laptop.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            // Deal Price
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Under 10 Lakh',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: responsiveFont(context, 16),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Price: ₹ 6,41,284',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: responsiveFont(context, 14),
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Items under Deal',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: responsiveFont(context, 16),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const ProductCard();
                },
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFBEBEBE)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Color(0xFF4A4A4A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D60FF),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Buy Now',
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/laptop.png',
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                InfoText(label: 'Product: ', value: 'Dell Desktop'),
                InfoText(label: 'Brand: ', value: 'Dell'),
                InfoText(label: 'RAM: ', value: '4 GB'),
                InfoText(label: 'Storage: ', value: '256 GB'),
                InfoText(label: 'Processor: ', value: 'i5'),
                InfoText(label: 'Quantity: ', value: '5'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String label;
  final String value;

  const InfoText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
        style: const TextStyle(
          fontFamily: "Inter",
          fontSize: 13,
        ),
      ),
    );
  }
}

/// 🔹 Helper function for responsive font sizes
double responsiveFont(BuildContext context, double baseSize) {
  final size = MediaQuery.of(context).size.width;
  return baseSize * (size / 375); // base width = 375
}
