import 'package:flutter/material.dart';
import 'package:untitled/screen/Home/wishlist.dart';

import '../search/search_page.dart';
import 'Homepage.dart';
import 'add_cart.dart';                 // SearchPage()
                              // HomePage()

/// --------------------
/// Custom Bottom Navigation Bar
/// --------------------
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navIcon(
            context: context,
            icon: Icons.home,
            page: HomePage(),
          ),
          _navIcon(
            context: context,
            icon: Icons.favorite_border,
            page: WishlistPage(),
          ),
          _buyToggle(context, SearchPage()), // Buy toggle navigates to SearchPage
          _navIcon(
            context: context,
            icon: Icons.search,
            page: SearchPage(),
          ),
          _navIcon(
            context: context,
            icon: Icons.shopping_cart_outlined,
            page:CartPage(),
          ),
        ],
      ),
    );
  }

  Widget _navIcon({
    required BuildContext context,
    required IconData icon,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(icon, color: Colors.black54),
      ),
    );
  }

  Widget _buyToggle(BuildContext context, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          children: [
            Icon(Icons.paid_rounded, color: Colors.white, size: 20),
            SizedBox(width: 6),
            Text("Buy", style: TextStyle(color: Colors.white)),
            SizedBox(width: 6),
            Icon(Icons.toggle_off, color: Colors.white, size: 25),
          ],
        ),
      ),
    );
  }
}

/// --------------------
/// Main Screen
/// --------------------
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(), // Initial screen
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
