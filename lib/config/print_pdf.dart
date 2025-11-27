import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
// ========================================
//     Authorized Signature
// ========================================
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
Future<void> generateTokenPDF(TokenModel challan) async {
  final pdf = pw.Document();

  final formattedText = printToken(challan);

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

