import 'package:flutter/material.dart';

import '../Checkout/check_page3.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  // Track which product buttons are selected
  final Set<int> cartSelected = {};
  final Set<int> buySelected = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final products = [
      {
        "status": "In Stock",
        "statusColor": const Color(0xFF7285FF),
        "image": "assets/images/image.png",
        "title":
        "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Refurbished)",
        "rating": 4,
        "reviews": 56,
        "price": "₹49,000.00",
        "oldPrice": "₹230,000.00",
      },
      {
        "status": "Out of Stock",
        "statusColor": const Color(0xFF7285FF),
        "image": "assets/images/laptop.png",
        "title":
        "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Refurbished)",
        "rating": 4,
        "reviews": 56,
        "price": "₹49,000.00",
        "oldPrice": "₹230,000.00",
      },
      {
        "status": "In Stock",
        "statusColor": const Color(0xFF7285FF),
        "image": "assets/images/phone.png",
        "title":
        "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Refurbished)",
        "rating": 4,
        "reviews": 56,
        "price": "₹49,000.00",
        "oldPrice": "₹230,000.00",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Wishlist",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          children: List.generate(products.length, (index) {
            final product = products[index];
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stock + Image
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * 0.02, vertical: h * 0.001),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(w * 0.01),
                            border: Border.all(
                              color: product["statusColor"] as Color,
                            ),
                          ),
                          child: Text(
                            product["status"] as String,
                            style: TextStyle(
                              color: product["statusColor"] as Color,
                              fontSize: w * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(w * 0.02),
                          child: Image.asset(
                            product["image"] as String,
                            width: w * 0.28,
                            height: w * 0.28,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: w * 0.03),

                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["title"] as String,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: w * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: h * 0.005),

                          // Rating
                          Row(
                            children: [
                              ...List.generate(5, (star) {
                                final rating = product["rating"] as int;
                                return Icon(
                                  star < rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: w * 0.04,
                                );
                              }),
                              SizedBox(width: w * 0.01),
                              Text(
                                "(${product["reviews"]})",
                                style: TextStyle(fontSize: w * 0.03),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.005),

                          // Price
                          Row(
                            children: [
                              Text(
                                product["price"] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: w * 0.04,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: w * 0.015),
                              Text(
                                product["oldPrice"] as String,
                                style: TextStyle(
                                  fontSize: w * 0.03,
                                  color: Colors.black54,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.01),

                          // Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Add to Cart Button
                              TextButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    cartSelected.contains(index)
                                        ? Colors.blue.shade900
                                        : Colors.transparent,
                                  ),
                                  foregroundColor: MaterialStateProperty.all(
                                    cartSelected.contains(index)
                                        ? Colors.white
                                        : const Color(0xFF444444),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.shopping_cart_outlined,
                                  size: w * 0.04,
                                ),
                                label: Text(
                                  "Add to cart",
                                  style: TextStyle(fontSize: w * 0.03),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (cartSelected.contains(index)) {
                                      cartSelected.remove(index);
                                    } else {
                                      cartSelected.add(index);
                                      // Show snackbar when added
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            "Added to cart",
                                            style:
                                            TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor: Colors.blue.shade900,
                                          duration:
                                          const Duration(seconds: 2),
                                        ),
                                      );
                                    }
                                  });
                                },
                              ),

                              // Buy Now Button
                              TextButton.icon(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    buySelected.contains(index)
                                        ? Colors.blue.shade900
                                        : Colors.transparent,
                                  ),
                                  foregroundColor: MaterialStateProperty.all(
                                    buySelected.contains(index)
                                        ? Colors.white
                                        : const Color(0xFF444444),
                                  ),
                                ),
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: w * 0.04,
                                ),
                                label: Text(
                                  "Buy Now",
                                  style: TextStyle(fontSize: w * 0.03),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>PaymentSelectionPage(),
                                    ),
                                  );
                                },

                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (index < products.length - 1)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * 0.02),
                    child: Divider(color: Colors.grey.shade300, thickness: 1),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
