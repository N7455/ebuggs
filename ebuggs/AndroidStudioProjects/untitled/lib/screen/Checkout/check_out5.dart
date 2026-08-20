import 'package:flutter/material.dart';
import 'package:untitled/screen/loction/set_loction.dart';

import 'check_out6.dart';

class PaymentSummaryPage extends StatefulWidget {
  const PaymentSummaryPage({super.key});

  @override
  State<PaymentSummaryPage> createState() => _PaymentSummaryPageState();
}

class _PaymentSummaryPageState extends State<PaymentSummaryPage> {
  int quantity = 1; // 🔹 Item Quantity Count
  double itemPrice = 49000; // Single Item Price

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // 🔹 Font Styles
    TextStyle headingStyle = TextStyle(
      fontFamily: "Inter",
      fontSize: width * 0.045,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    );

    TextStyle normalText = TextStyle(
      fontFamily: "Inter",
      fontSize: width * 0.038,
      fontWeight: FontWeight.w400,
      color: Colors.black87,
    );

    TextStyle boldText = TextStyle(
      fontFamily: "Inter",
      fontSize: width * 0.038,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    double total = itemPrice * quantity;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: width * 0.05,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Payment",
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: width * 0.05,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: width * 0.02),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'CANCEL',
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: width * 0.038,
                  color: const Color(0xFF0F0F0F),
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(thickness: 2, height: height * 0.02),

            // 🔹 Order Summary
            Column(
              children: [
                _rowText(
                  'Items:',
                  "₹${(itemPrice * quantity).toStringAsFixed(2)}",
                  boldText,
                ),
                SizedBox(height: height * 0.01),
                _rowText('Delivery:', "₹0.00", boldText),
                SizedBox(height: height * 0.01),
                _rowText(
                  'Order Total:',
                  "₹${total.toStringAsFixed(2)}",
                  headingStyle,
                ),
              ],
            ),

            Divider(thickness: 2, height: height * 0.03),

            // 🔹 Product Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  child: Image.asset(
                    'assets/images/laptop.png',
                    height: height * 0.12,
                    width: width * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),

                SizedBox(width: width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apple MacBook Pro 16-inch i7 with Touch Bar A2141 \n2019 model (Refurbished)",
                        style: normalText,
                        maxLines: 3, // change from 2 to 3
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: height * 0.01),
                      Text(
                        "₹ ${itemPrice.toStringAsFixed(2)}",
                        style: headingStyle.copyWith(fontSize: width * 0.042),
                      ),
                      SizedBox(height: height * 0.015),

                      // ✅ Quantity Control + Left Text
                      // _quantitySection(width, height),
                    ],
                  ),
                ),
              ],
            ),

            _quantitySection(width, height),

            SizedBox(height: height * 0.03),
            Divider(thickness: 2),

            // 🔹 Payment Method
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Paying with Paytm", style: boldText),
                      SizedBox(height: height * 0.005),
                      GestureDetector(
                        onTap: () {
                          print("Change payment method clicked");
                        },
                        child: Text(
                          "Change payment method",
                          style: normalText.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/pytm.png",
                  width: width * 0.25,
                  height: height * 0.05,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            Divider(thickness: 2),

            SizedBox(height: height * 0.02),

            // 🔹 Address Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivering to Kavita Rana",
                  style: headingStyle.copyWith(
                    fontSize: width * 0.042,
                    fontFamily: "Inter",   // Inter font family
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.008),
                Text(
                  "636/25 Geet vihar colony takrohi India nagar,\nLUCKNOW, UTTAR PRADESH, 226016,  India",
                  style: normalText.copyWith(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: height * 0.01),

                // Button
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black, // Button ka color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded button
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddressConfirmPage ()),
                    );
                  },
                  child: Text(
                    "Change delivery address",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.038,
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: height * 0.025),

            Text(
              "Arriving 16 Jul 2025",
              style: headingStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.048,
                color: const Color(0xFF010101),
              ),
            ),

            SizedBox(height: height * 0.04),

            // 🔹 Big Continue Button
            SizedBox(
              width: double.infinity,
              height: height * 0.07,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentProcessingScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF243BCD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: width * 0.045,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Row Text Helper
  Widget _rowText(String left, String right, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: style),
        Text(right, style: style),
      ],
    );
  }

  // 🔹 Quantity Section (Buttons + Text)
  Widget _quantitySection(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF243BCD), width: 1),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.001,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (quantity > 1) setState(() => quantity--);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.005,
                  ),
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Text(
                  quantity.toString(),
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              InkWell(
                onTap: () => setState(() => quantity++),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02,
                    vertical: height * 0.005,
                  ),
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.008),
        Text(
          "Order quantity: $quantity",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: width * 0.038,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF243BCD),
          ),
        ),
      ],
    );
  }
}
