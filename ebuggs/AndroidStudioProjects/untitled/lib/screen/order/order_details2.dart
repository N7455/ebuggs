import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  // Sample products list
  List<Map<String, dynamic>> products = [
    {
      "title": "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019",
      "image": "assets/images/laptop.png",
      "price": 400,
      "discountPrice": 350,
      "discount": "12%",
      "isWishlisted": false,
    },
    {
      "title": "Apple MacBook Pro 14-inch i5 2021",
      "image": "assets/images/laptop.png",
      "price": 300,
      "discountPrice": 270,
      "discount": "10%",
      "isWishlisted": true,
    },
  ];

  // Determine crossAxisCount based on screen width
  int crossAxisCount(double screenWidth) {
    if (screenWidth > 900) return 4;
    if (screenWidth > 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.04; // 4% padding

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.pop(context);
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        title: const Text(
          'Order Details',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF111111),
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Info Container
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: const Color(0xFFCDCDCD)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order placed & Date Row
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Order placed",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF555555),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "12 July 2025",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xFF121212),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Order ID",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Color(0xFF555555),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "04-3284-8901",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      color: Color(0xFF121212),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color(0xFFCDCDCD),
                      thickness: 2,
                      height: 2,
                    ),
                    // Download Invoice Row
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/downloading data (1).png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "Download Invoice",
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color(0xFF121212),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF1E3A8A),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(25)),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text("Invoice Downloaded"),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Download",
                                        style: TextStyle(
                                          fontFamily: 'Inter',
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
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Download Invoice",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF222222),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFF999999),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFCDCDCD), thickness: 2),
              const SizedBox(height: 16),

              // Arriving Item
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: const Color(0xFFCDCDCD)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Arriving Tomorrow",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF111111),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            "assets/images/laptop.png",
                            width: screenWidth * 0.15,
                            height: screenWidth * 0.15,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF111111),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  Flexible(
                                    child: Text(
                                      'Price: \$400',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Color(0xFF555555),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Flexible(
                                    child: Text(
                                      'Quantity: 55',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color: Color(0xFF555555),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Color(0xFF999999),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFFCDCDCD), thickness: 2),
              const SizedBox(height: 16),

              // Payment Method
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Payment method',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Google Pay',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xFF222222),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Color(0xFF999999),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Color(0xFFCDCDCD), thickness: 2),

              // Order Summary
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Order Summary',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: const Color(0xFFCDCDCD)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: const [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item(s) Subtotal:',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF222222),
                          ),
                        ),
                        Text(
                          '\$59,499.00',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping:',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF222222),
                          ),
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Marketplace Fee:',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF222222),
                          ),
                        ),
                        Text(
                          '\$5.00',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                          ),
                        ),
                        Text(
                          '\$59,504.00',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF111111),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Recommended for you based on your order....",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount(screenWidth),
                  childAspectRatio: 0.68,
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
                      // Navigate to product detail
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ProductCard Class (outside the OrderDetailsPage)
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
                      padding: const EdgeInsets.only(top: 15.0), // adjust this value as needed
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



