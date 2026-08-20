import 'package:flutter/material.dart';
import 'package:untitled/screen/order/track_order.dart';

import '../detailspage/view_details.dart';

import 'arraving_tomorror.dart';

// ---------------- Orders Screen ----------------
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<Map<String, dynamic>> products = [
    {
      "title": "Apple macbook air mid 2017 (13\" intel core i5)",
      "image": "assets/images/image 6.png",
      "price": 11290,
      "discountPrice": 7290,
      "discount": "35%",
      "isWishlisted": false,
    },
    {
      "title": "Redmi Note 12 Pro 5G (Glacier Blue, 128GB)",
      "image": "assets/images/laptop.png",
      "price": 14999,
      "discountPrice": 9999,
      "discount": "35%",
      "isWishlisted": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Orders',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isDesktop
                ? 22
                : isTablet
                ? 20
                : 18,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(screenWidth * 0.01),
          children: [
            _OrderCard(
              title: 'Apple MacBook Pro 16-inch i7 Touch Bar A2141 2019',
              price: '\$400',
              quantity: 55,
              status: 'Arriving Tuesday',
              isDelivered: false,
              image: "assets/images/image 81.png",
              onStatusTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderTrackingPage()),
                );
              },
              onTrackTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderTrackingPage()),
                );
              },
            ),
            SizedBox(height: screenWidth * 0.02),
            _OrderCard(
              title: 'Redmi Note 12 Pro 5G (Glacier Blue, 128GB)',
              price: '\$400',
              quantity: 55,
              status: 'Arriving Tomorrow',
              isDelivered: false,
              image: "assets/images/image.png",
              onStatusTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OrderTrackingPage()),
                );
              },
              onTrackTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TrackOrderPage()),
                );
              },
            ),
            SizedBox(height: screenWidth * 0.02),
            _OrderCard(
              title: 'Dell Inspiron 15 5000 (Core i7, 16GB RAM)',
              price: '\$400',
              quantity: 55,
              status: 'Delivered',
              isDelivered: true,
              image: "assets/images/phone.png",
            ),
            SizedBox(height: screenWidth * 0.03),
            _buildProductsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth > 1500) {
      crossAxisCount = 5;
    } else if (screenWidth > 800) {
      crossAxisCount = 4;
    } else if (screenWidth > 500) {
      crossAxisCount = 3;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
          child: Text(
            'Recommended for you based on your\norder....',
            style: TextStyle(
              fontSize: screenWidth > 900
                  ? 20
                  : screenWidth > 600
                  ? 18
                  : 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.72,
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
    );
  }
}

// ---------------- Order Card ----------------
class _OrderCard extends StatelessWidget {
  final String title;
  final String price;
  final int quantity;
  final String status;
  final bool isDelivered;
  final String image;
  final VoidCallback? onStatusTap;
  final VoidCallback? onTrackTap;

  const _OrderCard({
    required this.title,
    required this.price,
    required this.quantity,
    required this.status,
    required this.isDelivered,
    required this.image,
    this.onStatusTap,
    this.onTrackTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.25,
            height: screenWidth * 0.20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: screenWidth > 900
                        ? 18
                        : screenWidth > 600
                        ? 16
                        : 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Price: $price',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth > 900 ? 16 : 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: Text(
                        'Qty: $quantity',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth > 900 ? 16 : 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: !isDelivered ? onStatusTap : null,
                        child: Text(
                          status,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: screenWidth > 900 ? 16 : 12,
                            fontWeight: FontWeight.w500,
                            color: !isDelivered
                                ? const Color(0xFF1A43FF)
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    if (!isDelivered && onTrackTap != null)
                      Flexible(
                        child: GestureDetector(
                          onTap: onTrackTap,
                          child: Text(
                            'Track Order',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: screenWidth > 900 ? 16 : 12,
                              color: const Color(0xFF1A43FF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- Product Card ----------------
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

    double imageHeight = screenWidth > 900
        ? 160
        : screenWidth > 600
        ? 140
        : 120;
    double titleFontSize = screenWidth > 900
        ? 16
        : screenWidth > 600
        ? 14
        : 12;
    double priceFontSize = screenWidth > 900
        ? 16
        : screenWidth > 600
        ? 14
        : 12;
    double discountFontSize = screenWidth > 900
        ? 14
        : screenWidth > 600
        ? 12
        : 10;
    double iconSize = screenWidth > 900
        ? 22
        : screenWidth > 600
        ? 20
        : 18;
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
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Add top padding to move image slightly down
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25.0,
                      ), // adjust this value as needed
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
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
                            isWishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isWishlisted
                                ? const Color(0xFF243BCD)
                                : Colors.grey,
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
