// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../controllers/challan_controller.dart';
// import '../../utilis/app_colors.dart';
//
// class CreateChallanScreen extends StatelessWidget {
//   const CreateChallanScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ChallanController());
//     final formKey = GlobalKey<FormState>();
//
//     final vehicleNumberController = TextEditingController();
//     final driverNameController = TextEditingController();
//     final driverPhoneController = TextEditingController();
//     final weightController = TextEditingController();
//     final rateController = TextEditingController();
//     final tokenController = TextEditingController();
//     final remarksController = TextEditingController();
//
//     final selectedVehicleType = 'Truck'.obs;
//     final selectedMaterialType = 'Sand'.obs;
//     final totalAmount = 0.0.obs;
//
//     void calculateTotal() {
//       final weight = double.tryParse(weightController.text) ?? 0;
//       final rate = double.tryParse(rateController.text) ?? 0;
//       totalAmount.value = weight * rate;
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create New Challan'),
//         backgroundColor: AppColors.primary,
//       ),
//       body: Form(
//         key: formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Header Card
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   gradient: AppColors.primaryGradient,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.receipt_long, color: Colors.white, size: 32),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'New Challan Entry',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             'Fill all details carefully',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ).animate().fadeIn().slideY(begin: -0.2),
//               const SizedBox(height: 20),
//
//               // Vehicle Details Section
//               _buildSectionTitle('Vehicle Details'),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: vehicleNumberController,
//                 decoration: InputDecoration(
//                   labelText: 'Vehicle Number *',
//                   hintText: 'e.g., GJ01AB1234',
//                   prefixIcon: const Icon(Icons.local_shipping),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 textCapitalization: TextCapitalization.characters,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter vehicle number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               Obx(() => DropdownButtonFormField<String>(
//                 value: selectedVehicleType.value,
//                 decoration: InputDecoration(
//                   labelText: 'Vehicle Type *',
//                   prefixIcon: const Icon(Icons.category),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 items: ['Truck', 'Tractor', 'Dumper', 'Trailer', 'Other']
//                     .map((type) => DropdownMenuItem(
//                   value: type,
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) selectedVehicleType.value = value;
//                 },
//               )),
//               const SizedBox(height: 20),
//
//               // Driver Details Section
//               _buildSectionTitle('Driver Details'),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: driverNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Driver Name *',
//                   prefixIcon: const Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 textCapitalization: TextCapitalization.words,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter driver name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               TextFormField(
//                 controller: driverPhoneController,
//                 decoration: InputDecoration(
//                   labelText: 'Driver Phone',
//                   prefixIcon: const Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//               ),
//               const SizedBox(height: 20),
//
//               // Material Details Section
//               _buildSectionTitle('Material Details'),
//               const SizedBox(height: 12),
//
//               Obx(() => DropdownButtonFormField<String>(
//                 value: selectedMaterialType.value,
//                 decoration: InputDecoration(
//                   labelText: 'Material Type *',
//                   prefixIcon: const Icon(Icons.inventory_2),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 items: ['Sand', 'Gravel', 'Stone', 'Cement', 'Brick', 'Other']
//                     .map((type) => DropdownMenuItem(
//                   value: type,
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) selectedMaterialType.value = value;
//                 },
//               )),
//               const SizedBox(height: 16),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: weightController,
//                       decoration: InputDecoration(
//                         labelText: 'Weight (Tons) *',
//                         prefixIcon: const Icon(Icons.scale),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                       onChanged: (_) => calculateTotal(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Required';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Invalid';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: rateController,
//                       decoration: InputDecoration(
//                         labelText: 'Rate (₹/Ton) *',
//                         prefixIcon: const Icon(Icons.currency_rupee),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                       onChanged: (_) => calculateTotal(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Required';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Invalid';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//
//               // Total Amount Display
//               Obx(() => Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.success.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.success),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Total Amount:',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '₹${totalAmount.value.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.success,
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//               const SizedBox(height: 20),
//
//               // Token & Remarks Section
//               _buildSectionTitle('Additional Details (Optional)'),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: tokenController,
//                 decoration: InputDecoration(
//                   labelText: 'Token Number',
//                   prefixIcon: const Icon(Icons.token),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.qr_code_scanner),
//                     onPressed: () {
//                       // Implement QR scanner
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               TextFormField(
//                 controller: remarksController,
//                 decoration: InputDecoration(
//                   labelText: 'Remarks',
//                   prefixIcon: const Icon(Icons.notes),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 24),
//
//               // Submit Button
//               Obx(() => ElevatedButton(
//                 onPressed: controller.isLoading.value
//                     ? null
//                     : () {
//                   if (formKey.currentState!.validate()) {
//                     controller.createChallan(
//                       vehicleNumber: vehicleNumberController.text.trim().toUpperCase(),
//                       vehicleType: selectedVehicleType.value,
//                       driverName: driverNameController.text.trim(),
//                       driverPhone: driverPhoneController.text.trim().isNotEmpty
//                           ? driverPhoneController.text.trim()
//                           : null,
//                       materialType: selectedMaterialType.value,
//                       weight: double.parse(weightController.text),
//                       rate: double.parse(rateController.text),
//                       tokenId: tokenController.text.trim().isNotEmpty
//                           ? tokenController.text.trim()
//                           : null,
//                       remarks: remarksController.text.trim().isNotEmpty
//                           ? remarksController.text.trim()
//                           : null,
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: controller.isLoading.value
//                     ? const SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 )
//                     : const Text(
//                   'Create Challan & Print',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//             color: AppColors.primary,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//       ],
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../controllers/challan_controller.dart';
// import '../../utilis/app_colors.dart';
//
// class CreateChallanScreen extends StatelessWidget {
//   const CreateChallanScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ChallanController());
//     final formKey = GlobalKey<FormState>();
//
//     final vehicleNumberController = TextEditingController();
//     final driverNameController = TextEditingController();
//     final driverPhoneController = TextEditingController();
//     final weightController = TextEditingController();
//     final rateController = TextEditingController();
//     final tokenController = TextEditingController();
//     final remarksController = TextEditingController();
//
//     final selectedVehicleType = 'Truck'.obs;
//     final selectedMaterialType = 'Sand'.obs;
//     final selectedTyreCount = 6.obs;
//     final totalAmount = 0.0.obs;
//
//     void calculateTotal() {
//       final weight = double.tryParse(weightController.text) ?? 0;
//       final rate = double.tryParse(rateController.text) ?? 0;
//       totalAmount.value = weight * rate;
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create New Challan'),
//         backgroundColor: AppColors.primary,
//       ),
//       body: Form(
//         key: formKey,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Header Card
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   gradient: AppColors.primaryGradient,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: const Row(
//                   children: [
//                     Icon(Icons.receipt_long, color: Colors.white, size: 32),
//                     SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'New Challan Entry',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             'Fill all details carefully',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ).animate().fadeIn().slideY(begin: -0.2),
//               const SizedBox(height: 20),
//
//               // Vehicle Details Section
//               _buildSectionTitle('Vehicle Details'),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: vehicleNumberController,
//                 decoration: InputDecoration(
//                   labelText: 'Vehicle Number *',
//                   hintText: 'e.g., GJ01AB1234',
//                   prefixIcon: const Icon(Icons.local_shipping),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 textCapitalization: TextCapitalization.characters,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter vehicle number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               Obx(() => DropdownButtonFormField<String>(
//                 value: selectedVehicleType.value,
//                 decoration: InputDecoration(
//                   labelText: 'Vehicle Type *',
//                   prefixIcon: const Icon(Icons.category),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 items: ['Truck', 'Tractor', 'Dumper', 'Trailer', 'Other']
//                     .map((type) => DropdownMenuItem(
//                   value: type,
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) {
//                     selectedVehicleType.value = value;
//                     // Reset tyre count if not truck
//                     if (value != 'Truck') {
//                       selectedTyreCount.value = 6;
//                     }
//                   }
//                 },
//               )),
//               const SizedBox(height: 16),
//
//               // Tyre Count - Only show for Truck
//               Obx(() => selectedVehicleType.value == 'Truck'
//                   ? Column(
//                 children: [
//                   DropdownButtonFormField<int>(
//                     value: selectedTyreCount.value,
//                     decoration: InputDecoration(
//                       labelText: 'Tyre Count *',
//                       prefixIcon: const Icon(Icons.tire_repair),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     items: [4, 6, 8, 10, 12, 16, 18, 20]
//                         .map((type) => DropdownMenuItem(
//                       value: type,
//                       child: Text(type.toString()),
//                     ))
//                         .toList(),
//                     onChanged: (value) {
//                       if (value != null) selectedTyreCount.value = value;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                 ],
//               )
//                   : const SizedBox.shrink()),
//
//               const SizedBox(height: 4),
//
//               // Driver Details Section
//               _buildSectionTitle('Driver Details'),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: driverNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Driver Name *',
//                   prefixIcon: const Icon(Icons.person),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 textCapitalization: TextCapitalization.words,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter driver name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//
//               TextFormField(
//                 controller: driverPhoneController,
//                 decoration: InputDecoration(
//                   labelText: 'Driver Phone',
//                   prefixIcon: const Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 keyboardType: TextInputType.phone,
//                 maxLength: 10,
//               ),
//               const SizedBox(height: 20),
//
//               // Material Details Section
//               _buildSectionTitle('Material Details'),
//               const SizedBox(height: 12),
//
//               Obx(() => DropdownButtonFormField<String>(
//                 value: selectedMaterialType.value,
//                 decoration: InputDecoration(
//                   labelText: 'Material Type *',
//                   prefixIcon: const Icon(Icons.inventory_2),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 items: ['Sand', 'Gravel', 'Stone', 'Cement', 'Brick', 'Other']
//                     .map((type) => DropdownMenuItem(
//                   value: type,
//                   child: Text(type),
//                 ))
//                     .toList(),
//                 onChanged: (value) {
//                   if (value != null) selectedMaterialType.value = value;
//                 },
//               )),
//               const SizedBox(height: 16),
//
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: weightController,
//                       decoration: InputDecoration(
//                         labelText: 'Weight (Kg) *',
//                         prefixIcon: const Icon(Icons.scale),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                       onChanged: (_) => calculateTotal(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Required';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Invalid';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: rateController,
//                       decoration: InputDecoration(
//                         labelText: 'Rate (₹/Kg) *',
//                         prefixIcon: const Icon(Icons.currency_rupee),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                       ),
//                       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                       onChanged: (_) => calculateTotal(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Required';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Invalid';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//
//               // Total Amount Display
//               Obx(() => Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.success.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.success),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Total Amount:',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       '₹${totalAmount.value.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.success,
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//               const SizedBox(height: 20),
//
//               // Token & Remarks Section
//               _buildSectionTitle('Additional Details (Optional)'),
//               const SizedBox(height: 12),
//
//               TextFormField(
//                 controller: tokenController,
//                 decoration: InputDecoration(
//                   labelText: 'Token Number',
//                   prefixIcon: const Icon(Icons.token),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.qr_code_scanner),
//                     onPressed: () {
//                       // Implement QR scanner
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               TextFormField(
//                 controller: remarksController,
//                 decoration: InputDecoration(
//                   labelText: 'Remarks',
//                   prefixIcon: const Icon(Icons.notes),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 24),
//
//               // Submit Button
//               Obx(() => ElevatedButton(
//                 onPressed: controller.isLoading.value
//                     ? null
//                     : () {
//                   if (formKey.currentState!.validate()) {
//                     controller.createChallan(
//                       vehicleNumber: vehicleNumberController.text.trim().toUpperCase(),
//                       vehicleType: selectedVehicleType.value,
//                       // tyreCount: selectedVehicleType.value == 'Truck' ? selectedTyreCount.value : null,
//                       driverName: driverNameController.text.trim(),
//                       driverPhone: driverPhoneController.text.trim().isNotEmpty
//                           ? driverPhoneController.text.trim()
//                           : null,
//                       materialType: selectedMaterialType.value,
//                       weightInKg: double.parse(weightController.text),
//                       ratePerKg: double.parse(rateController.text),
//                       tokenId: tokenController.text.trim().isNotEmpty
//                           ? tokenController.text.trim()
//                           : null,
//                       remarks: remarksController.text.trim().isNotEmpty
//                           ? remarksController.text.trim()
//                           : null, tyres: selectedTyreCount.value??4,
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: controller.isLoading.value
//                     ? const SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                   ),
//                 )
//                     : const Text(
//                   'Create Challan',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//             color: AppColors.primary,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/challan_controller.dart';
import '../../utilis/app_colors.dart';

class CreateChallanScreen extends StatelessWidget {
  const CreateChallanScreen({super.key});

  // Rate mapping based on tyre count
  Map<int, double> getTyreRates() {
    return {
      6: 7000,
      10: 11000,
      12: 12000,
      14: 14000,
      16: 15000, // OLD
      18: 15000, // OLD
      // 16: 18000, // NEW
      // 18: 18000, // NEW
      22: 18000,
    };
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallanController());
    final formKey = GlobalKey<FormState>();

    final vehicleNumberController = TextEditingController();
    final driverNameController = TextEditingController();
    final driverPhoneController = TextEditingController();
    final quantityController = TextEditingController();
    final tokenController = TextEditingController();
    final remarksController = TextEditingController();

    final selectedVehicleType = 'TRACTOR (100 CFT)'.obs;
    final selectedMaterialType = 'Sand'.obs;
    final selectedTyreCount = 6.obs;
    final isNewTyre = false.obs; // For 16 and 18 tyre distinction
    final totalAmount = 0.0.obs;

    // Vehicle types from the image
    final vehicleTypes = [
      'TRACTOR (100 CFT)',
      'MINI HAIVA (150 CFT)',
      '06 TAYER (300 CFT)',
      '10 TAYER (450 CFT)',
      '12 TAYER (600 CFT)',
      '14 TAYER (750 CFT)',
      '16 TAYER (775 CFT)',
      '18 TAYER (800 CFT)',
      '22 TAYER (850 CFT)',
    ];

    void calculateTotal() {
      final quantity = double.tryParse(quantityController.text) ?? 0;
      final tyreRates = getTyreRates();

      // Get rate based on tyre count
      double rate = tyreRates[selectedTyreCount.value] ?? 0;

      // Special handling for 16 and 18 tyre NEW rates
      if ((selectedTyreCount.value == 16 || selectedTyreCount.value == 18) && isNewTyre.value) {
        rate = 18000;
      }

      totalAmount.value = quantity * rate;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Challan'),
        backgroundColor: AppColors.primary,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New Challan Entry',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Fill all details carefully',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: -0.2),
              const SizedBox(height: 20),

              // Vehicle Details Section
              _buildSectionTitle('Vehicle Details'),
              const SizedBox(height: 12),

              TextFormField(
                controller: vehicleNumberController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Number *',
                  hintText: 'e.g., GJ01AB1234',
                  prefixIcon: const Icon(Icons.local_shipping),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter vehicle number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Obx(() => DropdownButtonFormField<String>(
                value: selectedVehicleType.value,
                decoration: InputDecoration(
                  labelText: 'Vehicle Type *',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: vehicleTypes
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedVehicleType.value = value;
                    // Auto-set tyre count based on vehicle type
                    if (value.contains('TRACTOR')) {
                      selectedTyreCount.value = 6;
                    } else if (value.contains('06')) {
                      selectedTyreCount.value = 6;
                    } else if (value.contains('10')) {
                      selectedTyreCount.value = 10;
                    } else if (value.contains('12')) {
                      selectedTyreCount.value = 12;
                    } else if (value.contains('14')) {
                      selectedTyreCount.value = 14;
                    } else if (value.contains('16')) {
                      selectedTyreCount.value = 16;
                    } else if (value.contains('18')) {
                      selectedTyreCount.value = 18;
                    } else if (value.contains('22')) {
                      selectedTyreCount.value = 22;
                    }
                    calculateTotal();
                  }
                },
              )),
              const SizedBox(height: 16),

              // Tyre Count Dropdown
              Obx(() => DropdownButtonFormField<int>(
                value: selectedTyreCount.value,
                decoration: InputDecoration(
                  labelText: 'Tyre Count *',
                  prefixIcon: const Icon(Icons.tire_repair),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: [6, 10, 12, 14, 16, 18, 22]
                    .map((count) => DropdownMenuItem(
                  value: count,
                  child: Text(count.toString()),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedTyreCount.value = value;
                    calculateTotal();
                  }
                },
              )),
              const SizedBox(height: 16),

              // New/Old Tyre Toggle (Only for 16 and 18 tyres)
              Obx(() => (selectedTyreCount.value == 16 || selectedTyreCount.value == 18)
                  ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tyre Type:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Text('OLD (₹15,000)'),
                            Switch(
                              value: isNewTyre.value,
                              onChanged: (value) {
                                isNewTyre.value = value;
                                calculateTotal();
                              },
                              activeColor: AppColors.primary,
                            ),
                            const Text('NEW (₹18,000)'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              )
                  : const SizedBox.shrink()),

              // Rate Display (Read-only)
              Obx(() {
                final tyreRates = getTyreRates();
                double rate = tyreRates[selectedTyreCount.value] ?? 0;
                if ((selectedTyreCount.value == 16 || selectedTyreCount.value == 18) && isNewTyre.value) {
                  rate = 18000;
                }

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Rate per Trip:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹${rate.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),

              // Driver Details Section
              _buildSectionTitle('Driver Details'),
              const SizedBox(height: 12),

              TextFormField(
                controller: driverNameController,
                decoration: InputDecoration(
                  labelText: 'Driver Name *',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter driver name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: driverPhoneController,
                decoration: InputDecoration(
                  labelText: 'Driver Phone',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),
              const SizedBox(height: 20),

              // Material Details Section
              _buildSectionTitle('Material Details'),
              const SizedBox(height: 12),

              Obx(() => DropdownButtonFormField<String>(
                value: selectedMaterialType.value,
                decoration: InputDecoration(
                  labelText: 'Material Type *',
                  prefixIcon: const Icon(Icons.inventory_2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['Sand', 'Gravel', 'Stone', 'Cement', 'Brick', 'Other']
                    .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) selectedMaterialType.value = value;
                },
              )),
              const SizedBox(height: 16),

              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity (Number of Trips) *',
                  hintText: 'e.g., 1000',
                  prefixIcon: const Icon(Icons.format_list_numbered),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => calculateTotal(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quantity';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Invalid quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Total Amount Display
              Obx(() => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.success, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${totalAmount.value.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 20),

              // Token & Remarks Section
              _buildSectionTitle('Additional Details (Optional)'),
              const SizedBox(height: 12),

              TextFormField(
                controller: tokenController,
                decoration: InputDecoration(
                  labelText: 'Token Number',
                  prefixIcon: const Icon(Icons.token),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.qr_code_scanner),
                    onPressed: () {
                      // Implement QR scanner
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: remarksController,
                decoration: InputDecoration(
                  labelText: 'Remarks',
                  prefixIcon: const Icon(Icons.notes),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              // Submit Button
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                  if (formKey.currentState!.validate()) {
                    final tyreRates = getTyreRates();
                    double ratePerTrip = tyreRates[selectedTyreCount.value] ?? 0;

                    if ((selectedTyreCount.value == 16 || selectedTyreCount.value == 18) && isNewTyre.value) {
                      ratePerTrip = 18000;
                    }

                    controller.createChallan(
                      vehicleNumber: vehicleNumberController.text.trim().toUpperCase(),
                      vehicleType: selectedVehicleType.value,
                      driverName: driverNameController.text.trim(),
                      driverPhone: driverPhoneController.text.trim().isNotEmpty
                          ? driverPhoneController.text.trim()
                          : null,
                      materialType: selectedMaterialType.value,
                      weightInKg: double.parse(quantityController.text), // Using as quantity
                      ratePerKg: ratePerTrip, // Using as rate per trip
                      tokenId: tokenController.text.trim().isNotEmpty
                          ? tokenController.text.trim()
                          : null,
                      remarks: remarksController.text.trim().isNotEmpty
                          ? remarksController.text.trim()
                          : null,
                      tyres: selectedTyreCount.value,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Text(
                  'Create Challan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}