import 'package:flutter/material.dart';
import '../address/add _save_address.dart';
import '../loction/set_loction.dart';
import 'check_out5.dart';

class PaymentSelectionPage extends StatefulWidget {
  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  String? _selectedPaymentMethod;
  String? _selectedUpiOption;
  bool _isLoading = false; // loader state

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final double width = media.width;

    double fs(double size) => size * width / 375;

    TextStyle headerStyle = TextStyle(
      fontSize: fs(18),
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: Colors.black,
    );
    TextStyle subHeaderStyle = TextStyle(
      fontSize: fs(16),
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: Colors.black,
    );
    TextStyle bodyStyle = TextStyle(
      fontSize: fs(14),
      fontWeight: FontWeight.w300,
      fontFamily: 'Inter',
      color: Colors.black,
    );

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: fs(20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Payment',
            style: headerStyle.copyWith(fontSize: fs(16)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          centerTitle: false,
          titleSpacing: 0, // 👈 यह leading और title के बीच का space control करता है
          actions: [
            Padding(
              padding: EdgeInsets.only(right: fs(8)), // CANCEL button को थोड़ा adjust करने के लिए
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    fontSize: fs(14),
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),


        body: Container(
        color: const Color(0xFFF5F5F5), // ✅ हल्का ग्रे background
        child: Column(
          children: [
            // ✅ Address Section
            Container(
              width: width,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: fs(16),
                vertical: fs(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivering to Kavita Rana",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: fs(16),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: fs(4)),
                  Text(
                    "636/25 Geet vihar colony takrohi India nagar, LUCKNOW, UTTAR PRADESH, 226016, India",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: fs(14),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: fs(6)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedAddressesScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Change delivery address",
                      style: TextStyle(
                        fontSize: fs(14),
                        color: const Color(0xFF444444),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )

                ],
              ),
            ),

            // ✅ Continue Button Top
            _continueButton(width, fs),

            // ✅ Payment Options
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: fs(16)),
                children: [
                  Text(
                    "Select a payment method",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: fs(20),
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: fs(10)),

                  // 👇 UPI Option
                  _buildContainer(
                    child: _buildPaymentOption(
                      title: "Pay by any UPI App",
                      subtitle: "Google Pay, PhonePe, Paytm and more",
                      value: "UPI",
                      imagePath: "assets/images/Vector (4).png",
                      fs: fs,
                      subHeaderStyle: subHeaderStyle,
                      bodyStyle: bodyStyle,
                      onTap: () {
                        _showUpiBottomSheet(fs);
                      },
                    ),
                  ),

                  _buildSectionTitle("CREDIT & DEBIT CARDS", fs),

                  _buildContainer(
                    child: _buildCardOption(
                      title: "HDFC Bank Credit Card",
                      subtitle: "**5896 | Mihir",
                      value: "Card1",
                      fs: fs,
                      subHeaderStyle: subHeaderStyle,
                      bodyStyle: bodyStyle,
                      subtitleImagePath: "assets/images/visa.png",
                      secondaryImagePath: "assets/images/hdcf.png",
                    ),
                  ),

                  _buildContainer(
                    child: _buildCardOption(
                      title: "HDFC Bank Debit Card",
                      subtitle: "**5898 | Mihir",
                      value: "Card2",
                      fs: fs,
                      subHeaderStyle: subHeaderStyle,
                      bodyStyle: bodyStyle,
                      subtitleImagePath: "assets/images/visa.png",
                      secondaryImagePath: "assets/images/state.png",
                    ),
                  ),

                  _buildSectionTitle("MORE WAYS TO PAY", fs),

                  _buildContainer(
                    child: _buildPaymentOption(
                      title: "Net Banking",
                      subtitle: "",
                      value: "NetBanking",
                      imagePath: "assets/images/bank.png",
                      fs: fs,
                      subHeaderStyle: subHeaderStyle,
                      bodyStyle: bodyStyle,
                    ),
                  ),

                  _buildContainer(
                    child: _buildPaymentOption(
                      title: "EMI",
                      subtitle: "",
                      value: "EMI",
                      imagePath: "assets/images/Calculator.png",
                      fs: fs,
                      subHeaderStyle: subHeaderStyle,
                      bodyStyle: bodyStyle,
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Continue Button Bottom
            _continueButton(width, fs),
          ],
        ),
      ),
    );
  }

  /// ✅ Continue Button
  Widget _continueButton(double width, double Function(double) fs) {
    return Padding(
      padding: EdgeInsets.all(fs(12)),
      child: SizedBox(
        width: width,
        height: fs(48),
        child: ElevatedButton(
          onPressed: _selectedPaymentMethod != null && !_isLoading
              ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentSummaryPage(),
              ),
            );
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF243BCD),
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: fs(16),
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Continue'),
        ),
      ),
    );
  }

