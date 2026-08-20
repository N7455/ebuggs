import 'package:flutter/material.dart';

import '../loction/loction_page.dart';




// ---------------- Responsive Font Size ----------------
double fs(BuildContext context, double size) {
  double baseWidth = 390; // iPhone 14 width
  return size * MediaQuery.of(context).size.width / baseWidth;
}

// ---------------- App Text Styles ----------------
class AppTextStyle {
  static TextStyle title(BuildContext context) => TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: fs(context, 16),
    color: Colors.black,
  );

  static TextStyle label(BuildContext context) => TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w500,
    fontSize: fs(context, 15),
    color: Colors.black87,
  );

  static TextStyle address(BuildContext context) => TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    fontSize: fs(context, 14),
    height: 1.4,
    color: Colors.black87,
  );

  static TextStyle phone(BuildContext context) => TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w400,
    fontSize: fs(context, 14),
    color: Colors.black54,
  );

  static TextStyle link(BuildContext context) => TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w500,
    fontSize: fs(context, 14),
    color: const Color(0xFF243BCD),
  );

  static TextStyle button(BuildContext context) => TextStyle(
    fontFamily: "Inter",
    fontWeight: FontWeight.w600,
    fontSize: fs(context, 16),
    color: Colors.white,
  );
}

// ---------------- Delivery Address Page ----------------
class DeliveryAddressPage extends StatefulWidget {
  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  int? selectedIndex; // null initially, no address selected

  final List<Map<String, String>> addresses = [
    {
      'label': 'Home',
      'address': 'G-39, Noida Sec 63, Near Hindi Khabar,\nUttar Pradesh',
      'phone': '+91 0000 0000 00',
    },
    {
      'label': 'Office',
      'address': 'Sector 18, Noida, Uttar Pradesh',
      'phone': '+91 1111 1111 11',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leadingWidth: 40,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Delivery Address', style: AppTextStyle.title(context)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Add Location Box
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.018),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add, color: Colors.black),
                    SizedBox(width: screenWidth * 0.02),
                    Text("Add Location",
                        style: AppTextStyle.label(context)
                            .copyWith(color: Colors.black54)),
                  ],
                ),
              ),
            ),
          ),

          // Address List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: selectedIndex == index
                            ? const Color(0xFF243BCD)
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top row: Icon, label, checkbox
                        Row(
                          children: [
                            const Icon(Icons.home_outlined,
                                color: Colors.black, size: 20),
                            SizedBox(width: screenWidth * 0.015),
                            Text(address['label']!, style: AppTextStyle.label(context)),
                            const Spacer(),
                            Checkbox(
                              value: selectedIndex == index,
                              activeColor: const Color(0xFF243BCD),
                              onChanged: (val) {
                                setState(() => selectedIndex = index);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.008),

                        // Address text
                        Text(address['address']!, style: AppTextStyle.address(context)),
                        SizedBox(height: screenHeight * 0.008),

                        // Edit + View on map
                        Row(
                          children: [
                            Text("Edit",
                                style: AppTextStyle.label(context)
                                    .copyWith(color: Colors.black54)),
                            SizedBox(width: screenWidth * 0.04),
                            InkWell(
                              // onTap: () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => LocationPage()),
                              //   );
                              // },
                              child: Text(
                                "View on map",
                                style: AppTextStyle.link(context),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.008),

                        // Phone
                        Text(address['phone']!, style: AppTextStyle.phone(context)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Button - Dynamic Color
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: SizedBox(
              width: double.infinity,
              height: screenHeight * 0.065,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                        if (selectedIndex != null) {
                          if (states.contains(MaterialState.pressed)) {
                            return const Color(0xFF1B2A8C); // Dark blue on press
                          }
                          return const Color(0xFF243BCD); // Normal blue
                        } else {
                          return Colors.grey.shade300; // Disabled
                        }
                      }),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) {
                        return selectedIndex != null ? Colors.white : Colors.black54;
                      }),
                  shape: MaterialStateProperty.all<StadiumBorder>(
                      const StadiumBorder()),
                ),
                onPressed: selectedIndex != null
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Selected Address: ${addresses[selectedIndex!]['address']}')),
                  );
                }
                    : null,
                child: Text("Set Address", style: AppTextStyle.button(context)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
