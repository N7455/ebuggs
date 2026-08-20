import 'package:flutter/material.dart';
import '../Models/modela_page.dart' show ProductApp;

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // ===== Data =====
  final List<String> categories = const [
    "Laptop",
    "Mobile",
    "Tablet",
    "Camera",
    "Printer",
    "Headphone",
  ];

  final List<String> brands = const [
    "Dell",
    "Lenovo",
    "ASUS",
    "Apple",
    "Samsung",
    "HP",
  ];

  final List<Map<String, String>> models = const [
    {
      "image": "assets/images/image 6.png",
      "name":
      "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Refurbished)"
    },
    {
      "image": "assets/images/phone2.png",
      "name":
      "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 2019 model (Refurbished)"
    },
    {"image": "assets/images/laptop.png", "name": "Apple MacBook"},
    {"image": "assets/images/laptop.png", "name": "Apple MacBook"},
    {"image": "assets/images/laptop.png", "name": "Apple MacBook"},
    {"image": "assets/images/laptop.png", "name": "Apple MacBook"},
  ];

  int selectedCategory = 0;
  int selectedBrand = -1;
  Set<int> favoriteIndexes = {};

  // ===== Persistent Sort & Filter =====
  String? selectedSort;
  Map<String, String?> selectedFilters = {
    "Series": null,
    "Processor": null,
    "RAM": null,
    "Size": null,
  };

  // ===== BottomSheet for Sort & Filter =====
  void _showHalfModal(String title) {
    if (title == "Sort by") {
      int? selectedSortIndex;
      final List<String> sortOptions = [
        "What's new",
        "Price high to low",
        "Price low to high",
        "Discount",
      ];

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),

                // Options
                Expanded(
                  child: StatefulBuilder(
                    builder: (context, setSheetState) {
                      return ListView.builder(
                        itemCount: sortOptions.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedSortIndex == index;

                          return InkWell(
                            onTap: () {
                              setSheetState(() {
                                setState(() {
                                  if (isSelected) {
                                    selectedSortIndex = null;
                                  } else {
                                    selectedSortIndex = index;
                                    selectedSort = sortOptions[index];
                                  }
                                });
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 12,
                              ),
                              margin: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.grey.shade300
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                sortOptions[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // --------------------
      // Filter BottomSheet
      // --------------------
      int selectedMenuIndex = 0; // 👈 Bahar declare karo

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          final Map<String, List<String>> filterOptions = {
            "Series": ["EliteBook Ultra", "Elite Dragonfly", "Pro Book"],
            "Processor": ["i3", "i5", "i7", "i9"],
            "RAM": ["8GB", "16GB", "32GB"],
            "Size": ["13 inch", "15 inch", "17 inch"],
          };
          final List<String> menus = filterOptions.keys.toList();

          return FractionallySizedBox(
            heightFactor: 0.75,
            child: StatefulBuilder(
              builder: (context, setSheetState) {
                return Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedFilters = {
                                  for (var k in selectedFilters.keys) k: null,
                                };
                              });
                              setSheetState(() {}); // UI update
                            },
                            child: const Text(
                              "CLEAR ALL",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),

                    // Content
                    Expanded(
                      child: Row(
                        children: [
                          // Left Menu
                          Container(
                            width: 140,
                            color: Colors.grey.shade200,
                            child: ListView.builder(
                              itemCount: menus.length,
                              itemBuilder: (context, index) {
                                final selected = index == selectedMenuIndex;
                                return InkWell(
                                  onTap: () {
                                    setSheetState(() {
                                      selectedMenuIndex = index; // 👈 Ab update hoga
                                    });
                                  },
                                  child: Container(
                                    color: selected
                                        ? Colors.grey.shade300
                                        : Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      menus[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: selected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Right Options
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                final options =
                                    filterOptions[menus[selectedMenuIndex]] ?? [];
                                final String? groupValue =
                                selectedFilters[menus[selectedMenuIndex]];

                                return ListView(
                                  padding: const EdgeInsets.all(16),
                                  children: options.map((opt) {
                                    return RadioListTile<String>(
                                      title: Text(opt),
                                      value: opt,
                                      groupValue: groupValue,
                                      onChanged: (val) {
                                        setState(() {
                                          selectedFilters[
                                          menus[selectedMenuIndex]] = val;
                                        });
                                        setSheetState(() {});
                                      },
                                      activeColor: Colors.black87,
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Footer Buttons
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(color: Colors.grey.shade400),
                              ),
                              child: const Text("Close",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E40FF),
                                elevation: 0,
                              ),
                              child: const Text("Apply",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_ios, size: screenW * 0.05),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Filter",
                    style: TextStyle(
                      fontSize: screenW * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Categories",
                style: TextStyle(
                    fontSize: screenW * 0.045, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: screenH * 0.13,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedCategory == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedCategory = index),
                      child: Column(
                        children: [
                          Container(
                            height: screenW * 0.13,
                            width: screenW * 0.13,
                            decoration: BoxDecoration(
                              color:
                              isSelected ? Colors.blue : Colors.grey[300],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.laptop,
                              color: isSelected ? Colors.white : Colors.black,
                              size: screenW * 0.07,
                            ),
                          ),
                          const SizedBox(height: 6),
                          SizedBox(
                            width: 70,
                            child: Text(
                              categories[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenW * 0.032,
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.blue : Colors.black,
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

            // Brands
            Container(
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose a Brand",
                      style: TextStyle(
                          fontSize: screenW * 0.045,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: brands.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedBrand == index;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: OutlinedButton(
                            onPressed: () =>
                                setState(() => selectedBrand = index),
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                              isSelected ? Colors.blue : Colors.white,
                              side: BorderSide(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.grey.shade400,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              brands[index],
                              style: TextStyle(
                                color:
                                isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Models & Deals
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header Row
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Select Model",
                                style: TextStyle(
                                    fontSize: screenW * 0.045,
                                    fontWeight: FontWeight.bold)),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductApp(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text("See all",
                                      style: TextStyle(
                                          fontSize: screenW * 0.035,
                                          color: Colors.black)),
                                  const SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_ios,
                                      size: screenW * 0.03),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Models Grid - 2 rows with 3 blue columns
                      Column(
                        children: [
                          // First Row
                          Row(
                            children: [
                              for (int i = 0; i < 3 && i < models.length; i++)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              models[i]["image"] ?? "",
                                              width: double.infinity,
                                              height: screenH * 0.1,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            models[i]["name"] ?? "Unnamed",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: screenW * 0.032,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          // Second Row
                          Row(
                            children: [
                              for (int i = 3; i < 6 && i < models.length; i++)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(
                                              models[i]["image"] ?? "",
                                              width: double.infinity,
                                              height: screenH * 0.1,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            models[i]["name"] ?? "Unnamed",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: screenW * 0.032,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Deals Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: models.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenW < 500 ? 2 : 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: screenW < 400 ? 0.75 : 0.85
                        ),
                        itemBuilder: (context, index) {
                          final isFavorite = favoriteIndexes.contains(index);
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF243BCD),
                                          borderRadius:
                                          BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          '-35% off',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenW * 0.028,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (isFavorite) {
                                              favoriteIndexes.remove(index);
                                            } else {
                                              favoriteIndexes.add(index);
                                            }
                                          });
                                        },
                                        child: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                          size: screenW * 0.05,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    models[index]["image"] ?? "",
                                    height: screenH * 0.14,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
                                  child: Text(
                                    models[index]["name"] ??
                                        "Unnamed Product",
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: screenW * 0.032,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Buttons
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showHalfModal("Sort by"),
                icon: const Icon(Icons.swap_vert, color: Colors.black),
                label: const Text("Sort by",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showHalfModal("Filter by"),
                icon: const Icon(Icons.filter_list, color: Colors.black),
                label: const Text("Filter by",
                    style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
