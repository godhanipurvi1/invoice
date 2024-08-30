// import 'package:flutter/material.dart';
//
// class InvoicePage extends StatefulWidget {
//   @override
//   _InvoicePageState createState() => _InvoicePageState();
// }
//
// class _InvoicePageState extends State<InvoicePage> {
//   List<Map<String, dynamic>> products = [];
//   final formKey = GlobalKey<FormState>();
//
//   String _totalPriceText = 'Total Price: 0.0';
//
//   String _newProductName = '';
//   double _newProductPrice = 0.0;
//   int _newProductQty = 0;
//
//   void _saveNewProductDetails() {
//     // Add your logic here to save the new product details
//     // For example, you can add the new product to a list of products
//     products.add({
//       'name': _newProductName,
//       'price': _newProductPrice,
//       'quantity': _newProductQty,
//     });
//     setState(() {
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Invoice Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             //display save products
//             Expanded(
//               child: ListView.builder(
//                 itemCount: products.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(products[index]['name']),
//                       subtitle: Text('Quantity: ${products[index]['quantity']}, Price: ${products[index]['price']}'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       // Add a floating action button
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//
//           // Show a dialog to add new product details
//           _showAddProductDialog(context);
//           setState(() {
//
//           });
//         },
//         tooltip: 'Add Product',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//   void _showAddProductDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add New Product'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Product Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a product name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _newProductName = value!,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Price'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a price';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) => _newProductPrice = double.parse(value!),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Quantity'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a quantity';
//                   }
//                   return null;
//                 },
//                 onChanged: (val){
//                   _newProductQty = val as int;
//                   setState(() {
//
//                   });
//                 },
//                 onSaved: (value) => _newProductQty = int.parse(value!),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Save the new product details
//                 _saveNewProductDetails();
//                 Navigator.of(context).pop();
//                 setState(() {
//
//                 });
//               },
//               child: Text('Add'),
//
//             ),
//
//           ],
//         );
//       },
//     );
//   }
//
//
//
//
//
//
//
//
//   // Function to calculate the total price
//   double _calculateTotalPrice(double price, int qty) {
//     return price * qty;
//   }
// }
import 'package:flutter/material.dart';
import 'package:invoice/views/list.dart';
import 'package:invoice/views/pdfpage.dart'; // Ensure this path is correct

class InvoicePage extends StatefulWidget {
  final Function(Invoice) onCreate;

  InvoicePage({required this.onCreate});

  @override
  _InvoicePageState createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final List<Item> _items = [];
  final _idController = TextEditingController();
  double _totalPrice = 0.0;

  void _addItem(String name, double price, int quantity) {
    setState(() {
      _items.add(Item(name: name, price: price, quantity: quantity));
      _updateTotalPrice();
    });
  }

  void _updateTotalPrice() {
    double total = _items.fold(0.0, (sum, item) => sum + item.price * item.quantity);
    setState(() {
      _totalPrice = total;
    });
  }

  void _showAddItemDialog() {
    String name = '';
    double price = 0.0;
    int quantity = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Item Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) => price = double.tryParse(value) ?? 0.0,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                onChanged: (value) => quantity = int.tryParse(value) ?? 0,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addItem(name, price, quantity);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _generatePdf() {
    final invoice = Invoice(id: _idController.text, items: _items);
    generatePdf(invoice);
    widget.onCreate(invoice);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'Invoice ID'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}, Price: \$${item.price.toStringAsFixed(2)}'),
                      trailing: Text('Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Text('Total Price: \$${_totalPrice.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _generatePdf,
              child: Text('Generate PDF'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}