  /// ✅ BottomSheet for UPI Options
  void _showUpiBottomSheet(double Function(double) fs) {
    final media = MediaQuery.of(context).size;
    final double width = media.width;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: width,
              padding: EdgeInsets.all(fs(16)),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: fs(40),
                    height: fs(5),
                    margin: EdgeInsets.only(bottom: fs(16), top: fs(16)),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "YOUR UPI APPS",
                      style: TextStyle(
                        fontSize: fs(14),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: const Color(0xFF595A5C),
                      ),
                    ),
                  ),
                  SizedBox(height: fs(8)),

                  // 🔹 Paytm Option
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Radio(
                      value: "Paytm",
                      groupValue: _selectedUpiOption,
                      onChanged: (val) {
                        setState(() => _selectedUpiOption = val.toString());
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      "Paytm",
                      style: TextStyle(
                        fontSize: fs(15),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: const Color(0xFF101010),
                      ),
                    ),
                    trailing: Image.asset(
                      "assets/images/pytm.png",
                      height: fs(16),
                      width: fs(35),
                    ),
                  ),

                  SizedBox(height: fs(12)),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "OTHER WAYS",
                      style: TextStyle(
                        fontSize: fs(14),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: const Color(0xFF595A5C),
                      ),
                    ),
                  ),
                  SizedBox(height: fs(8)),

                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Radio(
                      value: "UPI_ID",
                      groupValue: _selectedUpiOption,
                      onChanged: (val) {
                        setState(() => _selectedUpiOption = val.toString());
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      "ENTER UPI ID",
                      style: TextStyle(
                        fontSize: fs(15),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: const Color(0xFF101010),
                      ),
                    ),
                    trailing: Image.asset(
                      "assets/images/Calculator.png",
                      height: fs(22),
                    ),
                  ),
                  SizedBox(height: fs(20)),
                ],
              ),
            ),
            Positioned(
              top: -fs(50),
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(fs(10)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close,
                      size: fs(20),
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// ✅ Section Title
  Widget _buildSectionTitle(String text, double Function(double) fs) {
    return Padding(
      padding: EdgeInsets.only(top: fs(16), bottom: fs(6)),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: fs(14),
          color: Colors.black,
        ),
      ),
    );
  }

  /// ✅ PaymentOption
  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required String value,
    required String imagePath,
    required double Function(double) fs,
    required TextStyle subHeaderStyle,
    required TextStyle bodyStyle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: fs(6)),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (val) {
          setState(() => _selectedPaymentMethod = val);
          if (onTap != null) onTap();
        },
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected))
            return const Color(0xFF243BCD);
          return Colors.grey;
        }),
      ),
      title: Text(title, style: subHeaderStyle.copyWith(fontSize: fs(14))),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: bodyStyle.copyWith(fontSize: fs(12)))
          : null,
      // 👇 Image thoda left kar diya
      trailing: Padding(
        padding: EdgeInsets.only(right: fs(8)),
        child: Image.asset(imagePath, width: fs(26), height: fs(26)),
      ),
    );
  }

  /// ✅ CardOption
  Widget _buildCardOption({
    required String title,
    required String subtitle,
    required String value,
    required double Function(double) fs,
    required TextStyle subHeaderStyle,
    required TextStyle bodyStyle,
    required String subtitleImagePath,
    required String secondaryImagePath,
  }) {
    final parts = subtitle.split('|');
    final numberPart = parts[0].trim();
    final namePart = parts.length > 1 ? parts[1].trim() : "";

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: fs(6)),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (val) {
          setState(() => _selectedPaymentMethod = val);
        },
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected))
            return const Color(0xFF243BCD);
          return Colors.grey;
        }),
      ),
      title: Text(title, style: subHeaderStyle.copyWith(fontSize: fs(14))),
      subtitle: Row(
        children: [
          Text(numberPart, style: bodyStyle.copyWith(fontSize: fs(12))),
          SizedBox(width: fs(6)),
          Image.asset(subtitleImagePath, width: fs(29), height: fs(9)),
          if (namePart.isNotEmpty) ...[
            SizedBox(width: fs(6)),
            Text("| $namePart", style: bodyStyle.copyWith(fontSize: fs(12))),
          ],
        ],
      ),
      // 👇 Image thoda left kar diya
      trailing: Padding(
        padding: EdgeInsets.only(right: fs(8)),
        child: Image.asset(secondaryImagePath, width: fs(28), height: fs(28)),
      ),
    );
  }

  /// ✅ Container Wrapper
  Widget _buildContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
