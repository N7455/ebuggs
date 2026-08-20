import 'package:flutter/material.dart';
import 'package:untitled/screen/order/order_details.dart' show OrdersScreen;
import '../detailspage/view_details.dart';
import 'order_details2.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({super.key});

  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {
  // Sample data for products
  List<Map<String, dynamic>> products = [
    {
      "title": "Apple macbook air mid 2017 (13\" intel core i5)...",
      "image": "assets/images/image 6.png",
      "price": 11299,
      "discountPrice": 7399,
      "discount": "35%",
      "isWishlisted": false,
    },
    {
      "title": "Apple iPhone 12",
      "image": "assets/images/phone.png",
      "price": 6999,
      "discountPrice": 5999,
      "discount": "15%",
      "isWishlisted": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // screen size
    double screenWidth = size.width;
    int crossAxisCount = 2; // for GridView

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        titleSpacing: 0,
        title: const Text(
          "Arriving Tomorrow",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SEE ALL ORDERS button
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersScreen(),
                    ),
                  );
                },
                child: const Text(
                  "See All Orders",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            // Product Image
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/laptop.png',
                  fit: BoxFit.contain,
                  width: size.width * 0.8, // responsive width
                  height: size.height * 0.3, // responsive height
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFCDCDCD), thickness: 2),
            const SizedBox(height: 15),

            // Shipping progress
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Shipped",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Package has left",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildStep("Ordered", true),
                    buildLine(true),
                    _buildStep("Shipped", true),
                    buildLine(false),
                    _buildStep("Out for delivery", false),
                    buildLine(false),
                    _buildStep("Delivered", false),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Order info
            Column(
              children: [
                const Divider(
                  color: Color(0xFFCDCDCD),
                  thickness: 1,
                  height: 1,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  title: const Text(
                    "Order Info",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailsPage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  color: Color(0xFFCDCDCD),
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Recommended products
            const Text(
              "Recommended for you based on your order....",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.70,
                mainAxisSpacing: screenWidth * 0.03,
                crossAxisSpacing: screenWidth * 0.03,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  title: product["title"],
                  imageUrl: product["image"],
                  price: product["price"],
                  discountPrice: product["discountPrice"],
                  discount: product["discount"],
                  isWishlisted: product["isWishlisted"],
                  onWishlistToggle: () {
                    setState(() {
                      products[index]["isWishlisted"] =
                      !products[index]["isWishlisted"];
                    });
                  },
                  onArrivingTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ProductDetailPage()),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String label, bool done) {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: done ? Colors.blue[800] : Colors.grey[300],
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: done ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: active ? Colors.blue[800] : Colors.grey[300],
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}


// ProductCard class moved **outside** OrderTrackingPage

class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String discount;
  final bool isWishlisted;
  final VoidCallback onWishlistToggle;
  final VoidCallback onArrivingTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.discountPrice,
    required this.discount,
    required this.isWishlisted,
    required this.onWishlistToggle,
    required this.onArrivingTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double imageHeight =
    screenWidth > 900 ? 160 : screenWidth > 600 ? 140 : 120;
    double titleFontSize =
    screenWidth > 900 ? 16 : screenWidth > 600 ? 14 : 12;
    double priceFontSize =
    screenWidth > 900 ? 16 : screenWidth > 600 ? 14 : 12;
    double discountFontSize =
    screenWidth > 900 ? 14 : screenWidth > 600 ? 12 : 10;
    double iconSize = screenWidth > 900 ? 22 : screenWidth > 600 ? 20 : 18;
    double sidePadding = screenWidth * 0.00; // 3% of screen width

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: InkWell(
        onTap: onArrivingTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  children: [
                    // Add top padding to move image slightly down
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0), // adjust this value as needed
                      child: SizedBox(
                        height: imageHeight,
                        width: double.infinity,
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                    // Discount badge
                    Positioned(
                      top: 6,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF243BCD),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "$discount OFF",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: discountFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Details Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹$discountPrice",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: priceFontSize,
                                ),
                              ),
                              Text(
                                "₹$price",
                                style: TextStyle(
                                  fontSize: priceFontSize - 2,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            isWishlisted ? Icons.favorite : Icons.favorite_border,
                            color: isWishlisted ? const Color(0xFF243BCD) : Colors.grey,
                            size: iconSize,
                          ),
                          onPressed: onWishlistToggle,
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

