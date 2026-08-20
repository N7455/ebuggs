import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'compalte _repair.dart';

class RepairRequestPage extends StatefulWidget {
  const RepairRequestPage({super.key});

  @override
  State<RepairRequestPage> createState() => _RepairRequestPageState();
}

class _RepairRequestPageState extends State<RepairRequestPage> {
  String? brandModel;
  String? age;
  String? serviceType;
  String? address;
  String? dateTime;

  final TextEditingController issueController = TextEditingController();
  final TextEditingController costController = TextEditingController();

  bool isButtonPressed = false;

  bool get isFormFilled {
    return brandModel != null &&
        age != null &&
        serviceType != null &&
        address != null &&
        dateTime != null &&
        issueController.text.isNotEmpty &&
        costController.text.isNotEmpty;
  }

  void validateAndSubmit() {
    setState(() => isButtonPressed = true);

    if (isFormFilled) {
      // ✅ Next page ya confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form submitted successfully ✅")),
      );
    } else {
      // ❌ Validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Please fill all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F1F1),
        elevation: 1,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(left: width * 0.03),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),

      body: DefaultTextStyle.merge(
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: ListView(
            children: [
              /// 🔹 Device Information Section
              const Text('Device Information', style: TextStyle(fontSize: 16)),
              SizedBox(height: width * 0.03),

              // Dropdown: Brand & Model
              const Text('Brand & Model'),
              SizedBox(height: width * 0.015),
              dropdownField(
                value: brandModel,
                onChanged: (val) => setState(() => brandModel = val),
                items: ['Dell', 'HP', 'Apple'],
                errorText: isButtonPressed && brandModel == null ? "Fill this text" : null,
              ),

              SizedBox(height: width * 0.04),
              const Text('Approximate Age'),
              SizedBox(height: width * 0.015),
              dropdownField(
                value: age,
                onChanged: (val) => setState(() => age = val),
                items: ['< 1 year', '1-3 years', '3+ years'],
                errorText: isButtonPressed && age == null ? "Fill this text" : null,
              ),

              SizedBox(height: width * 0.04),
              const Text('Issue Description'),
              SizedBox(height: width * 0.015),
              textArea(
                controller: issueController,
                errorText: isButtonPressed && issueController.text.isEmpty ? "Fill this text" : null,
              ),

              SizedBox(height: width * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  UploadBox(icon: Icons.photo_camera, label: 'Upload Photo'),
                  UploadBox(icon: Icons.videocam, label: 'Upload Video'),
                ],
              ),

              SizedBox(height: width * 0.08),
              const Text('Location & Pickup Options', style: TextStyle(fontSize: 16)),
              SizedBox(height: width * 0.04),

              const Text('Service Type'),
              SizedBox(height: width * 0.015),
              dropdownField(
                value: serviceType,
                onChanged: (val) => setState(() => serviceType = val),
                items: ['Pickup', 'Drop-off', 'On-site'],
                errorText: isButtonPressed && serviceType == null ? "Fill this text" : null,
              ),

              SizedBox(height: width * 0.04),
              const Text('Address'),
              SizedBox(height: width * 0.015),
              dropdownField(
                value: address,
                onChanged: (val) => setState(() => address = val),
                items: ['Home', 'Office', 'Other'],
                errorText: isButtonPressed && address == null ? "Fill this text" : null,
              ),

              SizedBox(height: width * 0.04),
              const Text('Preferred Date/Time'),
              SizedBox(height: width * 0.015),
              dropdownField(
                value: dateTime,
                onChanged: (val) => setState(() => dateTime = val),
                items: ['Tomorrow', 'This Weekend', 'Next Week'],
                errorText: isButtonPressed && dateTime == null ? "Fill this text" : null,
              ),

              SizedBox(height: width * 0.04),
              const Text('Estimated Cost'),
              SizedBox(height: width * 0.015),
              TextField(
                controller: costController,
                keyboardType: TextInputType.number,
                decoration: inputDecoration().copyWith(
                  errorText: isButtonPressed && costController.text.isEmpty ? "Fill this text" : null,
                ),
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),

              SizedBox(height: width * 0.06),

              /// 🔹 Submit Button
              ElevatedButton(
                onPressed: () {
                  if (isFormFilled) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderSuccessPage(), // <-- dusra page
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFormFilled
                      ? (isButtonPressed ? const Color(0xFF1A3CCC) : const Color(0xFF2D60FF))
                      : Colors.grey.shade400,
                  padding: EdgeInsets.symmetric(vertical: width * 0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Confirm Repair Request',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget dropdownField({
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    String? errorText,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      decoration: inputDecoration().copyWith(errorText: errorText),
      style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: Colors.black),
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text(item, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      ))
          .toList(),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget textArea({required TextEditingController controller, String? errorText}) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: inputDecoration().copyWith(errorText: errorText),
      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
    );
  }
}

class UploadBox extends StatelessWidget {
  final IconData icon;
  final String label;

  const UploadBox({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.grey),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
