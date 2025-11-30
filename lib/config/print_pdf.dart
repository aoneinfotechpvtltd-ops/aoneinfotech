import 'dart:typed_data';

import 'package:aoneinfotech/config/supabase_config.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/auth_controller.dart';
import '../controllers/user_management_controller.dart';
import '../model/user_model.dart';
String generateThermalPrintFormat(ChallanModel challan) {
  return '''
========================================
          TRANSPORT CHALLAN
========================================
Challan No: ${challan.challanNumber}
Date: ${challan.createdAt.day}/${challan.createdAt.month}/${challan.createdAt.year}
Time: ${challan.createdAt.hour}:${challan.createdAt.minute}
----------------------------------------
VEHICLE DETAILS
Vehicle No: ${challan.vehicleNumber}
Vehicle Type: ${challan.vehicleType}
Tyres: ${challan.tyres}
Driver: ${challan.driverName}
${challan.driverPhone != null ? 'Phone: ${challan.driverPhone}' : ''}
----------------------------------------
MATERIAL DETAILS
Material: ${challan.materialType}
Weight: ${challan.weight} KG
Rate: ${challan.rate}/KG
----------------------------------------
TOTAL AMOUNT: ${challan.totalAmount}
----------------------------------------
${challan.remarks != null ? 'Remarks: ${challan.remarks}' : ''}

''';
}
String printToken(TokenModel token)  {
  try {
    final now = DateTime.now();

    final tokenData = '''
================================
      TOKEN RECEIPT
================================
Token No: ${token.tokenNumber}
--------------------------------
Vehicle: ${token.vehicleNumber ?? 'Not Assigned'}
Material: ${token.materialType ?? 'N/A'}
Weight: ${token.weightInKg != null ? '${token.weightInKg} Kg' : 'N/A'}
--------------------------------
Valid From: 
${token.validFrom.day.toString().padLeft(2, '0')}/${token.validFrom.month.toString().padLeft(2, '0')}/${token.validFrom.year}

Valid Until: 
${token.validUntil.day.toString().padLeft(2, '0')}/${token.validUntil.month.toString().padLeft(2, '0')}/${token.validUntil.year}
--------------------------------
Status: ${token.status.toUpperCase()}
--------------------------------
Printed On:
${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}
================================
     THANK YOU
================================
      ''';

    print(tokenData);

return tokenData;
  } catch (e) {
    return '';
    Get.snackbar('Error', 'Failed to print token: ${e.toString()}');
  }
}

Future<void> generateChallanPDF(ChallanModel challan) async {
  final pdf = pw.Document();

  final formattedText = generateThermalPrintFormat(challan);

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80, // Thermal size (80mm)
      build: (pw.Context context) {
        return pw.Text(
          formattedText,
          style: pw.TextStyle(fontSize: 12),
        );
      },
    ),
  );

  // Flutter Web → Display / Download PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
// Future<void> generateTokenPDF(TokenModel challan) async {
//   final pdf = pw.Document();
//
//   final formattedText = printToken(challan);
//
//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.roll80, // Thermal size (80mm)
//       build: (pw.Context context) {
//         return pw.Text(
//           formattedText,
//           style: pw.TextStyle(fontSize: 12),
//         );
//       },
//     ),
//   );
//
//   // Flutter Web → Display / Download PDF
//   await Printing.layoutPdf(
//     onLayout: (PdfPageFormat format) async => pdf.save(),
//   );
// }
Future<void> generateChallanPDFList(List<ChallanModel> challans) async {
  final pdf = pw.Document();

  for (var challan in challans) {
    final text = generateThermalPrintFormat(challan);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Text(
            text,
            style: pw.TextStyle(fontSize: 12),
          );
        },
      ),
    );
  }

  // Show/Download PDF in browser
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
String generateTokenQRData(TokenModel token) {
  return '''TOKEN|${token.id}|${token.tokenNumber}|${token.serialNumber}|${token.vehicleNumber ?? 'N/A'}|${token.materialType ?? 'N/A'}|${token.weightInKg ?? 0}|${token.validFrom}|${token.validUntil}''';
}

