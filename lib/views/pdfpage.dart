

import 'package:pdf/widgets.dart' as pw;
import 'list.dart';

Future<String> generatePdf(Invoice invoice) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Invoice ID: ${invoice.id}', style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Price', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text('Total Invoice Amount: \$${invoice.total.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
                ...invoice.items.map((item) {
                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(item.name),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('\$${item.price.toStringAsFixed(2)}'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('${item.quantity}'),
                      ),
                      // pw.Padding(
                      //   padding: const pw.EdgeInsets.all(8.0),
                      //   child: pw.Text('\$${item.total.toStringAsFixed(2)}'),
                      // ),
                    ],
                  );
                }).toList(),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text('Total: \$${invoice.total.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ],
        );
      },
    ),
  );


}
