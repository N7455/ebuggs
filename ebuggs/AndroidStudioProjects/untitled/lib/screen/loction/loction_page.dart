import 'package:flutter/material.dart';
import 'set_loction.dart'; // Make sure this page exists

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? selectedLocationText;
  TextEditingController _controller = TextEditingController();

  final List<String> places = [
    "New Delhi",
    "Mumbai",
    "Bangalore",
    "Chennai",
    "Kolkata",
    "Hyderabad",
    "Pune",
    "Jaipur",
    "Lucknow",
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    final filteredPlaces = _controller.text.isEmpty
        ? []
        : places
        .where((place) =>
        place.toLowerCase().contains(_controller.text.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: w * 0.06),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Delivery Address',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(w * 0.04),
          child: Column(
            children: [
              // Search Box
              TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    selectedLocationText = null;
                  });
                },
                style: TextStyle(fontSize: w * 0.04, fontFamily: "Inter"),
                decoration: InputDecoration(
                  hintText: "Add Location",
                  hintStyle: TextStyle(fontSize: w * 0.04, fontFamily: "Inter"),
                  prefixIcon: Icon(Icons.add_location_alt, color: Color(0xFF243BCD)),
                  filled: true,
                  fillColor: Colors.blue.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.03),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: w * 0.04, vertical: h * 0.018),
                ),
              ),
              SizedBox(height: h * 0.02),

              // Suggestions or selected
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: h * 0.6, // light scroll height
                ),
                child: filteredPlaces.isNotEmpty
                    ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredPlaces.length,
                  itemBuilder: (context, index) {
                    final place = filteredPlaces[index];
                    return ListTile(
                      title: Text(
                        place,
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: w * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedLocationText = place;
                          _controller.text = place;
                        });
                      },
                    );
                  },
                )
                    : Center(
                  child: selectedLocationText == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/business-location.png",
                        width: w * 1.0,
                        height: h * 0.4,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: h * 0.02),
                      Text(
                        'Your address book is empty',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on,
                          size: w * 0.2, color: Color(0xFF243BCD)),
                      SizedBox(height: h * 0.02),
                      Text(
                        selectedLocationText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: ElevatedButton(
          onPressed: selectedLocationText == null
              ? null
              : () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddressConfirmPage(
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: h * 0.02),
            backgroundColor: selectedLocationText == null
                ? Colors.blue.shade200
                : Color(0xFF243BCD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w * 0.03),
            ),
          ),
          child: Text(
            'Set Address',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: w * 0.045,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