// Generate Thermal Print Format with Serial Number
String generateTokenThermalPrintFormat(TokenModel token) {
  final now = DateTime.now();
  final serialStr = token.serialNumber.toString().padLeft(8, '0');
  final printSeqStr = token.printSequence.toString().padLeft(8, '0');

  return '''
================================
      TOKEN RECEIPT
================================
Serial No: $serialStr
Print Seq: $printSeqStr
Token No: ${token.tokenNumber}
--------------------------------
Vehicle: ${token.vehicleNumber ?? 'Not Assigned'}
Material: ${token.materialType ?? 'N/A'}
Weight: ${token.weightInKg != null ? '${token.weightInKg} Kg' : 'N/A'}
--------------------------------
Valid From: 
${token.validFrom.day.toString().padLeft(2, '0')}/${token.validFrom.month.toString().padLeft(2, '0')}/${token.validFrom.year}

Valid Until: 
${token.validUntil.day.toString().padLeft(2, '0')}/${token.validUntil.month.toString().padLeft(2, '0')}/${token.validUntil.year}
--------------------------------
Status: ${token.status.toUpperCase()}
--------------------------------
Printed On:
${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}
Print Count: ${token.printCount + 1}

      ''';
}

// Generate QR Code Image
Future<Uint8List> generateQRCodeImage(TokenModel token) async {
  final qrData = generateTokenQRData(token);

  try {
    final qrImage = QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 200,
    );
    return Uint8List(0); // Placeholder - in real app use qr_flutter's image generation
  } catch (e) {
    // print('QR Code generation error: $e');
    return Uint8List(0);
  }
}

