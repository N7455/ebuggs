import 'package:flutter/material.dart';

class ReferEarnPage extends StatelessWidget {
  final String referralCode = "XXXXXX";

  // 🔹 Responsive font helper
  double responsiveFont(BuildContext context, double baseSize) {
    double width = MediaQuery.of(context).size.width;
    return (width / 375) * baseSize; // 375 = base iPhone width
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,


        leadingWidth: 60,
        titleSpacing: 3,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Refer & Earn',
          style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
            fontSize: responsiveFont(context, 18),
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 🔹 Top Image
            Center(
              child: Image.asset(
                'assets/images/Group 8775.png',
                height: h * 0.25,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: h * 0.03),

            // 🔹 Title
            Text(
              'It pays to have a friend!',
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                fontSize: responsiveFont(context, 20),
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.015),

            // 🔹 Description
            Text(
              'Invite your friends and Earn Rs.100 when your friend sells phone on Company. '
                  'Your friend also gets Rs.100 extra! (minimum transaction value Rs.1500)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: responsiveFont(context, 14),
                color: Colors.black87,
              ),
            ),
            SizedBox(height: h * 0.04),

            // 🔹 Referral Code Box with Share
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFCDCDCD)),
              ),
              child: Column(
                children: [
                  Text(
                    'Your referral code:',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: responsiveFont(context, 14),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    referralCode,
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                      fontSize: responsiveFont(context, 22),
                      color: const Color(0xFF243BCD),
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: h * 0.02),

                  // 🔹 Share Text
                  Text(
                    'Share:',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: responsiveFont(context, 16),
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: h * 0.015),

                  // 🔹 Social Buttons inside container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIconButton(
                        imageUrl:
                        'https://img.icons8.com/color/48/facebook.png',
                        onTap: () {},
                      ),
                      SocialIconButton(
                        imageUrl:
                        'https://img.icons8.com/fluency/48/instagram-new.png',
                        onTap: () {},
                      ),
                      SocialIconButton(
                        imageUrl:
                        'https://img.icons8.com/color/48/whatsapp.png',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialIconButton extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onTap;

  const SocialIconButton({required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Image.network(
          imageUrl,
          height: h * 0.05,
          width: h * 0.05,
        ),
      ),
    );
  }
}
