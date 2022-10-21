import 'package:get/get.dart';
import 'package:safqa/models/invoice.dart';
import 'package:safqa/models/invoice_types.dart';

class InvoicesController extends GetxController {
  List<Invoice> invoices = [
    Invoice(
      customerName: "Ahmad",
      date: "09 oct 2022",
      price: "\$ 500.0",
      time: "06:06 PM",
      type: InvoiceTypes.paid,
      id: "#2246721531",
    ),
    Invoice(
      customerName: "Ahmad",
      date: "09 oct 2022",
      price: "\$ 500.0",
      time: "06:06 PM",
      type: InvoiceTypes.unPaid,
      id: "#2246721531",
    ),
    Invoice(
      customerName: "Ahmad",
      date: "09 oct 2022",
      price: "\$ 500.0",
      time: "06:06 PM",
      type: InvoiceTypes.canceled,
      id: "#2246721531",
    ),
    Invoice(
      customerName: "Ahmad",
      date: "09 oct 2022",
      price: "\$ 500.0",
      time: "06:06 PM",
      type: InvoiceTypes.pending,
      id: "#2246721531",
    ),
  ];
}
