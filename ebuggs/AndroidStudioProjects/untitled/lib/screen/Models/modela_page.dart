import 'package:flutter/material.dart';
import 'package:untitled/screen/Checkout/check_page3.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Model',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: ProductListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final List<Product> products = List.generate(
    4,
        (index) => Product(
      title:
      'Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Refurbished)',
      imageUrl:
      'https://via.placeholder.com/150x100.png?text=MacBook+${index + 1}',
      price: 49000,
      originalPrice: 239000,
      rating: 4.2,
      reviewCount: 56,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(
          'Models',
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        titleSpacing: 4.0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: products[index],
            width: width,
            height: height,
          );
        },
      ),
    );
  }
}

class Product {
  final String title;
  final String imageUrl;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviewCount;

  Product({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviewCount,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;
  final double width;
  final double height;

  const ProductCard(
      {required this.product, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Image.network(
              product.imageUrl,
              width: width * 0.25,
              height: height * 0.12,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/G.png',
                  width: width * 0.25,
                  height: height * 0.12,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(width: width * 0.015),
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.045,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: height * 0.006),
                // Price
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: width * 0.045,
                            fontFamily: 'Inter'),
                      ),
                    ),
                    SizedBox(width: width * 0.01),
                    Flexible(
                      child: Text(
                        '₹${product.originalPrice.toStringAsFixed(0)}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: width * 0.04,
                            fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.006),
                // Stars + Rating
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      if (index < product.rating.floor()) {
                        return Icon(Icons.star,
                            color: Colors.orange, size: width * 0.04);
                      } else if (index < product.rating) {
                        return Icon(Icons.star_half,
                            color: Colors.orange, size: width * 0.04);
                      } else {
                        return Icon(Icons.star_border,
                            color: Colors.orange, size: width * 0.04);
                      }
                    }).map((e) => Padding(
                      padding: EdgeInsets.only(right: width * 0.005),
                      child: e,
                    )),
                    Flexible(
                      child: Text(
                        '${product.rating} (${product.reviewCount})',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: width * 0.04, fontFamily: 'Inter'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.01),
                // Buttons Row
                Row(
                  children: [
                    // Add to cart Button
                    Flexible(
                      child: TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Added to cart successfully!"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Icon(Icons.add_shopping_cart,
                            color: Colors.black, size: width * 0.04 + 4),
                        label: Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            "Add to cart",
                            style: TextStyle(
                              fontSize: width * 0.030,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    // Buy Now Button
                    Flexible(
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  PaymentSelectionPage()),
                          );
                        },
                        icon: Icon(Icons.shopping_bag,
                            color: Colors.black, size: width * 0.04 + 4),
                        label: Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Text(
                            "Buy now",
                            style: TextStyle(
                              fontSize: width * 0.030,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
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


