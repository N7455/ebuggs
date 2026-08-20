import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AddressConfirmPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class AddressConfirmPage extends StatelessWidget {
  const AddressConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final double bottomCardHeight = h * 0.3;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.grey[200]),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
                vertical: h * 0.03,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(w * 0.06),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Confirm your order delivery address",
                    style: TextStyle(
                      fontSize: w * 0.035,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: h * 0.015),
                  Container(
                    padding: EdgeInsets.all(w * 0.035),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(w * 0.03),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.black54),
                        SizedBox(width: w * 0.025),
                        const Expanded(
                          child: Text(
                            "G-39, Noida Sec 63\nNear Hindi Khabar, Uttar Pradesh",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.02),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF243BCD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(w * 0.09),
                        ),
                        padding: EdgeInsets.symmetric(vertical: h * 0.02),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const AddressPage(),
                        );
                      },
                      child: Text(
                        "Confirm & Add details",
                        style: TextStyle(
                          fontSize: w * 0.043,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: bottomCardHeight + h * 0.03,
            left: w * 0.06,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            bottom: bottomCardHeight + h * 0.03,
            right: w * 0.06,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(icon: const Icon(Icons.add), onPressed: () {}),
            ),
          ),
        ],
      ),
    );
  }
}

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  String selectedType = "Home";
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    fullNameController.addListener(_checkFields);
    phoneController.addListener(_checkFields);
    addressController.addListener(_checkFields);
    landmarkController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      isButtonActive =
          fullNameController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          addressController.text.isNotEmpty &&
          landmarkController.text.isNotEmpty;
    });
  }

  void _showSuccessDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          // <-- Added 'child:' here
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Address Saved",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                fontFamily: "inter",
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF444444),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10), // gap between box and divider

                Container(
                  width: 111.17, // screen width ka 30%
                  height: 10, // screen height ka 10%
                  color: const Color(0xFF444444), // screen height ka 10%
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              "Address has saved\nsuccessfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),
            const Text(
              "Your order will be delivered soon to the address you provided during checkout.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontFamily: "inter",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    const SizedBox(height: 16),

                    // Left-aligned heading
                    const Text(
                      "Address Details",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      "Fill your address", // the label
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF727272),
                        fontSize: 14,
                      ),
                    ),
                    Divider(
                      color: const Color(0xFFCBC9C9),
                      thickness: 2,
                      height: 16, // optional spacing
                    ),

                    const SizedBox(height: 8),

                    // ChoiceChips with icons & dark blue selection
                    Row(
                      children: [
                        ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.home, size: 18, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                "Home",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          selected: selectedType == "Home",
                          selectedColor: Colors.blue[900],
                          backgroundColor: Colors.grey[300],
                          onSelected: (_) {
                            setState(() {
                              selectedType = "Home";
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.work, size: 18, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                "Office",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          selected: selectedType == "Office",
                          selectedColor: Colors.blue[900],
                          backgroundColor: Colors.grey[300],
                          onSelected: (_) {
                            setState(() {
                              selectedType = "Office";
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.person, size: 18, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                "Friends",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          selected: selectedType == "Friends",
                          selectedColor: Colors.blue[900],
                          backgroundColor: Colors.grey[300],
                          onSelected: (_) {
                            setState(() {
                              selectedType = "Friends";
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    buildTextField(
                      "Full Name",
                      "Enter your full name",
                      controller: fullNameController,
                    ),
                    buildTextField(
                      "Phone Number",
                      "Enter your phone number",
                      controller: phoneController,
                    ),
                    buildSmallTextField(
                      "Address",
                      "Enter your complete address",
                      controller: addressController,
                    ),
                    buildSmallTextField(
                      "Nearby Landmark",
                      "Enter landmark",
                      controller: landmarkController,
                    ),
                  ],
                ),
              ),

              // Footer button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isButtonActive
                          ? () {
                              Navigator.pop(context);
                              _showSuccessDrawer(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isButtonActive
                            ? Colors.blue[900]
                            : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Confirm & Add Details",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextField(
    String label,
    String hint, {
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildSmallTextField(
    String label,
    String hint, {
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40, maxHeight: 60),
          child: TextField(
            controller: controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
