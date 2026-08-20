import 'package:flutter/material.dart';
import 'package:untitled/screen/Checkout/check_page3.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navButton(context, icon: Icons.shopping_cart, index: 0),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buyNowButton(context: context, index: 1),
            ),
          ),
          _navButton(context, icon: Icons.tune, index: 2),
        ],
      ),
    );
  }

  Widget _navButton(
      BuildContext context, {
        required IconData icon,
        required int index,
      }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        if (index == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item added to cart!"),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        onTap(index);
      },
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2B44FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF2B44FF) : Colors.grey.shade400,
            width: 2,
          ),
        ),
        child: Icon(icon, color: isSelected ? Colors.white : Colors.black87),
      ),
    );
  }

  Widget _buyNowButton({required int index, required BuildContext context}) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        onTap(index);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  PaymentSelectionPage()),
        );
      },
      child: Container(
        height: 50,
        width: 140, // normal width
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF2B44FF), // Dark Blue
          borderRadius: BorderRadius.circular(25), // 🔹 दोनों side fully curved (pill)
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: const Text(
          "Buy it now",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );


  }
}
