import 'package:flutter/material.dart';

import 'add_address.dart' show DeliveryAddressPage;

// ------------------ Saved Addresses Screen ------------------
class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final addresses = [
      {
        'name': 'Kavita Rana',
        'address':
        '636/25 Geet vihar colony takrohi India nagar,\nLUCKNOW, UTTAR PRADESH, 226016, India',
        'phone': '+91 0000 000 000',
      },
      {
        'name': 'Kavita Rana',
        'address':
        '636/25 Geet vihar colony takrohi India nagar,\nLUCKNOW, UTTAR PRADESH, 226016, India',
        'phone': '+91 0000 000 000',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F1F1),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Saved Addresses',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add new address button
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  DeliveryAddressPage(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.add, size: 20, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Add new Address',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF243BCD),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFE0E0E0)),
            const SizedBox(height: 16),

            // Address Cards
            Expanded(
              child: ListView.separated(
                itemCount: addresses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = addresses[index];
                  return _AddressCard(
                    name: item['name']!,
                    address: item['address']!,
                    phone: item['phone']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------ Address Card ------------------
class _AddressCard extends StatelessWidget {
  final String name;
  final String address;
  final String phone;

  const _AddressCard({
    required this.name,
    required this.address,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivering to $name',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                address,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                phone,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          // 3-dot menu
          Positioned(
            right: 0,
            top: 0,
            child: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.more_vert, size: 20),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text(
                    'Edit',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ),
                const PopupMenuItem(
                  value: 'remove',
                  child: Text(
                    'Remove',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
              onSelected: (value) {
                // Handle edit/remove logic
              },
            ),
          ),
        ],
      ),
    );
  }
}


