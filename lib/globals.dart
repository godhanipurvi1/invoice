import 'package:flutter/material.dart';
class Globals
{
  static String? company_name,company_email,company_address;
  static String? client_name,client_email,client_address;


}
class InvoiceItem {
   String? itemName;
   int? qty;
   double? price;

  InvoiceItem({required this.itemName, required this.qty, required this.price});
}