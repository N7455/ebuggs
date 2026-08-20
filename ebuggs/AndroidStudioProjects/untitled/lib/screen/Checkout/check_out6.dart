import 'package:flutter/material.dart';
import 'complete_checkout.dart';// import your next page

class PaymentProcessingScreen extends StatefulWidget {
  const PaymentProcessingScreen({super.key});

  @override
  State<PaymentProcessingScreen> createState() => _PaymentProcessingScreenState();
}

class _PaymentProcessingScreenState extends State<PaymentProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _redirectToNextPage();
  }

  void _redirectToNextPage() async {
    // Simulate payment processing delay (replace with real payment callback)
    await Future.delayed(const Duration(seconds: 3));

    // Navigate to success page
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSuccessScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: width * 0.06,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Complete',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: width * 0.045,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'CANCEL',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: width * 0.035,
                letterSpacing: 1.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Image.asset(
                'assets/images/pay.png',
                width: width * 1.5,
                height: width * 0.5,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Processing payment...',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: width * 0.045,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              'Redirecting to your UPI App.\nPlease do not press back button',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: width * 0.035,
                color: const Color(0xFF4E4F51),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
