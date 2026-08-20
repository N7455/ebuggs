import 'package:flutter/material.dart';
import 'package:untitled/screen/Models/modela_page.dart';

import '../Deals/deals_cost.dart';
import '../detailspage/view_details.dart';
import '../filter/filter_page1.dart';
import '../notification/notification_page.dart';
import '../profile/profile_1.dart';
import 'animation_section.dart';
import 'custom_bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.grid_view, "label": "All"},
    {"icon": Icons.laptop, "label": "Laptop"},
    {"icon": Icons.desktop_windows, "label": "Desktop"},
    {"icon": Icons.phone_android, "label": "Phone"},
    {"icon": Icons.print, "label": "Printer"},
    {"icon": Icons.headphones, "label": "Accessories"},
  ];
  final List<String> dealTitles = [
    'Deal Under 5 Lakh',
    'Deal Under 3 Lakh',
    'Deal Under 1 Lakh',
    'Deal Under 50K',
  ];

  int currentCategoryIndex = 0;

  final List<Map<String, String>> products = [
    {
      'image': 'assets/images/image 6.png',
      'title': 'Apple MacBook Air',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/image 6.png',
      'title': 'Apple MacBook Air',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/image 81.png',
      'title': 'Apple MacBook Air M2 2023',
      'price': '₹ 89,900',
      'oldPrice': '₹ 1,19,900',
    },
    {
      'image': 'assets/images/image 6.png',
      'title': 'Apple MacBook Air',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/image 6.png',
      'title': 'Apple MacBook Air',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/image 81.png',
      'title': 'Apple MacBook Air M2 2023',
      'price': '₹ 89,900',
      'oldPrice': '₹ 1,19,900',
    },
    {
      'image': 'assets/images/image 6.png',
      'title': 'Apple MacBook Air',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/image 6.png',
      'title': 'Apple MacBook Air',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/image 81.png',
      'title': 'Apple MacBook Air M2 2023',
      'price': '₹ 89,900',
      'oldPrice': '₹ 1,19,900',
    },
  ];

  final ScrollController _categoryScrollController = ScrollController();
  final ScrollController _productScrollController = ScrollController();
  final Set<int> wishlist = {};

  @override
  @override
  void initState() {
    super.initState();

    _productScrollController.addListener(() {
      final screenWidth = MediaQuery.of(context).size.width;

      double spacing = 8;
      double itemWidth = (screenWidth - (3 * spacing)) / 4;
      double totalItemWidth = itemWidth + spacing;

      int itemIndex = (_productScrollController.offset / totalItemWidth)
          .round();

      int snapIndex = (itemIndex ~/ 4) * 4;

      int newCategoryIndex = (snapIndex ~/ 4).clamp(0, categories.length - 1);

      if (newCategoryIndex != currentCategoryIndex) {
        setState(() {
          currentCategoryIndex = newCategoryIndex;
        });

        _categoryScrollController.animateTo(
          newCategoryIndex * 72.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _productScrollController.dispose();
    _categoryScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        titleSpacing: 16,
        title: Row(
          children: [
            //  Profile Avatar
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MyAccountScreen()),
                );
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
                child: const Icon(Icons.person, color: Colors.black, size: 28),
              ),
            ),

            const SizedBox(width: 12),
            // 🔹 Welcome Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Welcome to Ebuggs',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kavita Rana',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.black),
            onPressed: () {
              debugPrint('Chat icon tapped');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        // selectedIndex: selectedIndex,
        // onItemTapped: onItemTapped,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Categories Bar (Horizontal)
            Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                  controller: _categoryScrollController,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 8,
                  ), // 👈 left ko 0 ya kam kar do
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = currentCategoryIndex == index;

                    // ✅ Fixed width for each category
                    double categoryWidth = 72;

                    return GestureDetector(
                      onTap: () {
                        // Scroll products by same fixed width
                        _productScrollController.animateTo(
                          index * categoryWidth,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        width: categoryWidth, // fixed width
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? const Color(0xFF243BCD)
                                    : Colors.white,
                                border: Border.all(color: Colors.black12),
                              ),
                              child: Icon(
                                category['icon'],
                                color: isSelected ? Colors.white : Colors.black,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category['label'],
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? const Color(0xFF243BCD)
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 10),

            //"See All" Button
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Align(
                alignment: Alignment.centerRight, // Aligns button to the end
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductApp()),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  splashColor: const Color(0xFF243BCD).withOpacity(0.2),
                  highlightColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black, // Text color
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.black, // Icon color
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 🔹 Vertical scroll for everything below categories
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 🔹 Products Grid (Horizontal)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: screenHeight * 0.60,
                        child: GridView.builder(
                          controller: _productScrollController,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1.40,
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            final isWishlisted = wishlist.contains(index);

                            return GestureDetector(
                              onTap: () {
                                // 🔹 Action when card is tapped
                                ///product: " ",
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ProductDetailPage(product: " "),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              left: 8,
                                            ),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF243BCD),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: const Text(
                                                "20% OFF",
                                                style: TextStyle(
                                                  fontFamily: "Inter",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                  ),
                                              child: Image.asset(
                                                product['image']!,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 6,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product['title']!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: "Inter",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF202020),
                                              ),
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product['price']!,
                                                      style: const TextStyle(
                                                        fontFamily: "Inter",
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Color(
                                                          0xFF202020,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      product['oldPrice']!,
                                                      style: const TextStyle(
                                                        fontFamily: "Inter",
                                                        fontSize: 9,
                                                        color: Color(
                                                          0xFF202020,
                                                        ),
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                      const BoxConstraints(),
                                                  icon: Icon(
                                                    isWishlisted
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: const Color(
                                                      0xFF243BCD,
                                                    ),
                                                    size: 24,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isWishlisted) {
                                                        wishlist.remove(index);
                                                      } else {
                                                        wishlist.add(index);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.32,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFDCDCDC).withOpacity(0.30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: Text(
                              'Deals',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.22,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dealTitles.length,
                              itemBuilder: (context, index) {
                                double cardWidth =
                                    MediaQuery.of(context).size.width * 0.38;
                                double imageHeight = cardWidth * 0.70;

                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to details page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DealsPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: cardWidth,
                                    margin: const EdgeInsets.only(right: 12),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Color(0xFF777777),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: imageHeight,
                                          width: cardWidth,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF777777),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Image.asset(
                                              'assets/images/rb_509 1.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          dealTitles[index],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 🔹 Promo Carousel (Vertical)
                    SizedBox(height: 180, child: PromoCarousel()),

                    const SizedBox(height: 12),

                    // 🔹 Extra Vertical scroll images/cards
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double maxWidth = constraints.maxWidth;
                        double containerWidth =
                            maxWidth * 0.35; // 35% of available width
                        double containerHeight =
                            containerWidth * 1.2; // maintain aspect ratio

                        List<String> imagePaths = [
                          'assets/images/phone2.png',
                          'assets/images/im.jpg',
                          'assets/images/frame1.png',
                        ];

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: imagePaths.map((imagePath) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: containerWidth,
                                    height: containerHeight,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Image.asset(
                                              imagePath,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Up to 30% off',
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
