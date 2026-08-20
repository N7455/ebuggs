import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  int quantity;
  bool isSelected;

  CartItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
    this.isSelected = false,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(
      title: "Apple MacBook",
      description:
          "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model",
      imageUrl: 'assets/images/laptop.png',
      price: 49000,
      quantity: 56,
    ),
    CartItem(
      title: "Apple MacBook",
      description:
          "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model",
      imageUrl: 'assets/images/laptop.png',
      price: 49000,
      quantity: 56,
    ),
    CartItem(
      title: "Apple MacBook",
      description:
          "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model",
      imageUrl: 'assets/images/laptop.png',
      price: 49000,
      quantity: 56,
    ),
  ];

  double get totalPrice => cartItems
      .where((item) => item.isSelected)
      .fold(0, (sum, item) => sum + item.price);

  void toggleSelection(int index) {
    setState(() {
      cartItems[index].isSelected = !cartItems[index].isSelected;
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void checkout() {
    final selectedItems = cartItems.where((item) => item.isSelected).toList();
    if (selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one item.")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Proceeding to Checkout with ₹${totalPrice.toStringAsFixed(2)}",
        ),
      ),
    );
  }

  Widget buildSquareCheckbox(int index) {
    final item = cartItems[index];
    return GestureDetector(
      onTap: () => toggleSelection(index),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: item.isSelected ? Colors.indigo.shade900 : Colors.transparent,
          border: Border.all(
            color: item.isSelected ? Colors.indigo.shade900 : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: item.isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 14)
            : null,
      ),
    );
  }

  Widget buildSquareDeleteButton(int index) {
    return GestureDetector(
      onTap: () => removeItem(index),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
        child: const Icon(Icons.delete, size: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Navigator.pop(context),
              splashRadius: 20,
            ),
            const SizedBox(width: 4),
            const Text(
              "Cart",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: item.isSelected
                          ? Colors.indigo.shade900
                          : Colors.grey.shade300,
                      width: item.isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        item.imageUrl,
                        width: 70,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Quantity: ${item.quantity}",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "₹${item.price.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 130, // match image height
                        child: Column(
                          children: [
                            buildSquareCheckbox(index),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: buildSquareDeleteButton(index),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.indigo.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onPressed: checkout,
              child: Text(
                totalPrice > 0
                    ? "Checkout (₹${totalPrice.toStringAsFixed(2)})"
                    : "Checkout",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
