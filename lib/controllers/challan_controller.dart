// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
// import '../model/user_model.dart';
// import '../config/supabase_config.dart';
// import 'auth_controller.dart';
//
// class ChallanController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final authController = Get.find<AuthController>();
//
//   final RxList<ChallanModel> challans = <ChallanModel>[].obs;
//   final RxList<ReprintRequestModel> reprintRequests = <ReprintRequestModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final Rx<ChallanModel?> selectedChallan = Rx<ChallanModel?>(null);
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadChallans();
//   }
//
//   Future<void> loadChallans() async {
//     try {
//       isLoading.value = true;
//
//       final response = await supabase
//           .from(SupabaseConfig.challansTable)
//           .select()
//           .order('created_at', ascending: false)
//           .limit(100);
//
//       challans.value = (response as List)
//           .map((e) => ChallanModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load challans: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<bool> canCreateChallan(String vehicleNumber) async {
//     try {
//       // Check if vehicle had challan in last 6 hours
//       final sixHoursAgo = DateTime.now().subtract(const Duration(hours: 6));
//
//       final response = await supabase
//           .from(SupabaseConfig.challansTable)
//           .select()
//           .eq('vehicle_number', vehicleNumber)
//           .gte('created_at', sixHoursAgo.toIso8601String())
//           .order('created_at', ascending: false)
//           .limit(1);
//
//       if (response.isEmpty) return true;
//
//       final lastChallan = ChallanModel.fromJson(response.first);
//       final timeDiff = DateTime.now().difference(lastChallan.createdAt);
//
//       if (timeDiff.inHours < 6) {
//         Get.snackbar(
//           'Warning',
//           'This vehicle had a challan ${timeDiff.inHours} hours ago. Please wait ${6 - timeDiff.inHours} more hours.',
//           backgroundColor: Colors.orange,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 5),
//         );
//         return false;
//       }
//
//       return true;
//     } catch (e) {
//       print('Error checking challan eligibility: $e');
//       return true;
//     }
//   }
//
//   Future<String> generateChallanNumber() async {
//     final now = DateTime.now();
//     final prefix = 'CH${now.year}${now.month.toString().padLeft(2, '0')}';
//
//     // Get today's challan count
//     final todayStart = DateTime(now.year, now.month, now.day);
//     final response = await supabase
//         .from(SupabaseConfig.challansTable)
//         .select()
//         .gte('created_at', todayStart.toIso8601String())
//         .count();
//
//     final count = (response.count ?? 0) + 1;
//     return '$prefix${count.toString().padLeft(5, '0')}';
//   }
//
//   String generateQRCode(Map<String, dynamic> challanData) {
//     final jsonString = json.encode(challanData);
//     final bytes = utf8.encode(jsonString);
//     final hash = sha256.convert(bytes);
//     return hash.toString();
//   }
//
//   Future<void> createChallan({
//     required String vehicleNumber,
//     required String vehicleType,
//     required String driverName,
//     String? driverPhone,
//     required String materialType,
//     required double weight,
//     required double rate,
//     String? tokenId,
//     String? remarks,
//   }) async {
//     try {
//       isLoading.value = true;
//
//       // Check 6-hour rule
//       final canCreate = await canCreateChallan(vehicleNumber);
//       if (!canCreate) return;
//
//       // Validate token if provided
//       if (tokenId != null) {
//         final tokenValid = await _validateToken(tokenId, vehicleNumber);
//         if (!tokenValid) {
//           Get.snackbar(
//             'Error',
//             'Invalid or expired token',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//           return;
//         }
//       }
//
//       final totalAmount = weight * rate;
//       final challanNumber = await generateChallanNumber();
//
//       final challanData = {
//         'challan_number': challanNumber,
//         'vehicle_number': vehicleNumber.toUpperCase(),
//         'vehicle_type': vehicleType,
//         'driver_name': driverName,
//         'driver_phone': driverPhone,
//         'material_type': materialType,
//         'weight': weight,
//         'rate': rate,
//         'total_amount': totalAmount,
//         'token_id': tokenId,
//         'created_by': authController.currentUser.value!.id,
//         'created_at': DateTime.now().toIso8601String(),
//         'print_count': 0,
//         'status': 'active',
//         'remarks': remarks,
//       };
//
//       final qrCode = generateQRCode(challanData);
//       challanData['qr_code'] = qrCode;
//
//       // Insert challan
//       final response = await supabase
//           .from(SupabaseConfig.challansTable)
//           .insert(challanData)
//           .select()
//           .single();
//
//       final newChallan = ChallanModel.fromJson(response);
//
//       // Update vehicle record
//       await _updateVehicleRecord(vehicleNumber, vehicleType);
//
//       // Mark token as used
//       if (tokenId != null) {
//         await _markTokenAsUsed(tokenId);
//       }
//
//       // Log activity
//       await _logActivity('create_challan', 'challan', newChallan.id);
//
//       challans.insert(0, newChallan);
//
//       Get.back();
//       Get.snackbar(
//         'Success',
//         'Challan created successfully: $challanNumber',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//
//       // Navigate to print screen
//       selectedChallan.value = newChallan;
//       await printChallan(newChallan.id);
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Failed to create challan: ${e.toString()}',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<bool> _validateToken(String tokenId, String vehicleNumber) async {
//     try {
//       final response = await supabase
//           .from(SupabaseConfig.tokensTable)
//           .select()
//           .eq('id', tokenId)
//           .single();
//
//       final token = TokenModel.fromJson(response);
//
//       if (!token.isValid) return false;
//       if (token.vehicleNumber != null && token.vehicleNumber != vehicleNumber) {
//         return false;
//       }
//
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Future<void> _markTokenAsUsed(String tokenId) async {
//     try {
//       await supabase.from(SupabaseConfig.tokensTable).update({
//         'status': 'used',
//         'used_at': DateTime.now().toIso8601String(),
//         'used_by': authController.currentUser.value!.id,
//       }).eq('id', tokenId);
//     } catch (e) {
//       print('Error marking token as used: $e');
//     }
//   }
//
//   Future<void> _updateVehicleRecord(String vehicleNumber, String vehicleType) async {
//     try {
//       final existing = await supabase
//           .from(SupabaseConfig.vehiclesTable)
//           .select()
//           .eq('vehicle_number', vehicleNumber)
//           .maybeSingle();
//
//       if (existing == null) {
//         await supabase.from(SupabaseConfig.vehiclesTable).insert({
//           'vehicle_number': vehicleNumber,
//           'vehicle_type': vehicleType,
//           'last_challan_at': DateTime.now().toIso8601String(),
//           'total_challans': 1,
//         });
//       } else {
//         await supabase.from(SupabaseConfig.vehiclesTable).update({
//           'last_challan_at': DateTime.now().toIso8601String(),
//           'total_challans': (existing['total_challans'] as int) + 1,
//         }).eq('vehicle_number', vehicleNumber);
//       }
//     } catch (e) {
//       print('Error updating vehicle record: $e');
//     }
//   }
//
//   Future<void> printChallan(String challanId) async {
//     try {
//       final challan = challans.firstWhere((c) => c.id == challanId);
//
//       if (challan.printCount > 0) {
//         Get.snackbar(
//           'Warning',
//           'Duplicate printing blocked. Request reprint if needed.',
//           backgroundColor: Colors.orange,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       // Update print count
//       await supabase.from(SupabaseConfig.challansTable).update({
//         'print_count': challan.printCount + 1,
//         'last_printed_at': DateTime.now().toIso8601String(),
//       }).eq('id', challanId);
//
//       // Generate and print PDF
//       // Implementation with pdf package
//       Get.snackbar(
//         'Success',
//         'Challan printed successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//
//       await loadChallans();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to print: ${e.toString()}');
//     }
//   }
//
//   Future<void> requestReprint(String challanId, String reason) async {
//     try {
//       isLoading.value = true;
//
//       await supabase.from(SupabaseConfig.reprintRequestsTable).insert({
//         'challan_id': challanId,
//         'requested_by': authController.currentUser.value!.id,
//         'requested_at': DateTime.now().toIso8601String(),
//         'reason': reason,
//         'status': 'pending',
//       });
//
//       await _logActivity('request_reprint', 'challan', challanId);
//
//       Get.back();
//       Get.snackbar(
//         'Success',
//         'Reprint request submitted',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to request reprint: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> loadReprintRequests() async {
//     try {
//       isLoading.value = true;
//
//       final response = await supabase
//           .from(SupabaseConfig.reprintRequestsTable)
//           .select()
//           .order('requested_at', ascending: false);
//
//       reprintRequests.value = (response as List)
//           .map((e) => ReprintRequestModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load reprint requests: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> approveReprintRequest(String requestId, String? notes) async {
//     try {
//       isLoading.value = true;
//
//       await supabase.from(SupabaseConfig.reprintRequestsTable).update({
//         'status': 'approved',
//         'reviewed_by': authController.currentUser.value!.id,
//         'reviewed_at': DateTime.now().toIso8601String(),
//         'review_notes': notes,
//       }).eq('id', requestId);
//
//       await loadReprintRequests();
//
//       Get.snackbar(
//         'Success',
//         'Reprint request approved',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to approve: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> _logActivity(String action, String entityType, String entityId) async {
//     try {
//       await supabase.from(SupabaseConfig.activityLogsTable).insert({
//         'user_id': authController.currentUser.value!.id,
//         'action': action,
//         'entity_type': entityType,
//         'entity_id': entityId,
//         'created_at': DateTime.now().toIso8601String(),
//       });
//     } catch (e) {
//       print('Error logging activity: $e');
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../config/print_pdf.dart';
import '../model/user_model.dart';
import '../config/supabase_config.dart';
import 'auth_controller.dart';

class ChallanController extends GetxController {
  final supabase = Supabase.instance.client;
  final authController = Get.find<AuthController>();

  final RxList<ChallanModel> challans = <ChallanModel>[].obs;
  final RxList<ReprintRequestModel> reprintRequests = <ReprintRequestModel>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<ChallanModel?> selectedChallan = Rx<ChallanModel?>(null);

  // Vehicle types with more options
  final List<String> vehicleTypes = [
    'Truck - 6 Wheeler',
    'Truck - 10 Wheeler',
    'Truck - 12 Wheeler',
    'Truck - 14 Wheeler',
    'Truck - 16 Wheeler',
    'Truck - 18 Wheeler',
    'Truck - 22 Wheeler',
    'Trailer',
    'Container',
    'Pickup',
    'Mini Truck',
    'Tempo',
    'Other',
  ];

  @override
  void onInit() {
    super.onInit();
    loadChallans();
  }

  Future<void> loadChallans() async {
    try {
      isLoading.value = true;

      final response = await supabase
          .from(SupabaseConfig.challansTable)
          .select()
          .order('created_at', ascending: false)
          .limit(100);

      challans.value = (response as List)
          .map((e) => ChallanModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load challans: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Check 6-hour restriction for vehicle
  Future<bool> canCreateChallan(String vehicleNumber) async {
    try {
      final sixHoursAgo = DateTime.now().subtract(const Duration(hours: 6));

      final response = await supabase
          .from(SupabaseConfig.challansTable)
          .select()
          .eq('vehicle_number', vehicleNumber.toUpperCase())
          .gte('created_at', sixHoursAgo.toIso8601String())
          .order('created_at', ascending: false)
          .limit(1);

      if (response.isEmpty) return true;

      final lastChallan = ChallanModel.fromJson(response.first);
      final timeDiff = DateTime.now().difference(lastChallan.createdAt);
      final hoursRemaining = 6 - timeDiff.inHours;
      final minutesRemaining = 60 - timeDiff.inMinutes % 60;

      if (timeDiff.inHours < 6) {
        Get.dialog(
          AlertDialog(
            title: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
                SizedBox(width: 12),
                Text('Vehicle Restriction'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This vehicle had a challan:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 12),
                _buildInfoRow('Last Challan', '${timeDiff.inHours}h ${timeDiff.inMinutes % 60}m ago'),
                _buildInfoRow('Wait Time', '$hoursRemaining hours $minutesRemaining minutes'),
                _buildInfoRow('Vehicle', vehicleNumber.toUpperCase()),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'A vehicle can only have one challan per 6 hours',
                          style: TextStyle(fontSize: 12, color: Colors.orange[900]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('OK'),
              ),
            ],
          ),
          barrierDismissible: false,
        );
        return false;
      }

      return true;
    } catch (e) {
      print('Error checking challan eligibility: $e');
      return true;
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label + ':',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Future<String> generateChallanNumber() async {
    final now = DateTime.now();
    final prefix = 'CH${now.year}${now.month.toString().padLeft(2, '0')}';

    final todayStart = DateTime(now.year, now.month, now.day);
    final response = await supabase
        .from(SupabaseConfig.challansTable)
        .select()
        .gte('created_at', todayStart.toIso8601String())
        .count();

    final count = (response.count ?? 0) + 1;
    return '$prefix${count.toString().padLeft(5, '0')}';
  }

  String generateQRCode(Map<String, dynamic> challanData) {
    final jsonString = json.encode(challanData);
    final bytes = utf8.encode(jsonString);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  Future<void> createChallan({
    required String vehicleNumber,
    required String vehicleType,
    required String driverName,
    String? driverPhone,
    required String materialType,
    required double weightInKg, // Changed to KG
    required double ratePerKg,
    required int tyres,
    String? tokenId,
    String? remarks,
  }) async {
    try {
      isLoading.value = true;

      // Check 6-hour restriction
      final canCreate = await canCreateChallan(vehicleNumber);
      if (!canCreate) {
        isLoading.value = false;
        return;
      }

      // Validate token if provided
      String? resolvedTokenId;
      if (tokenId != null && tokenId.isNotEmpty) {
        final tokenResponse = await supabase
            .from(SupabaseConfig.tokensTable)
            .select('id, token_number, status, valid_until, vehicle_number')
            .eq('token_number', tokenId)
            .maybeSingle();

        if (tokenResponse == null) {
          Get.snackbar(
            'Error',
            'Token not found',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
          return;
        }

        // Additional validation: expired?
        if (DateTime.parse(tokenResponse['valid_until']).isBefore(DateTime.now())) {
          Get.snackbar(
            'Error',
            'Token has expired',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
          return;
        }

        // Vehicle mismatch check
        if (tokenResponse['vehicle_number'] != vehicleNumber.toUpperCase()) {
          Get.snackbar(
            'Error',
            'Token does not belong to this vehicle',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          isLoading.value = false;
          return;
        }

        // Token UUID to save
        resolvedTokenId = tokenResponse['id'];
      }
      final totalAmount = weightInKg * ratePerKg;
      final challanNumber = await generateChallanNumber();

      final challanData = {
        // 'challan_number': challanNumber,
        'vehicle_number': vehicleNumber.toUpperCase(),
        'vehicle_type': vehicleType,
        'driver_name': driverName,
        'driver_phone': driverPhone,
        'material_type': materialType,
        'weight_kg': weightInKg, // Store in KG
        'weight': weightInKg, // Store in KG
        'rate_per_kg': ratePerKg,
        'rate': ratePerKg,
        'tyres': tyres,
        'total_amount': totalAmount,
        'token_id': resolvedTokenId,
        'created_by': authController.currentUser.value!.id,
        'created_at': DateTime.now().toIso8601String(),
        'print_count': 0,
        'status': 'active',
        'remarks': remarks,
      };

      final qrCode = generateQRCode(challanData);
      challanData['qr_code'] = qrCode;

      final response = await supabase
          .from(SupabaseConfig.challansTable)
          .insert(challanData)
          .select()
          .single();

      final newChallan = ChallanModel.fromJson(response);

      await _updateVehicleRecord(vehicleNumber, vehicleType);

      if (tokenId != null) {
        await _markTokenAsUsed(tokenId);
      }

      await _logActivity('create_challan', 'challan', newChallan.id);

      challans.insert(0, newChallan);

      Get.back();
      Get.snackbar(
        'Success',
        'Challan created successfully: $challanNumber',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      selectedChallan.value = newChallan;
      // await printChallan(newChallan.id);
    } catch (e) {
      print('tokk${e.toString()}');
      Get.snackbar(
        'Error',
        'Failed to create challan: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<bool> _validateToken(String tokenId, String vehicleNumber) async {
  //   try {
  //     final response = await supabase
  //         .from(SupabaseConfig.tokensTable)
  //         .select()
  //         .eq('token_number', tokenId)
  //         .maybeSingle(); // 🔥 FIX: no error if not found
  //
  //     if (response == null) {
  //       return false; // token does not exist
  //     }
  //
  //     final token = TokenModel.fromJson(response);
  //
  //     final now = DateTime.now();
  //
  //     // 1️⃣ Check status
  //     if (token.status != 'active') {
  //       return false;
  //     }
  //
  //     // 2️⃣ Check date validity
  //     if (now.isBefore(token.validFrom) || now.isAfter(token.validUntil)) {
  //       return false;
  //     }
  //
  //     // 3️⃣ Vehicle match (only if token has vehicle assigned)
  //     if (token.vehicleNumber != null &&
  //         token.vehicleNumber!.isNotEmpty
  //         ) {
  //       return false;
  //     }
  //
  //     return true;
  //   } catch (e) {
  //     print("Token validation error: $e");
  //     return false;
  //   }
  // }
  Future<bool> _validateToken(String tokenId, String vehicleNumber) async {
    try {
      // fetch but don't throw if missing
      final response = await supabase
          .from(SupabaseConfig.tokensTable)
          .select()
          .eq('token_number', tokenId)
          .maybeSingle();

      // Debug: print raw response (helpful to inspect shape)
      print('[validateToken] raw response: $response');

      if (response == null) {
        print('[validateToken] token not found for $tokenId');
        return false;
      }

      // Normalize map keys to lower_case for tolerant lookup
      final Map<String, dynamic> row = Map<String, dynamic>.from(response);
      String? status = (row['status'] ?? row['Status'] ?? row['token_status'] ?? '')
          .toString()
          .trim()
          .toLowerCase();

      // Try multiple key names for validity timestamps
      String? validFromStr =
      (row['valid_from'] ?? row['validFrom'] ?? row['validfrom'])?.toString();
      String? validUntilStr =
      (row['valid_until'] ?? row['validUntil'] ?? row['validuntil'])?.toString();

      // vehicle number keys
      String? tokenVehicleNumber =
      (row['vehicle_number'] ?? row['vehicleNumber'] ?? row['vehicle'])?.toString();

      // If DB stores used/expired values in other capitalization or with spaces
      if (status.isEmpty) {
        print('[validateToken] status missing in row, raw status keys: ${row.keys}');
        return false;
      }

      // 1) status must be active (be tolerant to capitalization/whitespace)
      if (status != 'active') {
        print('[validateToken] token status is not active: "$status"');
        return false;
      }

      // 2) parse dates (be tolerant)
      DateTime now = DateTime.now().toUtc();

      DateTime? validFrom;
      DateTime? validUntil;

      try {
        if (validFromStr != null) validFrom = DateTime.parse(validFromStr).toUtc();
      } catch (e) {
        print('[validateToken] failed parsing valid_from="$validFromStr": $e');
      }

      try {
        if (validUntilStr != null) validUntil = DateTime.parse(validUntilStr).toUtc();
      } catch (e) {
        print('[validateToken] failed parsing valid_until="$validUntilStr": $e');
      }

      // if (validFrom != null && now.isBefore(validFrom)) {
      //   print('[validateToken] token not yet valid. now=$now, valid_from=$validFrom');
      //   return false;
      // }

      if (validUntil != null && now.isAfter(validUntil)) {
        print('[validateToken] token expired. now=$now, valid_until=$validUntil');
        return false;
      }

      // 3) vehicle match only if token has vehicle assigned (non-empty)
      if (tokenVehicleNumber != null && tokenVehicleNumber.trim().isNotEmpty) {
        if (tokenVehicleNumber.trim().toUpperCase() != vehicleNumber.trim().toUpperCase()) {
          print('[validateToken] vehicle mismatch: token="${tokenVehicleNumber.trim()}", provided="${vehicleNumber.trim()}"');
          return false;
        }
      }

      // 4) optionally check used flag or used_at column
      final usedAt = row['used_at'] ?? row['usedAt'];
      if (usedAt != null) {
        print('[validateToken] token already used at: $usedAt');
        return false;
      }

      // If you have a 'status' like 'used' in DB but also a used_at, previous checks cover it.

      // If everything passes:
      print('[validateToken] token "$tokenId" is valid for vehicle "$vehicleNumber"');
      return true;
    } catch (e) {
      print('[validateToken] unexpected error: $e');
      return false;
    }
  }

  Future<void> _markTokenAsUsed(String tokenId) async {
    try {
      await supabase.from(SupabaseConfig.tokensTable).update({
        'status': 'used',
        'used_at': DateTime.now().toIso8601String(),
        'used_by': authController.currentUser.value!.id,
      }).eq('id', tokenId);
    } catch (e) {
      print('Error marking token as used: $e');
    }
  }

  Future<void> _updateVehicleRecord(String vehicleNumber, String vehicleType) async {
    try {
      final existing = await supabase
          .from(SupabaseConfig.vehiclesTable)
          .select()
          .eq('vehicle_number', vehicleNumber.toUpperCase())
          .maybeSingle();

      if (existing == null) {
        await supabase.from(SupabaseConfig.vehiclesTable).insert({
          'vehicle_number': vehicleNumber.toUpperCase(),
          'vehicle_type': vehicleType,
          'last_challan_at': DateTime.now().toIso8601String(),
          'total_challans': 1,
        });
      } else {
        await supabase.from(SupabaseConfig.vehiclesTable).update({
          'last_challan_at': DateTime.now().toIso8601String(),
          'total_challans': (existing['total_challans'] as int) + 1,
          'vehicle_type': vehicleType,
        }).eq('vehicle_number', vehicleNumber.toUpperCase());
      }
    } catch (e) {
      print('Error updating vehicle record: $e');
    }
  }

  Future<void> printChallan(String challanId) async {
    try {
      final challan = challans.firstWhere((c) => c.id == challanId);

      if (challan.printCount > 0) {
        Get.snackbar(
          'Warning',
          'Duplicate printing blocked. Request reprint if needed.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      await supabase.from(SupabaseConfig.challansTable).update({
        'print_count': challan.printCount + 1,
        'last_printed_at': DateTime.now().toIso8601String(),
      }).eq('id', challanId);

      // Thermal print format
      final printData = generateChallanPDF(challan);
      print(printData); // Integrate with thermal printer library

      Get.snackbar(
        'Success',
        'Challan printed successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await loadChallans();
    } catch (e) {
      Get.snackbar('Error', 'Failed to print: ${e.toString()}');
    }
  }


  Future<void> requestReprint(String challanId, String reason) async {
    try {
      isLoading.value = true;

      await supabase.from(SupabaseConfig.reprintRequestsTable).insert({
        'challan_id': challanId,
        'requested_by': authController.currentUser.value!.id,
        'requested_at': DateTime.now().toIso8601String(),
        'reason': reason,
        'status': 'pending',
      });

      await _logActivity('request_reprint', 'challan', challanId);

      Get.back();
      Get.snackbar(
        'Success',
        'Reprint request submitted',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to request reprint: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadReprintRequests() async {
    try {
      isLoading.value = true;

      final response = await supabase
          .from(SupabaseConfig.reprintRequestsTable)
          .select()
          .order('requested_at', ascending: false);

      reprintRequests.value = (response as List)
          .map((e) => ReprintRequestModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load reprint requests: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> approveReprintRequest(String requestId, String? notes) async {
    try {
      isLoading.value = true;

      await supabase.from(SupabaseConfig.reprintRequestsTable).update({
        'status': 'approved',
        'reviewed_by': authController.currentUser.value!.id,
        'reviewed_at': DateTime.now().toIso8601String(),
        'review_notes': notes,
      }).eq('id', requestId);

      await loadReprintRequests();

      Get.snackbar(
        'Success',
        'Reprint request approved',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to approve: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _logActivity(String action, String entityType, String entityId) async {
    try {
      await supabase.from(SupabaseConfig.activityLogsTable).insert({
        'user_id': authController.currentUser.value!.id,
        'action': action,
        'entity_type': entityType,
        'entity_id': entityId,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error logging activity: $e');
    }
  }
}