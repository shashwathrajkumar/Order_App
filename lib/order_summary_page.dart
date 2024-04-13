import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:first_project/cart_item.dart';
import 'mobile.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';


class OrderSummaryPage extends StatefulWidget {
  final List<CartItem> cartItems;

  OrderSummaryPage({required this.cartItems});

  @override
  _OrderSummaryPageState createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  GlobalKey globalKey = GlobalKey();

  // Declare totalPrice at the class level
  late double totalPrice;
  late String formattedDate;
  @override
  void initState() {
    super.initState();
    // Calculate total price of all items
    totalPrice = widget.cartItems.fold(0, (previous, current) => previous + current.price);
    formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange[600], // Set background color to orange[600]
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Add rounded corners
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home'); // Navigate to CartPage
            },
            icon: Icon(Icons.home), // Icon for viewing cart
          ),
        ],
      ),
      body: RepaintBoundary(
        key: globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display the "Date" row
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0), // Adjust padding
              child: Row(
                children: [
                  Text(
                    'Date:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(width: 8.0), // Add some space between "Date:" label and the date
                  Text(
                    formattedDate,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            // Display cart items in a DataTable
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.blue), // Color for heading row
                  dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[300] ?? Colors.grey), // Color for data rows
                  columns: [
                    DataColumn(
                      label: Text(
                        'Product',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Style for column heading
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Quantity',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Style for column heading
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Price',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Style for column heading
                      ),
                    ),
                  ],
                  rows: [
                    ...widget.cartItems.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item.name, style: TextStyle(color: Colors.black))),
                        DataCell(Text(item.quantity.toString(), style: TextStyle(color: Colors.black))),
                        DataCell(Text(item.price.toString(), style: TextStyle(color: Colors.black))),
                      ]);
                    }).toList(),
                    DataRow(cells: [
                      DataCell(Text('Total Price', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                      DataCell(Text('')),
                      DataCell(Text(totalPrice.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {

            _saveOrderSummary();
          },
          child: Text('View/Print Order Summary'),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Future<void> _saveOrderSummary() async {
    PdfDocument document = PdfDocument();

// Add a page to the document
    final page = document.pages.add();

// Add the "XYZ Company" heading to the PDF at the top-center
    final headingFont = PdfStandardFont(PdfFontFamily.helvetica, 20);
    final headingSize = headingFont.measureString('XYZ Company - Invoice');
    final headingX = (page.getClientSize().width - headingSize.width) / 2;
    final headingY = 0;
    page.graphics.drawString('XYZ Company - Invoice', headingFont, bounds: Rect.fromLTWH(headingX.toDouble(), headingY.toDouble(), headingSize.width, headingSize.height));


// Add date stamp to the top left corner of the page
    final currentTime = DateTime.now();
    final dateStamp = '${currentTime.year}-${currentTime.month}-${currentTime.day}';
    page.graphics.drawString(dateStamp, PdfStandardFont(PdfFontFamily.helvetica, 12), bounds: Rect.fromLTWH(0, 0, 100, 20));

// Create a PdfGrid for the order details
    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 20, style: PdfFontStyle.bold), // Set font style to bold
      cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2),
    );
    grid.columns.add(count: 3);
    grid.headers.add(1);

// Set header cells
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Product';
    header.cells[1].value = 'Quantity';
    header.cells[2].value = 'Price';

// Add rows for cart items
    for (var item in widget.cartItems) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = item.name;
      row.cells[1].value = item.quantity.toString();
      row.cells[2].value = item.price.toString();
    }

// Add the total price row
    PdfGridRow totalPriceRow = grid.rows.add();
    totalPriceRow.cells[0].value = 'Total Price';
    totalPriceRow.cells[1].value = '';
    totalPriceRow.cells[2].value = widget.cartItems.fold<double>(0, (previous, current) => previous + current.price).toString();

// Draw the grid on the PDF page
    grid.draw(page: page, bounds: Rect.fromLTWH(0, 50, page.getClientSize().width, page.getClientSize().height - 50));

// Add icon at the top right corner of the page
    final iconImage = PdfBitmap(await _loadImage('icons/icon.png')); // Replace 'path_to_your_icon' with the actual path to your icon
    final iconWidth = 40.0; // Adjust the width of the icon as needed
    final iconHeight = 40.0; // Adjust the height of the icon as needed
    final pageWidth = page.getClientSize().width;
    page.graphics.drawImage(
      iconImage,
      Rect.fromLTWH(pageWidth - iconWidth, 0, iconWidth, iconHeight),
    );

// Save the PDF document
    List<int> bytes = await document.save();
    document.dispose();

// Save and launch the PDF file
    saveAndLaunchFile(bytes, 'Invoice.pdf');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order summary saved successfully'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  Future<Uint8List> _loadImage(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    return data.buffer.asUint8List();
  }

}
