// import 'package:flutter/material.dart';
//
// import 'invoicepage.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//       routes: {
//         '/invoice': (context) => InvoicePage(),
//       },
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(context, '/invoice');
//           },
//           child: Container(
//             width: 200,
//             height: 50,
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Center(
//               child: Text(
//                 'Redirect to Invoice Page',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:invoice/views/list.dart';
import 'invoicepage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Invoice> _invoices = [];

  void _addInvoice(Invoice invoice) {
    setState(() {
      _invoices.add(invoice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Invoice Generator'),
        // actions: [
        //   IconButton(onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=>p))
        //   }, icon: Icon(Icons.picture_as_pdf))
        // ],

      ),
      body: ListView.builder(
        itemCount: _invoices.length,
        itemBuilder: (context, index) {
          final invoice = _invoices[index];
          return ListTile(
            title: Text('Invoice ${invoice.id}'),
            subtitle: Text('Total: \$${invoice.total.toStringAsFixed(2)}'),
            onTap: () {

            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InvoicePage(onCreate: _addInvoice)),
          );
        },
      ),
    );
  }
}