// Generate PDF with QR Code
// Generate Single Token PDF with 3 Copies
// Generate Single Token PDF with 3 Copies
Future<void> generateTokenPDF(TokenModel token) async {
  final pdf = pw.Document();
  final now = DateTime.now();
  final serialStr = token.serialNumber.toString().padLeft(8, '0');
  final printSeqStr = token.printSequence.toString().padLeft(8, '0');

  // Get current user and admin's company name
  final authController = Get.find<AuthController>();
  final currentUser = authController.currentUser.value;

  // Fetch admin's company name if current user is a regular user
  String? companyName;
  if (currentUser?.role == 'user' && currentUser?.createdBy != null) {
    try {
      final supabase = Supabase.instance.client;
      final adminData = await supabase
          .from(SupabaseConfig.usersTable)
          .select('company_name')
          .eq('id', currentUser!.createdBy!)
          .single();
      companyName = adminData['company_name'] as String?;
    } catch (e) {
      print('Error fetching admin company name: $e');
    }
  } else if (currentUser?.role == 'admin') {
    // If admin is creating token, use their company name
    companyName = currentUser?.companyName;
  }

  // Generate QR Code Data
  final qrData = generateTokenQRData(token);

  // Helper function to create a page
  pw.Widget createTokenPage(String copyType) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        // Copy Type Header
        if (copyType.isNotEmpty)
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(
              copyType,
              style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),

        // Company Name
        if (companyName != null && companyName.isNotEmpty)
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 4),
            child: pw.Text(
              companyName,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),

        pw.Divider(height: 8),

        // Query Name and Cluster (only if user has them)
        if (currentUser?.role == 'user') ...[
          if (currentUser?.queryName != null && currentUser!.queryName!.isNotEmpty)
            pw.Text(
              '(${currentUser.queryName}-CLUSTER-${currentUser.cluster ?? 0})',
              style: const pw.TextStyle(fontSize: 9),
            ),
          if (currentUser?.companyName != null && currentUser!.companyName!.isNotEmpty)
            pw.Text(
              currentUser.companyName!.toUpperCase(),
              style: const pw.TextStyle(fontSize: 9),
            ),
        ],

        pw.SizedBox(height: 4),

        // Date and Time
        pw.Text(
          'Date: ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}',
          style: const pw.TextStyle(fontSize: 9),
        ),

        pw.SizedBox(height: 8),

        // Token Number (Large)
        pw.Text(
          'Token No.: ${token.tokenNumber}',
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.Divider(height: 8),

        // Query Name (if available)
        if (currentUser?.role == 'user' && currentUser?.queryName != null)
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            child: pw.Text(
              'Query Name: ${currentUser!.queryName}',
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            ),
          ),

        // Cluster (if available)
        if (currentUser?.role == 'user' && currentUser?.cluster != null)
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            child: pw.Text(
              'Cluster: ${currentUser!.cluster.toString().padLeft(2, '0')}',
              style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
            ),
          ),

        pw.Divider(height: 8),

        // Driver Details
        pw.Text(
          'Driver Name: ${token.driverName ?? 'N/A'}',
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.Text(
          'Driver Mobile No: ${token.driverMobile ?? 'N/A'}',
          style: const pw.TextStyle(fontSize: 10),
        ),

        pw.Divider(height: 8),

        // Vehicle Details
        pw.Text(
          'Vehical No.: ${token.vehicleNumber ?? 'Not Assigned'}',
          style: const pw.TextStyle(fontSize: 10),
        ),
        if (token.vehicleType != null)
          pw.Text(
            'Vehical Type: ${token.vehicleType}',
            style: const pw.TextStyle(fontSize: 10),
          ),

        pw.Divider(height: 8),

        // Quantity
        if (token.quantity != null)
          pw.Text(
            'Quantity: ${token.quantity}',
            style: const pw.TextStyle(fontSize: 10),
          ),

        // Place
        if (token.place != null)
          pw.Text(
            'Place: ${token.place}',
            style: const pw.TextStyle(fontSize: 10),
          ),

        pw.Divider(height: 8),

        // Supervisor Details
        pw.Text(
          'Supervisor Name: ${token.supervisorName ?? 'N/A'}',
          style: const pw.TextStyle(fontSize: 10),
        ),

        // Material and Weight (if available)
        if (token.materialType != null)
          pw.Text(
            'Material: ${token.materialType}',
            style: const pw.TextStyle(fontSize: 9),
          ),
        if (token.weightInKg != null)
          pw.Text(
            'Weight: ${token.weightInKg} Kg',
            style: const pw.TextStyle(fontSize: 9),
          ),

        pw.Divider(height: 8),

        // Serial Number (Large)
        pw.Text(
          'Serial No: $serialStr',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 8),

        // QR Code
        pw.BarcodeWidget(
          barcode: pw.Barcode.qrCode(),
          data: qrData,
          width: 120,
          height: 120,
        ),

        pw.SizedBox(height: 4),
      ],
    );
  }

  // Add 3 pages - Driver Copy, Company Copy, Office Copy
  final copies = ['Driver Copy', companyName??"", ''];

  for (var copyType in copies) {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        margin: pw.EdgeInsets.all(8),
        build: (pw.Context context) => createTokenPage(copyType),
      ),
    );
  }

  // Show/Download PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );

  // Increment print count
  final tokenController = Get.find<TokenController>();
  await tokenController.incrementPrintCount(token.id);
}

