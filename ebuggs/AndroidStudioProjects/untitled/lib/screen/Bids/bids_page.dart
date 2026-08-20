import 'package:flutter/material.dart';

class BidPage extends StatefulWidget {
  const BidPage({super.key});

  @override
  State<BidPage> createState() => _BidPageState();
}

class _BidPageState extends State<BidPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  bool isBidExpiredPressed = false;
  bool isSharePressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: const Offset(0.3, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleButton(String type) {
    setState(() {
      if (type == 'bid') {
        isBidExpiredPressed = !isBidExpiredPressed;
      } else {
        isSharePressed = !isSharePressed;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Bid',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        centerTitle: false,           // align title to left
        titleSpacing: 0,              // optional: reduces space between icon and text
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Product Card with animated image in square container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      // Square container for image
                      Container(
                        height: 225,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: SlideTransition(
                            position: _animation,
                            child: Image.asset(
                              'assets/images/laptop.png',
                              height: 120,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      // Countdown badge
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D60FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '01 Hr 00 Min 00 left',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Location + dots row
                  SizedBox(
                    height: 20,
                    child: Stack(
                      children: [
                        // Centered dots
                        Align(
                          alignment: Alignment.center,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              double slideValue = (_animation.value.dx + 0.3) / 0.6;
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.lerp(
                                          Colors.grey, const Color(0xFF2D60FF), slideValue),
                                    ),
                                  ),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(horizontal: 2),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF000000),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Location icon + text on the right
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.location_on, size: 14, color: Color(0xFF243BCD)),
                              SizedBox(width: 2),
                              Text(
                                'Delhi',
                                style: TextStyle(fontSize: 12, color: Color(0xFF000000)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Product Details
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top Brand MacBook and Laptop',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Text('Quantity: ', style: TextStyle(color: Color(0xFF243BCD))),
                Text(
                  '40 items',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Text('MRP: ', style: TextStyle(color: Color(0xFF243BCD))),
                Text(
                  '₹ 6,41,284',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Text('Floor Price: ', style: TextStyle(color: Color(0xFF243BCD))),
                Text(
                  '₹ 78,000',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => toggleButton('bid'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF000000)),
                      backgroundColor: isBidExpiredPressed
                          ? const Color(0xFF1A3CCC)
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Bid Expired',
                      style: TextStyle(
                        color: isBidExpiredPressed
                            ? Colors.white
                            : const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => toggleButton('share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSharePressed
                          ? const Color(0xFF1A3CCC)
                          : Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: isSharePressed
                            ? BorderSide.none
                            : const BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    child: Text(
                      'Share',
                      style: TextStyle(
                        color: isSharePressed ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
