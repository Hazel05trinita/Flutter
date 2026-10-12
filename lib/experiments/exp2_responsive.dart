import 'package:flutter/material.dart';

class Exp2ResponsivePage extends StatelessWidget {
  const Exp2ResponsivePage({super.key});

  // Dynamic list dataset (Can easily be fetched from an API or database)
  final List<Map<String, dynamic>> fruitList = const [
    {
      "name": "Apple",
      "price": 180.0,
      "image": "assets/images/apple.jpg",
      "color": Colors.red,
    },
    {
      "name": "Banana",
      "price": 60.0,
      "image": "assets/images/banana.jpg",
      "color": Colors.amber,
    },
    {
      "name": "Orange",
      "price": 120.0,
      "image": "assets/images/orange.jpg",
      "color": Colors.orange,
    },
    {
      "name": "Grapes",
      "price": 90.0,
      "image": "assets/images/grapes.jpg",
      "color": Colors.purple,
    },
    {
      "name": "Mango",
      "price": 150.0,
      "image": "assets/images/mango.jpg",
      "color": Colors.amber,
    },
    {
      "name": "Pineapple",
      "price": 110.0,
      "image": "assets/images/pineapple.jpg",
      "color": Colors.yellow,
    },
    {
      "name": "Watermelon",
      "price": 50.0,
      "image": "assets/images/watermelon.jpg",
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Dynamic ListView',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      // Dynamic ListView Builder
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: fruitList.length,
        itemBuilder: (context, index) {
          final item = fruitList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: MyListItem(
              fruitname: item["name"],
              price: item["price"],
              image: item["image"],
              fallbackColor: item["color"],
            ),
          );
        },
      ),
    );
  }
}

// Reusable Custom List Item Widget
class MyListItem extends StatelessWidget {
  final String fruitname;
  final double price;
  final String image;
  final Color fallbackColor;

  const MyListItem({
    super.key,
    required this.fruitname,
    required this.price,
    required this.image,
    this.fallbackColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Displays local asset with fallback container on error
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: fallbackColor.withOpacity(0.2),
                    child: Icon(
                      Icons.fastfood,
                      color: fallbackColor,
                      size: 36,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fruitname,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Price: ₹${price.toStringAsFixed(0)} / kg',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Add to cart action
            IconButton(
              icon: const Icon(Icons.add_shopping_cart, color: Colors.teal),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$fruitname added to cart!'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}