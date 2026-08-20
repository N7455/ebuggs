import 'dart:async';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ===== Carousel setup =====
  final PageController _pageController = PageController();
  int currentPage = 0;
  late Timer _timer;

  List<String> posters = [
    'assets/images/n.png',
    'assets/images/n.png',
  ];

  String? selectedBrand;
  bool showAllBrands = false;

  final List<Map<String, String>> allBrands = [
    {"name": "Lenovo", "logo": "assets/images/logol.png"},
    {"name": "Asus", "logo": "assets/images/logol.png"},
    {"name": "HP", "logo": "assets/images/logol.png"},
    {"name": "Dell", "logo": "assets/images/logol.png"},
    {"name": "MSI", "logo": "assets/images/logol.png"},
    {"name": "Acer", "logo": "assets/images/logol.png"},
    {"name": "Apple", "logo": "assets/images/logol.png"},
    {"name": "Samsung", "logo": "assets/images/logol.png"},
    {"name": "Sony", "logo": "assets/images/logol.png"},
  ];

  final List<Map<String, dynamic>> products = [
    {
      "title": "Apple macbook air mid 2017 (13\" intel core i5)",
      "image": "assets/images/moblie.png",
      "price": 11290,
      "discountPrice": 7290,
      "discount": "-35%",
      "isWishlisted": false,
    },
    {
      "title": "Redmi Note 12 Pro 5G (Glacier Blue, 128GB)",
      "image": "assets/images/image 6.png",
      "price": 14999,
      "discountPrice": 9999,
      "discount": "-35%",
      "isWishlisted": false,
    },
  ];

  // ===== Tabs setup =====
  String selectedTab = "Recommended";
  final List<String> tabs = ["Recommended", "Popular", "Trending"];

  // Search Controller
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Timer that cycles forward and wraps to 0 when it reaches the end
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      if (posters.isEmpty) return;

      int nextPage = currentPage + 1;

      if (_pageController.hasClients) {
        if (nextPage >= posters.length) {
          // reached end -> wrap to first (instant jump to avoid reverse animation)
          nextPage = 0;
          _pageController.jumpToPage(nextPage);
          setState(() => currentPage = nextPage);
        } else {
          // normal forward animation
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
          setState(() => currentPage = nextPage);
        }
      } else {
        // fallback if controller not attached yet
        setState(() => currentPage = nextPage >= posters.length ? 0 : nextPage);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    _searchController.dispose();
    super.dispose();
  }

  // ===== (rest of your widgets stay unchanged) =====

  // ===== Search Bar =====
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(
          fontFamily: "Inter",
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Search products...",
          hintStyle: const TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            color: Colors.black54,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),
        ),
      ),
    );
  }

  // ===== Carousel Widget =====
  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: posters.length,
              onPageChanged: (page) {
                setState(() => currentPage = page);
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    posters[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image, size: 40)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              posters.length,
                  (index) => Container(
                margin: const EdgeInsets.all(4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPage == index ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Brand Buttons with "+ more" =====
  Widget _buildBrandButtons() {
    final displayedBrands = showAllBrands ? allBrands : allBrands.take(5).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: showAllBrands ? displayedBrands.length : displayedBrands.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
        ),
        itemBuilder: (context, index) {
          if (!showAllBrands && index == displayedBrands.length) {
            int remaining = allBrands.length - displayedBrands.length;
            return OutlinedButton(
              onPressed: () => setState(() => showAllBrands = true),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                side: BorderSide(color: Colors.grey.shade400, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("+ $remaining more", style: const TextStyle(fontSize: 14, color: Colors.black87)),
            );
          }

          final brand = displayedBrands[index];
          bool isSelected = selectedBrand == brand["name"];

          return OutlinedButton(
            onPressed: () => setState(() => selectedBrand = brand["name"]),
            style: OutlinedButton.styleFrom(
              backgroundColor: isSelected ? Colors.blue.shade50 : Colors.white,
              side: BorderSide(color: isSelected ? Colors.blue : Colors.grey.shade400, width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(6),
            ),
            child: Image.asset(
              brand["logo"]!,
              height: MediaQuery.of(context).size.width * 0.50,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  // ===== Tabs Row =====
  Widget _buildTabsRow() {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.038;
    final indicatorWidth = screenWidth * 0.12;
    final indicatorHeight = screenWidth * 0.008;
    final dividerIndent = screenWidth * 0.04;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02, horizontal: screenWidth * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabs.map((tab) {
              bool isSelected = selectedTab == tab;
              return GestureDetector(
                onTap: () => setState(() => selectedTab = tab),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tab,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: fontSize,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected ? Colors.black : Colors.grey.shade600,
                        )),
                    SizedBox(height: screenWidth * 0.01),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: indicatorHeight,
                      width: indicatorWidth,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: screenWidth * 0.015),
        Divider(
          thickness: 1,
          color: Colors.grey.shade300,
          indent: dividerIndent,
          endIndent: dividerIndent,
        ),
      ],
    );
  }

  // ===== Products Grid =====
  Widget _buildProductsGrid() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;
          if (screenWidth > 900) crossAxisCount = 4;
          else if (screenWidth > 600) crossAxisCount = 3;

          double aspectRatio = screenWidth < 350 ? 0.53 : 0.64;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
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
                    products[index]["isWishlisted"] = !products[index]["isWishlisted"];
                  });
                },
              );
            },
          );
        },
      ),
    );
  }

  // ===== Scaffold with AppBar =====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 40,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Search",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),

      body: ListView(
        children: [
          _buildSearchBar(),
          _buildCarousel(),
          _buildBrandButtons(),
          _buildTabsRow(),
          _buildProductsGrid(),
        ],
      ),
    );
  }
}

// ProductCard class stays the same as your original
class ProductCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int price;
  final int discountPrice;
  final String discount;
  final bool isWishlisted;
  final VoidCallback onWishlistToggle;

  const ProductCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.discountPrice,
    required this.discount,
    required this.isWishlisted,
    required this.onWishlistToggle,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth * 0.45;
    final titleFont = screenWidth * 0.032;
    final priceFont = screenWidth * 0.034;
    final discountFont = screenWidth * 0.030;
    final iconSize = screenWidth * 0.055;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1, offset: Offset(1, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(imageUrl, height: imageHeight, width: double.infinity, fit: BoxFit.contain),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "$discount off",
                    style: TextStyle(
                      fontSize: discountFont,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: "Inter", fontSize: titleFont, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Row(
                  children: [
                    Text("₹$discountPrice",
                        style: TextStyle(fontFamily: "Inter", fontSize: priceFont, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(width: 6),
                    Text("₹$price",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: discountFont,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough)),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: onWishlistToggle,
                  icon: Icon(isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted ? Colors.blue : Colors.grey, size: iconSize),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
