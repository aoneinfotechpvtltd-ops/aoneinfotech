// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import '../controllers/token_controller.dart';
// import '../model/token_model.dart';
// import '../utilis/app_colors.dart';
//
// class TokenVerificationScreen extends StatefulWidget {
//   const TokenVerificationScreen({super.key});
//
//   @override
//   State<TokenVerificationScreen> createState() =>
//       _TokenVerificationScreenState();
// }
//
// class _TokenVerificationScreenState extends State<TokenVerificationScreen> {
//   late MobileScannerController scannerController;
//   final tokenController = Get.find<TokenController>();
//   bool isProcessing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     scannerController = MobileScannerController();
//   }
//
//   @override
//   void dispose() {
//     scannerController.dispose();
//     super.dispose();
//   }
//
//   void _processQRData(String qrData) {
//     if (isProcessing) return;
//
//     isProcessing = true;
//
//     try {
//       // Parse QR data: TOKEN|id|tokenNumber|serialNumber|vehicle|material|weight|validFrom|validUntil
//       final parts = qrData.split('|');
//
//       if (parts.length < 4 || parts[0] != 'TOKEN') {
//         _showErrorDialog('Invalid QR Code', 'This QR code is not a valid token.');
//         isProcessing = false;
//         return;
//       }
//
//       final tokenId = parts[1];
//       final tokenNumber = parts[2];
//       final serialNumber = parts[3];
//
//       // Find token in loaded tokens
//       final token = tokenController.tokens.firstWhereOrNull(
//             (t) => t.id == tokenId && t.serialNumber.toString() == serialNumber,
//       );
//
//       if (token == null) {
//         _showErrorDialog(
//           'Token Not Found',
//           'Token $tokenNumber (SN: $serialNumber) not found in system.',
//         );
//         isProcessing = false;
//         return;
//       }
//
//       _showTokenDetailsDialog(token);
//     } catch (e) {
//       _showErrorDialog('Error', 'Failed to process QR code: ${e.toString()}');
//     }
//
//     isProcessing = false;
//   }
//
//   void _showErrorDialog(String title, String message) {
//     Get.dialog(
//       AlertDialog(
//         icon: const Icon(Icons.error, color: AppColors.error, size: 32),
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Get.back();
//               scannerController.start();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primary,
//             ),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showTokenDetailsDialog(TokenModel token) {
//     final serialStr = token.serialNumber.toString().padLeft(8, '0');
//     final printSeqStr = token.printSequence.toString().padLeft(8, '0');
//
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text('Token Details'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Status
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: token.isValid
//                       ? AppColors.success.withOpacity(0.1)
//                       : AppColors.error.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       token.isValid ? Icons.verified : Icons.block,
//                       color: token.isValid ? AppColors.success : AppColors.error,
//                       size: 20,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       token.isValid ? 'VALID' : 'INVALID',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: token.isValid
//                             ? AppColors.success
//                             : AppColors.error,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Divider(),
//               const SizedBox(height: 8),
//
//               // Token Numbers
//               _buildDetailRow('Token Number', token.tokenNumber),
//               _buildDetailRow('Serial Number', serialStr),
//               _buildDetailRow('Print Sequence', printSeqStr),
//
//               const SizedBox(height: 12),
//               const Divider(),
//               const SizedBox(height: 8),
//
//               // Token Details
//               _buildDetailRow('Status', token.status.toUpperCase()),
//               _buildDetailRow('Print Count', token.printCount.toString()),
//               _buildDetailRow(
//                 'Vehicle',
//                 token.vehicleNumber ?? 'Not Assigned',
//               ),
//               _buildDetailRow(
//                 'Material',
//                 token.materialType ?? 'N/A',
//               ),
//               if (token.weightInKg != null)
//                 _buildDetailRow('Weight', '${token.weightInKg} Kg'),
//
//               const SizedBox(height: 12),
//               const Divider(),
//               const SizedBox(height: 8),
//
//               // Validity
//               _buildDetailRow(
//                 'Valid From',
//                 '${token.validFrom.day}/${token.validFrom.month}/${token.validFrom.year}',
//               ),
//               _buildDetailRow(
//                 'Valid Until',
//                 '${token.validUntil.day}/${token.validUntil.month}/${token.validUntil.year}',
//               ),
//
//               const SizedBox(height: 12),
//               const Divider(),
//               const SizedBox(height: 8),
//
//               // Created Info
//               _buildDetailRow(
//                 'Created',
//                 '${token.createdAt.day}/${token.createdAt.month}/${token.createdAt.year}',
//               ),
//               if (token.usedAt != null)
//                 _buildDetailRow(
//                   'Used On',
//                   '${token.usedAt!.day}/${token.usedAt!.month}/${token.usedAt!.year}',
//                 ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back();
//               scannerController.start();
//             },
//             child: const Text('Close'),
//           ),
//           if (token.status == 'active' && token.isValid)
//             ElevatedButton.icon(
//               onPressed: () {
//                 _markTokenAsUsed(token);
//               },
//               icon: const Icon(Icons.check),
//               label: const Text('Mark as Used'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.success,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   void _markTokenAsUsed(TokenModel token) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Mark Token as Used'),
//         content: const Text(
//           'Are you sure you want to mark this token as used? This action cannot be undone.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Call controller function to mark as used
//               tokenController.updateTokenStatus(token.id, 'used');
//               Get.back();
//               Get.back();
//               scannerController.start();
//               Get.snackbar(
//                 'Success',
//                 'Token marked as used',
//                 backgroundColor: AppColors.success,
//                 colorText: Colors.white,
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.success,
//             ),
//             child: const Text('Mark as Used'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: AppColors.textSecondary,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.end,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan Token QR Code'),
//         backgroundColor: AppColors.primary,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.flashlight_on),
//             onPressed: () {
//               scannerController.toggleTorch();
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.cameraswitch),
//             onPressed: () {
//               scannerController.switchCamera();
//             },
//           ),
//         ],
//       ),
//       body: MobileScanner(
//         controller: scannerController,
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           for (final barcode in barcodes) {
//             if (barcode.rawValue != null) {
//               _processQRData(barcode.rawValue!);
//               break;
//             }
//           }
//         },
//         errorBuilder: (context, error, child) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.error, color: AppColors.error, size: 48),
//                 const SizedBox(height: 16),
//                 const Text('Camera permission required'),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () {
//                     scannerController.start();
//                   },
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }