import 'package:flutter/material.dart';
import '../Products/Product_Details.dart';

class BuyerHomeScreen extends StatefulWidget {
  @override
  _BuyerHomeScreenState createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  final List<Map<String, dynamic>> products = [
    {
      'title': 'Electrical Motor',
      'sector': 'Electrical',
      'price': 15000,
      'description': 'High-quality electrical motor',
      'images': ['assets/motor1.jpg', 'assets/motor2.jpg', 'assets/motor3.png']
    },
    {
      'title': 'Electrical Wire',
      'sector': 'Electrical',
      'price': 200,
      'description': 'Durable electrical wire',
      'images': ['assets/wire1.jpg', 'assets/wire2.jpg', 'assets/wire3.jpg']
    },
    {
      'title': 'Mechanical Gear',
      'sector': 'Mechanical',
      'price': 2500,
      'description': 'Durable mechanical gear',
      'images': ['assets/gear1.jpg', 'assets/gear2.png', 'assets/gear3.jpg']
    },
    {
      'title': 'Mechanical Pulley',
      'sector': 'Mechanical',
      'price': 1000,
      'description': 'Strong mechanical pulley',
      'images': ['assets/pulley1.jpg', 'assets/pulley2.jpg', 'assets/pulley3.jpg']
    },
    {
      'title': 'Component A',
      'sector': 'Components',
      'price': 300,
      'description': 'High-quality component A',
      'images': ['assets/componentA1.jpg', 'assets/componentA2.jpg', 'assets/componentA3.jpg']
    },
    {
      'title': 'Component B',
      'sector': 'Components',
      'price': 400,
      'description': 'Reliable component B',
      'images': ['assets/componentB1.jpg', 'assets/componentB2.jpg', 'assets/componentB3.jpg']
    },
    {
      'title': 'Part X',
      'sector': 'Parts',
      'price': 150,
      'description': 'Essential part X',
      'images': ['assets/partX1.jpg', 'assets/partX2.jpg', 'assets/partX3.jpg']
    },
    {
      'title': 'Part Y',
      'sector': 'Parts',
      'price': 75,
      'description': 'Useful part Y',
      'images': ['assets/partY1.jpg', 'assets/partY2.jpg', 'assets/partY3.jpg']
    },
  ];

  String _searchQuery = '';
  String _selectedSortOption = 'None';

  List<Map<String, dynamic>> get filteredProducts {
    List<Map<String, dynamic>> filtered = products
        .where((product) =>
        product['title'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    if (_selectedSortOption == 'Price: Low to High') {
      filtered.sort((a, b) => a['price'].compareTo(b['price']));
    } else if (_selectedSortOption == 'Price: High to Low') {
      filtered.sort((a, b) => b['price'].compareTo(a['price']));
    } else if (_selectedSortOption == 'A to Z') {
      filtered.sort((a, b) => a['title'].compareTo(b['title']));
    } else if (_selectedSortOption == 'Z to A') {
      filtered.sort((a, b) => b['title'].compareTo(a['title']));
    }

    return filtered;
  }

  void _openDropdown() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(250, 50, 0, 100),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'None',
          child: Text('None'),
        ),
        PopupMenuItem<String>(
          value: 'Price: Low to High',
          child: Text('Price: Low to High'),
        ),
        PopupMenuItem<String>(
          value: 'Price: High to Low',
          child: Text('Price: High to Low'),
        ),
        PopupMenuItem<String>(
          value: 'A to Z',
          child: Text('A to Z'),
        ),
        PopupMenuItem<String>(
          value: 'Z to A',
          child: Text('Z to A'),
        ),
      ],
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          _selectedSortOption = selectedValue;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Buyer Home'),
        actions: [
          GestureDetector(
            onTap: _openDropdown,
            child: Row(
              children: [
                Icon(Icons.filter_list, size: 28, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Filter',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Products',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredProducts.isNotEmpty
                ? ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: ListTile(
                    title: Text(filteredProducts[index]['title'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        'Sector: ${filteredProducts[index]['sector']} - Price: ₹${filteredProducts[index]['price']}',
                        style: TextStyle(fontSize: 14)),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        filteredProducts[index]['images'][0],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                              product: filteredProducts[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            )
                : Center(
              child: Text(
                'No data found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
