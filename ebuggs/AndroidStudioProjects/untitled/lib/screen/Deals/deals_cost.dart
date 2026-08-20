import 'package:flutter/material.dart';

import 'deal_details.dart';

class DealsPage extends StatelessWidget {
  const DealsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leadingWidth: 60,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Deals Under 5 Lakh',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: responsiveFont(context, 18),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DealCard(
              imagePath: 'assets/images/image 6.png',
              condition: 'Refurbished',
              title: 'Apple MacBook',
              subtitle:
              'Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Ref...)',
              quantity: 50,
              price: 4.75,
              unitPrice: 9500,
              dealType: 'Bidding available',
            ),
          );
        },
      ),
    );
  }
}

class DealCard extends StatelessWidget {
  final String imagePath;
  final String condition;
  final String title;
  final String subtitle;
  final int quantity;
  final double price;
  final double unitPrice;
  final String dealType;

  const DealCard({
    super.key,
    required this.imagePath,
    required this.condition,
    required this.title,
    required this.subtitle,
    required this.quantity,
    required this.price,
    required this.unitPrice,
    required this.dealType,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // 📱 responsive
    final double fontScale = size.width / 375;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: size.width * 0.28,
                height: size.width * 0.28,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16 * fontScale,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6F0FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            condition,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10 * fontScale,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2D60FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4 * fontScale),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12 * fontScale,
                        color: const Color(0xFF6B6B6B),
                      ),
                    ),
                    SizedBox(height: 6 * fontScale),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Quantity: $quantity Units',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 10 * fontScale,
                              color: const Color(0xFF4A4A4A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '₹${price.toStringAsFixed(2)} Lakh for $quantity Units',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 13 * fontScale,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(₹${unitPrice.toStringAsFixed(0)}/unit)',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10 * fontScale,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * fontScale),

          /// 🔹 Divider before deal type
          const Divider(thickness: 1, height: 20, color: Color(0xFFE0E0E0)),

          Row(
            children: [
              Text(
                'Deal Type: ',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13 * fontScale,
                  color: const Color(0xFF6B6B6B),
                ),
              ),
              Text(
                dealType,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13 * fontScale,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 10 * fontScale),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D60FF),
                    padding: EdgeInsets.symmetric(vertical: 10 * fontScale),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Start Bidding',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 13 * fontScale,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              /// 🔹 Only text clickable (GestureDetector)
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DealDetailsPage(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 13 * fontScale,
                        color: const Color(0xFF2D60FF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔹 Helper function for responsive font sizes
double responsiveFont(BuildContext context, double baseSize) {
  final size = MediaQuery.of(context).size.width;
  return baseSize * (size / 375); // base width = 375
}
