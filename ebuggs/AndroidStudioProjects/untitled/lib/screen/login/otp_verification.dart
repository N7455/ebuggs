// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../Home/Homepage.dart';
//
// class VerificationCode extends StatefulWidget {
//   final String phoneNumber;
//   const VerificationCode({Key? key, required this.phoneNumber}) : super(key: key);
//
//   @override
//   State<VerificationCode> createState() => _VerificationCodeState();
// }
//
// class _VerificationCodeState extends State<VerificationCode> {
//   final List<TextEditingController> controllers =
//   List.generate(6, (_) => TextEditingController());
//   bool showOtp = false;
//
//   @override
//   void dispose() {
//     for (var c in controllers) c.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final screenWidth = constraints.maxWidth;
//         final screenHeight = constraints.maxHeight;
//         final isTablet = screenWidth > 600;
//
//         return Scaffold(
//           backgroundColor: Colors.white,
//           body: SafeArea(
//             child: Column(
//               children: [
//                 // Top Illustration
//                 SizedBox(
//                   height: screenHeight * 0.3,
//                   child: Center(
//                     child: Image.asset(
//                       "assets/images/illustartor otp.png",
//                       height: screenHeight * 0.25,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//
//                 // Bottom Container with Scroll
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF1C3CD4),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(screenWidth * 0.08),
//                         topRight: Radius.circular(screenWidth * 0.08),
//                       ),
//                     ),
//                     child: SingleChildScrollView(
//                       physics: const BouncingScrollPhysics(),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.06,
//                         vertical: screenHeight * 0.03,
//                       ),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           // Title
//                           Text(
//                             'OTP Verification',
//                             style: TextStyle(
//                               fontSize: isTablet ? 34 : screenWidth * 0.075,
//                               fontFamily: "Inter",
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//
//                           // Subtitle
//                           Text(
//                             'Enter the code sent to your phone to verify your identity.',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: isTablet ? 18 : screenWidth * 0.04,
//                               color: Colors.white,
//                               fontFamily: "Inter",
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.04),
//
//                           // OTP Fields
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: List.generate(6, (index) {
//                               return SizedBox(
//                                 width: isTablet ? 55 : screenWidth * 0.12,
//                                 child: TextField(
//                                   controller: controllers[index],
//                                   keyboardType: TextInputType.number,
//                                   maxLength: 1,
//                                   obscureText: !showOtp,
//                                   textAlign: TextAlign.center,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(1),
//                                     FilteringTextInputFormatter.digitsOnly,
//                                   ],
//                                   style: TextStyle(
//                                     fontSize: isTablet ? 22 : screenWidth * 0.05,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                   decoration: InputDecoration(
//                                     counterText: '',
//                                     filled: true,
//                                     fillColor: Colors.white24,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                           color: Colors.white, width: 2),
//                                     ),
//                                   ),
//                                   onChanged: (value) {
//                                     if (value.isNotEmpty) {
//                                       // Next field focus
//                                       if (index < controllers.length - 1) {
//                                         FocusScope.of(context).nextFocus();
//                                       } else {
//                                         // Last field filled → auto submit
//                                         FocusScope.of(context).unfocus();
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) => HomePage()),
//                                         );
//                                       }
//                                     } else {
//                                       // Backspace → previous field focus
//                                       if (index > 0) {
//                                         FocusScope.of(context).previousFocus();
//                                       }
//                                     }
//                                   },
//                                 ),
//                               );
//                             }),
//                           ),
//                           const SizedBox(height: 20),
//
//                           // Timer
//                           Text(
//                             "00:22",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: isTablet ? 20 : screenWidth * 0.045,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//
//                           // Resend OTP
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Didn't receive OTP? ",
//                                 style: TextStyle(
//                                   color: Colors.white70,
//                                   fontSize:
//                                   isTablet ? 16 : screenWidth * 0.035,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   // Resend OTP logic
//                                 },
//                                 child: Text(
//                                   "Resend OTP",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize:
//                                     isTablet ? 16 : screenWidth * 0.035,
//                                     decoration: TextDecoration.underline,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: screenHeight * 0.05),
//
//                           // Forward Button
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => HomePage()),
//                               );
//                             },
//                             child: Container(
//                               width: isTablet ? 75 : screenWidth * 0.16,
//                               height: isTablet ? 75 : screenWidth * 0.16,
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white,
//                               ),
//                               child: Icon(
//                                 Icons.arrow_forward,
//                                 size: isTablet ? 30 : screenWidth * 0.07,
//                                 color: const Color(0xFF243BCD),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 15),
//
//                           // Show/Hide OTP
//                           GestureDetector(
//                             onTap: () => setState(() => showOtp = !showOtp),
//                             child: Text(
//                               showOtp ? "Hide OTP" : "Show OTP",
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.02),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Home/Homepage.dart';

class VerificationCode extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const VerificationCode({
    Key? key,
    required this.phoneNumber,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());
  bool showOtp = false;
  bool isLoading = false;

  @override
  void dispose() {
    for (var c in controllers) c.dispose();
    super.dispose();
  }

  Future<void> verifyOtp() async {
    String otp = controllers.map((c) => c.text).join();

    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid 6-digit OTP")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP, try again")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isTablet = screenWidth > 600;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                // Top Illustration
                SizedBox(
                  height: screenHeight * 0.3,
                  child: Center(
                    child: Image.asset(
                      "assets/images/illustartor otp.png",
                      height: screenHeight * 0.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // Bottom Container with Scroll
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C3CD4),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenWidth * 0.08),
                        topRight: Radius.circular(screenWidth * 0.08),
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.03,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Title
                          Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: isTablet ? 34 : screenWidth * 0.075,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Subtitle
                          Text(
                            'Enter the code sent to +91 ${widget.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isTablet ? 18 : screenWidth * 0.04,
                              color: Colors.white,
                              fontFamily: "Inter",
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),

                          // OTP Fields
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return SizedBox(
                                width: isTablet ? 55 : screenWidth * 0.12,
                                child: TextField(
                                  controller: controllers[index],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  obscureText: !showOtp,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  style: TextStyle(
                                    fontSize: isTablet ? 22 : screenWidth * 0.05,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: Colors.white24,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      if (index < controllers.length - 1) {
                                        FocusScope.of(context).nextFocus();
                                      } else {
                                        FocusScope.of(context).unfocus();
                                      }
                                    } else if (index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),

                          // Timer
                          Text(
                            "00:22",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 20 : screenWidth * 0.045,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Resend OTP
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive OTP? ",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: isTablet ? 16 : screenWidth * 0.035,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // TODO: Call resend OTP from previous screen
                                },
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isTablet ? 16 : screenWidth * 0.035,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.05),

                          // Forward Button
                          GestureDetector(
                            onTap: verifyOtp,
                            child: Container(
                              width: isTablet ? 75 : screenWidth * 0.16,
                              height: isTablet ? 75 : screenWidth * 0.16,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                size: isTablet ? 30 : screenWidth * 0.07,
                                color: const Color(0xFF243BCD),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Show/Hide OTP
                          GestureDetector(
                            onTap: () => setState(() => showOtp = !showOtp),
                            child: Text(
                              showOtp ? "Hide OTP" : "Show OTP",
                              style: const TextStyle(
                                color: Colors.white70,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),

                          if (isLoading) const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

