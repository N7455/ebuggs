import 'package:flutter/material.dart';
import 'package:untitled/screen/profile/profile_3.dart';

 // <-- WishlistPage defined here
import '../Home/wishlist.dart';
import '../address/add _save_address.dart';
import '../checkout/check_page3.dart';
import '../loction/loction_page.dart';
import '../order/order_details.dart';
import '../rating/refers_page.dart';
import '../rating/reviews_page.dart';
import '../repair/repair_page.dart';

// ------------------- OTHER SCREENS -------------------
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: const Center(child: Text("Edit Profile Page")),
    );
  }
}

// Generic placeholder screen (reusable)
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text("This is $title page")),
    );
  }
}

// ------------------- EXTRA PAGES -------------------
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders")),
      body: const Center(child: Text("Your Orders list goes here")),
    );
  }
}

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Coupons")),
      body: const Center(child: Text("Your Coupons go here")),
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help Center")),
      body: const Center(child: Text("FAQs / Help Information")),
    );
  }
}

// ------------------- MAIN ACCOUNT SCREEN -------------------
class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final double width = media.width;
    final double height = media.height;

    double fs(double size) => size * width / 375;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black, size: fs(18)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Account",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: fs(18),
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            // Profile Info
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: width * 0.09,
                    backgroundImage: const AssetImage("assets/images/photo.jpg"),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: width * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kavita",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          fontSize: fs(16),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: height * 0.005),
                      Text(
                        "9628707560",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          fontSize: fs(14),
                          color: const Color(0xFF383838),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ProfileScreen()),
                      );
                    },
                    icon: Icon(Icons.edit, color: Colors.blue, size: fs(16)),
                    label: Text(
                      "Edit",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        fontSize: fs(14),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),

            // Invite Friends Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Invite friends & earn",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            fontSize: fs(14),
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "You get \$100 cashback on every friend.",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            fontSize: fs(12),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: fs(14), color: Colors.grey[700]),
                ],
              ),
            ),

            SizedBox(height: height * 0.01),

            // --- Grid Buttons (Orders, Wishlist, Coupons, Help Center) ---
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.02),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: height * 0.015,
                crossAxisSpacing: width * 0.04,
                childAspectRatio: 2.8,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _gridButton(context, Icons.inventory_2_outlined, "Orders", fs, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) =>  OrdersScreen ()),
                    );
                  }),
                  _gridButton(context, Icons.favorite_border, "Wishlist", fs, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const WishlistPage()),
                    );
                  }),
                  _gridButton(context, Icons.confirmation_num_outlined, "Coupons", fs, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CouponsPage()),
                    );
                  }),
                  _gridButton(context, Icons.headset_mic_outlined, "Help Center", fs, () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HelpCenterPage()),
                    );
                  }),
                ],
              ),
            ),

            SizedBox(height: height * 0.01),

            // Account Settings
            _sectionTitle("Account Settings", fs),
            _borderTile(context, "Edit Profile", () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfileScreen()));
            }, fs),
            _borderTile(context, "Saved Addresses", () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => SavedAddressesScreen()));
            }, fs),
            _borderTile(context, "Payments", () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentSelectionPage()));
            }, fs),

            SizedBox(height: height * 0.02),

            // Services
            _sectionTitle("Services", fs),
            _borderTile(context, "Repairs", () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) =>RepairOptionsPage()),
              );
            }, fs),

            _borderTile(context, "Complaints", () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) =>ReviewPage ()),
              // );
            }, fs),

            SizedBox(height: height * 0.02),


            // Others
            _borderTile(context, "Records", () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (_) =>LocationPage ()),
              // );
            }, fs),
            _borderTile(context, "Buyers tool for retailing", () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) =>ReferEarnPage ()),
              );
            }, fs),

            _borderTile(context, "FAQs", () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PlaceholderScreen(title: "FAQs")),
              );
            }, fs),
            _borderTile(context, "Privacy", () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PlaceholderScreen(title: "Privacy")),
              );
            }, fs),

            SizedBox(height: height * 0.03),

            // Logout
            _borderTileLogout(context, "Log out", fs),
          ],
        ),
      ),
    );
  }

  // ---------- HELPERS ----------
  Widget _sectionTitle(String title, double Function(double) fs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          fontSize: fs(16),
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _borderTile(
      BuildContext context,
      String title,
      VoidCallback onTap,
      double Function(double) fs,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: fs(14),
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: fs(14), color: Colors.grey[700]),
        onTap: onTap,
      ),
    );
  }

  Widget _borderTileLogout(BuildContext context, String title, double Function(double) fs) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black54, width: 1),
      ),
      child: ListTile(
        leading: Icon(Icons.logout, color: Colors.red, size: fs(20)),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: fs(15),
            color: Colors.red,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: fs(14), color: Colors.red),
        onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
    );
  }

  // icon text grid button
  Widget _gridButton(
      BuildContext context,
      IconData icon,
      String label,
      double Function(double) fs,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: fs(18), color: Colors.black),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: fs(14),
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