// Generate Multiple Tokens PDF (3 copies each)
Future<void> generateTokenPDFList(List<TokenModel> tokens) async {
  final pdf = pw.Document();

  // Get current user and admin info
  final authController = Get.find<AuthController>();
  final currentUser = authController.currentUser.value;

  for (var token in tokens) {
    final now = DateTime.now();
    final serialStr = token.serialNumber.toString().padLeft(8, '0');

    // Fetch admin's company name
    String? companyName;
    if (currentUser?.role == 'user' && currentUser?.createdBy != null) {
      try {
        final supabase = Supabase.instance.client;
        final adminData = await supabase
            .from(SupabaseConfig.usersTable)
            .select('company_name')
            .eq('id', currentUser!.createdBy!)
            .single();
        companyName = adminData['company_name'] as String?;
      } catch (e) {
        print('Error fetching admin company name: $e');
      }
    } else if (currentUser?.role == 'admin') {
      companyName = currentUser?.companyName;
    }

    final qrData = generateTokenQRData(token);

    // Helper function
    pw.Widget createPage(String copyType) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          if (copyType.isNotEmpty)
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Text(
                copyType,
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

          if (companyName != null && companyName.isNotEmpty)
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(vertical: 4),
              child: pw.Text(
                companyName,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),

          pw.Divider(height: 8),

          if (currentUser?.role == 'user') ...[
            if (currentUser?.queryName != null)
              pw.Text(
                '(${currentUser!.queryName}-CLUSTER-${currentUser.cluster ?? 0})',
                style: const pw.TextStyle(fontSize: 9),
              ),
            if (currentUser?.companyName != null)
              pw.Text(
                currentUser!.companyName!.toUpperCase(),
                style: const pw.TextStyle(fontSize: 9),
              ),
          ],

          pw.SizedBox(height: 4),

          pw.Text(
            'Date: ${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}',
            style: const pw.TextStyle(fontSize: 9),
          ),

          pw.SizedBox(height: 8),

          pw.Text(
            'Token No.: ${token.tokenNumber}',
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.Divider(height: 8),

          if (currentUser?.role == 'user') ...[
            if (currentUser?.queryName != null)
              pw.Text(
                'Query Name: ${currentUser!.queryName}',
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
            if (currentUser?.cluster != null)
              pw.Text(
                'Cluster: ${currentUser!.cluster.toString().padLeft(2, '0')}',
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
              ),
          ],

          pw.Divider(height: 8),

          pw.Text('Driver Name: ${token.driverName ?? 'N/A'}',
              style: const pw.TextStyle(fontSize: 10)),
          pw.Text('Driver Mobile No: ${token.driverMobile ?? 'N/A'}',
              style: const pw.TextStyle(fontSize: 10)),

          pw.Divider(height: 8),

          pw.Text('Vehical No.: ${token.vehicleNumber ?? 'Not Assigned'}',
              style: const pw.TextStyle(fontSize: 10)),
          if (token.vehicleType != null)
            pw.Text('Vehical Type: ${token.vehicleType}',
                style: const pw.TextStyle(fontSize: 10)),

          pw.Divider(height: 8),

          if (token.quantity != null)
            pw.Text('Quantity: ${token.quantity}',
                style: const pw.TextStyle(fontSize: 10)),
          if (token.place != null)
            pw.Text('Place: ${token.place}',
                style: const pw.TextStyle(fontSize: 10)),

          pw.Divider(height: 8),

          pw.Text('Supervisor Name: ${token.supervisorName ?? 'N/A'}',
              style: const pw.TextStyle(fontSize: 10)),

          if (token.materialType != null)
            pw.Text('Material: ${token.materialType}',
                style: const pw.TextStyle(fontSize: 9)),
          if (token.weightInKg != null)
            pw.Text('Weight: ${token.weightInKg} Kg',
                style: const pw.TextStyle(fontSize: 9)),

          pw.Divider(height: 8),

          pw.Text(
            'Serial No: $serialStr',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 8),

          pw.BarcodeWidget(
            barcode: pw.Barcode.qrCode(),
            data: qrData,
            width: 120,
            height: 120,
          ),
        ],
      );
    }

    // Add 3 copies for each token
    final copies = ['Driver Copy', companyName ?? 'Company Copy', ''];
    for (var copyType in copies) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.roll80,
          margin: pw.EdgeInsets.all(8),
          build: (pw.Context context) => createPage(copyType),
        ),
      );
    }
  }

  // Show/Download PDF
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );

  // Increment print counts
  final tokenController = Get.find<TokenController>();
  for (var token in tokens) {
    await tokenController.incrementPrintCount(token.id);
  }
}
// Future<void> generateTokenPDF(TokenModel token,) async {
//   final pdf = pw.Document();
//   final now = DateTime.now();
//   final serialStr = token.serialNumber.toString().padLeft(8, '0');
//   final printSeqStr = token.printSequence.toString().padLeft(8, '0');
//
//   // Generate QR Code Data
//   final qrData = generateTokenQRData(token);
//
//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.roll80, // Thermal size (80mm)
//       margin: pw.EdgeInsets.all(5),
//       build: (pw.Context context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.center,
//           mainAxisAlignment: pw.MainAxisAlignment.start,
//           children: [
//             pw.Text(
//               'TOKEN RECEIPT',
//               style: pw.TextStyle(
//                 fontSize: 14,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.Divider(height: 8),
//             pw.Text('Serial No: $serialStr', style: const pw.TextStyle(fontSize: 10)),
//             pw.Text('Print Seq: $printSeqStr', style: const pw.TextStyle(fontSize: 10)),
//             pw.Text('Token No: ${token.tokenNumber}',
//               style: pw.TextStyle(
//                 fontSize: 12,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//             pw.Divider(height: 8),
//             pw.Text('Vehicle: ${token.vehicleNumber ?? 'Not Assigned'}',
//                 style: const pw.TextStyle(fontSize: 9)),
//             pw.Text('Material: ${token.materialType ?? 'N/A'}',
//                 style: const pw.TextStyle(fontSize: 9)),
//             if (token.weightInKg != null)
//               pw.Text('Weight: ${token.weightInKg} Kg',
//                   style: const pw.TextStyle(fontSize: 9)),
//             pw.Divider(height: 8),
//             pw.Text('Valid From:',
//                 style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
//             pw.Text(
//               '${token.validFrom.day.toString().padLeft(2, '0')}/${token.validFrom.month.toString().padLeft(2, '0')}/${token.validFrom.year}',
//               style: const pw.TextStyle(fontSize: 9),
//             ),
//             pw.Text('Valid Until:',
//                 style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
//             pw.Text(
//               '${token.validUntil.day.toString().padLeft(2, '0')}/${token.validUntil.month.toString().padLeft(2, '0')}/${token.validUntil.year}',
//               style: const pw.TextStyle(fontSize: 9),
//             ),
//             pw.Divider(height: 8),
//             pw.Text('Status: ${token.status.toUpperCase()}',
//                 style: const pw.TextStyle(fontSize: 9)),
//             pw.Divider(height: 8),
//
//             // QR Code using BarcodeWidget
//             pw.BarcodeWidget(
//               barcode: pw.Barcode.qrCode(),
//               data: qrData,
//               width: 150,
//               height: 150,
//             ),
//
//             // pw.SizedBox(height: 4),
//             // pw.Text('Scan to Verify',
//             //   style: pw.TextStyle(
//             //     fontSize: 9,
//             //     fontWeight: pw.FontWeight.bold,
//             //   ),
//             // ),
//             pw.Divider(height: 8),
//             pw.Text(
//               'Printed: ${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}',
//               style: const pw.TextStyle(fontSize: 8),
//             ),
//             pw.Text('Print Count: ${token.printCount + 1}',
//                 style: const pw.TextStyle(fontSize: 8)),
//             pw.SizedBox(height: 4),
//             pw.Text(
//               'Do Not Duplicate',
//               style: pw.TextStyle(
//                 fontSize: 10,
//                 fontWeight: pw.FontWeight.bold,
//               ),
//             ),
//           ],
//         );
//       },
//     ),
//   );
//
//   // Show/Download PDF
//   await Printing.layoutPdf(
//     onLayout: (PdfPageFormat format) async => pdf.save(),
//   );
//
//   // Increment print count
//   final tokenController = Get.find<TokenController>();
//   await tokenController.incrementPrintCount(token.id);
// }
//
// // Generate Multiple Tokens PDF
// Future<void> generateTokenPDFList(List<TokenModel> tokens) async {
//   final pdf = pw.Document();
//
//   for (var token in tokens) {
//     final serialStr = token.serialNumber.toString().padLeft(8, '0');
//     final printSeqStr = token.printSequence.toString().padLeft(8, '0');
//     final qrData = generateTokenQRData(token);
//
//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.roll80,
//         margin: pw.EdgeInsets.all(5),
//         build: (pw.Context context) {
//           return pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.center,
//             mainAxisAlignment: pw.MainAxisAlignment.start,
//             children: [
//               pw.Text(
//                 'TOKEN RECEIPT',
//                 style: pw.TextStyle(
//                   fontSize: 14,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//               pw.Divider(height: 8),
//               pw.Text('Serial No: $serialStr',
//                   style: const pw.TextStyle(fontSize: 10)),
//               pw.Text('Print Seq: $printSeqStr',
//                   style: const pw.TextStyle(fontSize: 10)),
//               pw.Text('Token No: ${token.tokenNumber}',
//                 style: pw.TextStyle(
//                   fontSize: 12,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//               pw.Divider(height: 8),
//               pw.Text('Vehicle: ${token.vehicleNumber ?? 'Not Assigned'}',
//                   style: const pw.TextStyle(fontSize: 9)),
//               pw.Text('Material: ${token.materialType ?? 'N/A'}',
//                   style: const pw.TextStyle(fontSize: 9)),
//               if (token.weightInKg != null)
//                 pw.Text('Weight: ${token.weightInKg} Kg',
//                     style: const pw.TextStyle(fontSize: 9)),
//               pw.Divider(height: 8),
//               pw.Text('Valid From:',
//                   style: pw.TextStyle(
//                       fontSize: 9, fontWeight: pw.FontWeight.bold)),
//               pw.Text(
//                 '${token.validFrom.day.toString().padLeft(2, '0')}/${token
//                     .validFrom.month.toString().padLeft(2, '0')}/${token
//                     .validFrom.year}',
//                 style: const pw.TextStyle(fontSize: 9),
//               ),
//               pw.Text('Valid Until:',
//                   style: pw.TextStyle(
//                       fontSize: 9, fontWeight: pw.FontWeight.bold)),
//               pw.Text(
//                 '${token.validUntil.day.toString().padLeft(2, '0')}/${token
//                     .validUntil.month.toString().padLeft(2, '0')}/${token
//                     .validUntil.year}',
//                 style: const pw.TextStyle(fontSize: 9),
//               ),
//               pw.Divider(height: 8),
//               pw.Text('Status: ${token.status.toUpperCase()}',
//                   style: const pw.TextStyle(fontSize: 9)),
//               pw.Divider(height: 8),
//
//               // QR Code
//               pw.BarcodeWidget(
//                 barcode: pw.Barcode.qrCode(),
//                 data: qrData,
//                 width: 150,
//                 height: 150,
//               ),
//
//               // pw.SizedBox(height: 4),
//               // pw.Text('Scan to Verify',
//               //   style: pw.TextStyle(
//               //     fontSize: 9,
//               //     fontWeight: pw.FontWeight.bold,
//               //   ),
//               // ),
//               pw.Divider(height: 8),
//               pw.Text('Do Not Duplicate',
//                 style: pw.TextStyle(
//                   fontSize: 10,
//                   fontWeight: pw.FontWeight.bold,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   // Show/Download PDF
//   await Printing.layoutPdf(
//     onLayout: (PdfPageFormat format) async => pdf.save(),
//   );
//
//   // Increment print counts
//   final tokenController = Get.find<TokenController>();
//   for (var token in tokens) {
//     await tokenController.incrementPrintCount(token.id);
//   }
// }