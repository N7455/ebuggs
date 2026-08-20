import 'dart:async';
import 'package:flutter/material.dart';
import 'footer_detail_page.dart';

class ProductDetailPage extends StatefulWidget {
  final dynamic product; // or Product product;
  ProductDetailPage({super.key, this.onPressed, this.product});

  final PageController _pageController = PageController(viewportFraction: 0.9);
  final VoidCallback? onPressed;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _showOptions = false;
  bool _isPressed = false;

  final TextEditingController _controller = TextEditingController();
  String selectedSize = "512 HDD";
  String selectedRam = "16GB";
  String selectedProcessor = "Intel Corei7";
  String selectedWarranty = "1 Year";
  String selectedOS = "Windows";
  bool isWishlisted = false;
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  Timer? _timer;
  int currentCategoryIndex = 0;
  int selectedIndex = 0;

  final Set<int> wishlist = {};

  void onItemTapped(int index) {
    setState(() => selectedIndex = index);

    if (index == 0) {
      print("tapped");
    } else if (index == 1) {
      print("tapped");
    } else if (index == 2) {
      _openFilterSheet();
    }
  }

  // ---------------- BUY NOW SHEET ----------------
  void _openBuyNowSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              _dragHandle(),
              const Text(
                "💳 Buy Now",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.credit_card),
                title: Text("Credit / Debit Card"),
              ),
              const ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text("Wallet / UPI"),
              ),
              const ListTile(
                leading: Icon(Icons.money),
                title: Text("Cash on Delivery"),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {},
                child: const Text("Confirm Payment"),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------- FILTER SHEET ----------------

  void _openFilterSheet() {
    String selectedRam = "16GB";
    String selectedProcessor = "Intel";
    String selectedWarranty = "3 months";
    String selectedOS = "Windows";
    String selectedColor = "White";

    // press states (persist)
    bool isApplyPressed = false;
    Map<String, bool> isOptionPressed = {};
    Map<String, bool> isColorPressed = {};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            TextStyle labelStyle = const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 16,
            );

            Widget buildOption(
              String value,
              String groupValue,
              Function(String) onSelect,
            ) {
              final bool isSelected = value == groupValue;
              final bool pressed = isOptionPressed[value] ?? false;

              return Expanded(
                child: GestureDetector(
                  onTapDown: (_) =>
                      setModalState(() => isOptionPressed[value] = true),
                  onTapUp: (_) {
                    setModalState(() {
                      isOptionPressed[value] = false;
                      onSelect(value); // update selection
                    });
                  },
                  onTapCancel: () =>
                      setModalState(() => isOptionPressed[value] = false),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue[900] // selected
                          : pressed
                          ? Colors.blue[900] // while pressing
                          : Colors.grey[300], // normal
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      style: labelStyle.copyWith(
                        color: isSelected || pressed
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }

            Widget buildColorCircle(String colorName, Color color) {
              final bool isSelected = selectedColor == colorName;
              final bool pressed = isColorPressed[colorName] ?? false;

              return GestureDetector(
                onTapDown: (_) =>
                    setModalState(() => isColorPressed[colorName] = true),
                onTapUp: (_) {
                  setModalState(() {
                    isColorPressed[colorName] = false;
                    selectedColor = colorName;
                  });
                },
                onTapCancel: () =>
                    setModalState(() => isColorPressed[colorName] = false),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: pressed
                          ? Colors.black
                          : isSelected
                          ? Colors.blue[900]!
                          : Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              );
            }

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Customization",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),

                      // RAM
                      Row(
                        children: [
                          Text("RAM:", style: labelStyle),
                          buildOption(
                            "16GB",
                            selectedRam,
                            (v) => setModalState(() => selectedRam = v),
                          ),
                          buildOption(
                            "32GB",
                            selectedRam,
                            (v) => setModalState(() => selectedRam = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Processor
                      Row(
                        children: [
                          Text("Processor:", style: labelStyle),
                          buildOption(
                            "Intel",
                            selectedProcessor,
                            (v) => setModalState(() => selectedProcessor = v),
                          ),
                          buildOption(
                            "AMD",
                            selectedProcessor,
                            (v) => setModalState(() => selectedProcessor = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Warranty
                      Row(
                        children: [
                          Text("Warranty:", style: labelStyle),
                          buildOption(
                            "3 months",
                            selectedWarranty,
                            (v) => setModalState(() => selectedWarranty = v),
                          ),
                          buildOption(
                            "6 months",
                            selectedWarranty,
                            (v) => setModalState(() => selectedWarranty = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // OS
                      Row(
                        children: [
                          Text("Operating System:", style: labelStyle),
                          buildOption(
                            "Windows",
                            selectedOS,
                            (v) => setModalState(() => selectedOS = v),
                          ),
                          buildOption(
                            "Linux",
                            selectedOS,
                            (v) => setModalState(() => selectedOS = v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Color
                      Row(
                        children: [
                          Text("Color:", style: labelStyle),
                          buildColorCircle("White", Colors.white),
                          buildColorCircle("Black", Colors.black),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Apply
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTapDown: (_) =>
                              setModalState(() => isApplyPressed = true),
                          onTapUp: (_) {
                            setModalState(() => isApplyPressed = false);
                            Navigator.pop(context);
                          },
                          onTapCancel: () =>
                              setModalState(() => isApplyPressed = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: isApplyPressed
                                  ? Colors.blue[900]
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Apply",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // CLOSE BUTTON
                Positioned(
                  top: -70,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 4),
                        ],
                      ),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ---------------- DRAG HANDLE ----------------
  Widget _dragHandle() => Padding(
    padding: const EdgeInsets.all(10),
    child: Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  final List<Map<String, String>> products = [
    {
      'image': 'assets/images/image 6.png',
      'title': 'Apple MacBook Air 2017',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/moblie.png',
      'title': 'Apple MacBook Air M2 2023',
      'price': '₹ 89,900',
      'oldPrice': '₹ 1,19,900',
    },
    {
      'image': 'assets/images/laptop.png',
      'title': 'Apple MacBook Air 2017',
      'price': '₹ 41,200',
      'oldPrice': '₹ 71,290',
    },
    {
      'image': 'assets/images/image.png',
      'title': 'Apple MacBook Air M2 2023',
      'price': '₹ 89,900',
      'oldPrice': '₹ 1,19,900',
    },
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  int totalPages = 3; // total images

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        if (_currentPage < totalPages - 1) {
          // Normal next page
          _currentPage++;
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          // Reset to first page
          _currentPage = 0;
          _pageController.jumpToPage(0); // instant reset, no animation
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ✅ Helper for safe asset loading
  Widget safeAssetImage(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported, color: Colors.grey),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color normal = Colors.black87;
    final Color active = Colors.blue;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 16,
                color: Colors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),

            Text(
              "View details",
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Animated Image Carousel
              SizedBox(
                height: 300,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: safeAssetImage(
                          'assets/images/image 81.png',
                          height: 200,
                          width: 316,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Share / indicator / wishlist
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circleIcon(Icons.ios_share_outlined),
                    _pageIndicator(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isWishlisted = !isWishlisted;
                        });
                      },
                      child: _circleIcon(
                        Icons.favorite,
                        color: isWishlisted ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Ratings ABOVE title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: [_buildStars(4.5, reviewCount: 594)]),
              ),

              const SizedBox(height: 8),

              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Refurbished)',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Storage Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Storage Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _specRow(
                          "Size:",
                          ["512 HDD", "2GB HDD", "1TB HDD"],
                          selectedSize,
                          (val) => setState(() => selectedSize = val),
                        ),
                        const SizedBox(width: 10),
                        _simpleBox("SSD"),
                      ],
                    ),
                    _specRow(
                      "RAM:",
                      ["8GB", "16GB", "32GB"],
                      selectedRam,
                      (val) => setState(() => selectedRam = val),
                    ),
                    _specRow(
                      "Processor:",
                      ["Intel Core i5", "Intel Core i7", "Intel Core i9"],
                      selectedProcessor,
                      (val) => setState(() => selectedProcessor = val),
                    ),
                    _specRow(
                      "Warranty:",
                      ["6 Months", "1 Year", "2 Years"],
                      selectedWarranty,
                      (val) => setState(() => selectedWarranty = val),
                    ),
                    _specRow(
                      "Operating System:",
                      ["Windows", "macOS", "Linux"],
                      selectedOS,
                      (val) => setState(() => selectedOS = val),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Bank offers
              _bankOfferRow(
                imagePath: 'assets/images/Amazon.png',
                title: "Amazon Pay ICICI Bank ....",
                amount: "-\$1,724",
              ),
              const SizedBox(height: 10),
              _bankOfferRow(
                imagePath: 'assets/images/hdcf.png',
                title: "HDFC Bank",
                amount: "-\$1,724",
              ),

              // seeall taxt
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onHighlightChanged: (v) => setState(() => _isPressed = v),
                    onTap: widget.onPressed,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                              fontFamily: 'Inter', // as you prefer
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 24 / 14, // line-height ~24
                              color: _isPressed ? active : normal,
                            ),
                          ),
                          const SizedBox(width: 6),
                          RotatedBox(
                            quarterTurns: 3, // left -> down
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 16,
                              color: _isPressed ? active : normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5),

              // "No Cost EMI Offers" label with specified font
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 12),
                child: SizedBox(
                  width: 148,
                  height: 24,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'No Cost EMI Offers',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 24 / 16,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                ),
              ),

              //  Bajaj Finserv EMI cards row
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: double.infinity, // fixed width
                  height: 40, // fixed height
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ), // reduced gap
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6F9), // light bluish background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png', // replace with your asset
                          height: 20,
                        ),
                        const SizedBox(width: 6),
                        const Flexible(
                          child: Text(
                            'Bajaj Finserv EMI cards',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // payment method
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: 61,
                  width: double.infinity,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      hintText: 'Postal code e.g. 414001',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          // TODO: handle check action
                        },
                        child: const Text(
                          'Check',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              // box
              Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ), // 🔹 Outer padding (4 sides)
                child: SizedBox(
                  height: screenHeight * 0.60,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 8,
                    ), // 🔹 inner left + right padding
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.35,
                        ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isWishlisted = wishlist.contains(index);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailPage(product: product),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        left: 8,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF243BCD),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
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
                                        padding: const EdgeInsets.symmetric(
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
                                            MainAxisAlignment.spaceBetween,
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
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xFF202020),
                                                ),
                                              ),
                                              Text(
                                                product['oldPrice']!,
                                                style: const TextStyle(
                                                  fontFamily: "Inter",
                                                  fontSize: 9,
                                                  color: Color(0xFF202020),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            icon: Icon(
                                              isWishlisted
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: const Color(0xFF243BCD),
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
            ],
          ),
        ),
      ),
    );
  }

  // Helpers (unchanged)
  Widget _simpleBox(String text) {
    return Container(
      height: 42,
      width: 112,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFDFDFDF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(color: Color(0xFF606060), fontSize: 14),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, color: Color(0xFF606060), size: 20),
        ],
      ),
    );
  }

  Widget _bankOfferRow({
    required String imagePath,
    required String title,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F2F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: safeAssetImage(
              imagePath,
              width: 26,
              height: 26,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Text(
            "Upto",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(width: 4),
          Text(
            amount,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, {Color color = Colors.black}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  // page indicator
  Widget _pageIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Container(
          width: index == _currentPage ? 20 : 6,
          height: 5,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: index == _currentPage ? Colors.blue : Colors.black,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  // Rating stars
  Widget _buildStars(double rating, {int reviewCount = 0}) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Vector.png',
            height: 12,
            width: 60,
            fit: BoxFit.cover,
          ),

          // Flexible spacer to push stars to right
          const SizedBox(width: 110),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(5, (index) {
                if (index < fullStars) {
                  return const Icon(Icons.star, size: 20, color: Colors.amber);
                } else if (index == fullStars && hasHalfStar) {
                  return const Icon(
                    Icons.star_half,
                    size: 20,
                    color: Colors.amber,
                  );
                } else {
                  return const Icon(
                    Icons.star_border,
                    size: 20,
                    color: Colors.amber,
                  );
                }
              }),
              const SizedBox(width: 4),
              Text(
                "($reviewCount)",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // drop down button
  // Widget _specRow(
  //   String title,
  //   List<String> options,
  //   String selectedValue,
  //   ValueChanged<String> onChanged,
  // ) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
  //     child: Row(
  //       children: [
  //         Text(
  //           title,
  //           style: const TextStyle(fontSize: 14, color: Color(0xFF1D1D1D)),
  //         ),
  //         const SizedBox(width: 8),
  //         DropdownButton<String>(
  //           value: selectedValue,
  //           onChanged: (String? newValue) {
  //             if (newValue != null) onChanged(newValue);
  //           },
  //           items: options
  //               .map(
  //                 (option) =>
  //                     DropdownMenuItem(value: option, child: Text(option)),
  //               )
  //               .toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _specRow(
    String title,
    List<String> options,
    String? selectedValue,
    ValueChanged<String> onChanged,
  ) {
    // If selectedValue is invalid or null, default to the first option
    if (selectedValue == null || !options.contains(selectedValue)) {
      selectedValue = options.isNotEmpty ? options.first : null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Color(0xFF1D1D1D)),
          ),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: selectedValue,
            onChanged: (String? newValue) {
              if (newValue != null) onChanged(newValue);
            },
            items: options
                .map(
                  (option) =>
                      DropdownMenuItem(value: option, child: Text(option)),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
