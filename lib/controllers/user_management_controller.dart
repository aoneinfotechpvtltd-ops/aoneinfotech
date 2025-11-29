// // import 'package:get/get.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';
// //
// // import '../config/supabase_config.dart';
// // import '../model/user_model.dart';
// //
// // class UserManagementController extends GetxController {
// //   final supabase = Supabase.instance.client;
// //
// //   final RxList<UserModel> users = <UserModel>[].obs;
// //   final RxBool isLoading = false.obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     loadUsers();
// //   }
// //
// //   Future<void> loadUsers() async {
// //     try {
// //       isLoading.value = true;
// //
// //       final response = await supabase
// //           .from(SupabaseConfig.usersTable)
// //           .select()
// //           .order('created_at', ascending: false);
// //
// //       users.value = (response as List)
// //           .map((e) => UserModel.fromJson(e))
// //           .toList();
// //     } catch (e) {
// //       print( 'Failed to load users: ${e.toString()}');
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// //
// //   Future<void> createUser({
// //     required String email,
// //     required String fullName,
// //     required String role,
// //     String? phone,
// //   }) async {
// //     try {
// //       isLoading.value = true;
// //
// //       final response = await supabase.functions.invoke(
// //         'create-user', // function name
// //         body: {
// //           'email': email,
// //           'fullName': fullName,
// //           'role': role,
// //           'phone': phone,
// //         },
// //       );
// //
// //       // Edge function से JSON आएगा
// //       final data = response.data;
// //
// //       if (data is Map && data['error'] != null) {
// //         throw data['error'];
// //       }
// //
// //       await loadUsers();
// //
// //       Get.back();
// //       Get.snackbar('Success', 'User created successfully');
// //     } catch (e) {
// //       print('createUser error: $e');
// //       Get.snackbar('Error', 'Failed to create user: $e');
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// //
// //
// //   Future<void> updateUserStatus(String userId, String status) async {
// //     try {
// //       await supabase
// //           .from(SupabaseConfig.usersTable)
// //           .update({'status': status})
// //           .eq('id', userId);
// //
// //       await loadUsers();
// //
// //       Get.snackbar('Success', 'User status updated');
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to update status: ${e.toString()}');
// //     }
// //   }
// //
// //   Future<void> deleteUser(String userId) async {
// //     try {
// //       await supabase.auth.admin.deleteUser(userId);
// //       await loadUsers();
// //
// //       Get.snackbar('Success', 'User deleted successfully');
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to delete user: ${e.toString()}');
// //     }
// //   }
// // }
// // ============================================
// // USER MANAGEMENT CONTROLLER - UPDATED
// // ============================================
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../config/supabase_config.dart';
// import '../model/user_model.dart';
// import 'auth_controller.dart';
//
// class UserManagementController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final authController = Get.put(AuthController());
//
//   final RxList<UserModel> users = <UserModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxInt userCreationCount = 0.obs; // Track how many users an admin created
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadUsers();
//     checkUserCreationLimit();
//   }
//
//   // Check if admin has already created a user
//   Future<void> checkUserCreationLimit() async {
//     try {
//       final currentUser = authController.currentUser.value;
//       if (currentUser?.role == 'admin') {
//         final response = await supabase
//             .from(SupabaseConfig.usersTable)
//             .select()
//             .eq('created_by', currentUser!.id)
//             .eq('role', 'user');
//
//         userCreationCount.value = (response as List).length;
//       }
//     } catch (e) {
//       print('Error checking user creation limit: $e');
//     }
//   }
//
//   Future<void> loadUsers() async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       var query = supabase
//           .from(SupabaseConfig.usersTable)
//           .select();
//
//       // If admin, only show users they created
//       if (currentUser?.role == 'admin') {
//         query = query.eq('created_by', currentUser!.id);
//       }
//
//       final response = await query.order('created_at', ascending: false);
//
//       users.value = (response as List)
//           .map((e) => UserModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       print('Failed to load users: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> createUser({
//     required String email,
//     required String fullName,
//     required String role,
//     String? phone,
//   }) async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       // ADMIN RESTRICTION: Can only create 1 user
//       if (currentUser?.role == 'admin') {
//         if (userCreationCount.value >= 1) {
//           Get.snackbar(
//             'Error',
//             'Admin can only create 1 user. You have already created a user.',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             duration: const Duration(seconds: 4),
//           );
//           return;
//         }
//
//         // Admin can only create 'user' role
//         if (role != 'user') {
//           Get.snackbar(
//             'Error',
//             'Admin can only create users with "user" role',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//           return;
//         }
//       }
//
//       // SUPER ADMIN RESTRICTION: Cannot create users, only admins
//       if (currentUser?.role == 'super_admin' && role == 'user') {
//         Get.snackbar(
//           'Error',
//           'Super Admin cannot create users directly. Only admins can create users.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//         );
//         return;
//       }
//
//       final response = await supabase.functions.invoke(
//         'create-user',
//         body: {
//           'email': email,
//           'fullName': fullName,
//           'role': role,
//           'phone': phone,
//           'created_by': currentUser?.id,
//         },
//       );
//
//       final data = response.data;
//
//       if (data is Map && data['error'] != null) {
//         throw data['error'];
//       }
//
//       await loadUsers();
//       await checkUserCreationLimit();
//
//       Get.back();
//       Get.snackbar('Success', 'User created successfully');
//     } catch (e) {
//       print('createUser error: $e');
//       Get.snackbar('Error', 'Failed to create user: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> updateUserStatus(String userId, String status) async {
//     try {
//       await supabase
//           .from(SupabaseConfig.usersTable)
//           .update({'status': status})
//           .eq('id', userId);
//
//       await loadUsers();
//       Get.snackbar('Success', 'User status updated');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update status: ${e.toString()}');
//     }
//   }
//
//   Future<void> deleteUser(String userId) async {
//     try {
//       final currentUser = authController.currentUser.value;
//
//       // Get the user to check who created them
//       final userToDelete = users.firstWhere((u) => u.id == userId);
//
//       // Admin can only delete users they created
//       if (currentUser?.role == 'admin') {
//         if (userToDelete.createdBy != currentUser!.id) {
//           Get.snackbar(
//             'Error',
//             'You can only delete users you created',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//           return;
//         }
//       }
//
//       await supabase.auth.admin.deleteUser(userId);
//       await loadUsers();
//       await checkUserCreationLimit();
//
//       Get.snackbar('Success', 'User deleted successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete user: ${e.toString()}');
//     }
//   }
//
//   // Check if current user can create more users
//   bool canCreateUser() {
//     final currentUser = authController.currentUser.value;
//
//     if (currentUser?.role == 'admin') {
//       return userCreationCount.value < 1;
//     }
//
//     if (currentUser?.role == 'super_admin') {
//       return true; // Can create admins
//     }
//
//     return false;
//   }
// }
//
//
// class TokenController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final authController = Get.find<AuthController>();
//
//   final RxList<TokenModel> tokens = <TokenModel>[].obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadTokens();
//   }
//
//   Future<void> loadTokens() async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       var query = supabase.from(SupabaseConfig.tokensTable).select();
//
//       // USER: Only see their own tokens
//       if (currentUser?.role == 'user') {
//         query = query.eq('created_by', currentUser!.id);
//       }
//       // ADMIN & SUPER_ADMIN: See all tokens
//
//       final response = await query.order('created_at', ascending: false);
//
//       tokens.value = (response as List)
//           .map((e) => TokenModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load tokens: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> createToken({
//     required String tokenNumber,
//     required DateTime validFrom,
//     required DateTime validUntil,
//     String? vehicleNumber,
//     double? weightInKg,
//     String? materialType,
//   }) async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       // SUPER ADMIN RESTRICTION: Cannot create tokens
//       if (currentUser?.role == 'super_admin') {
//         Get.snackbar(
//           'Access Denied',
//           'Super Admin cannot create tokens. Only regular users can create tokens.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//           icon: const Icon(Icons.block, color: Colors.white),
//         );
//         return;
//       }
//
//       // ADMIN RESTRICTION: Cannot create tokens
//       if (currentUser?.role == 'admin') {
//         Get.snackbar(
//           'Access Denied',
//           'Admin cannot create tokens. Only regular users can create tokens.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//           icon: const Icon(Icons.block, color: Colors.white),
//         );
//         return;
//       }
//
//       // Check if token number already exists
//       final existing = await supabase
//           .from(SupabaseConfig.tokensTable)
//           .select()
//           .eq('token_number', tokenNumber)
//           .maybeSingle();
//
//       if (existing != null) {
//         Get.snackbar(
//           'Error',
//           'Token number already exists. Please use a different number.',
//           backgroundColor: Colors.orange,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       await supabase.from(SupabaseConfig.tokensTable).insert({
//         'token_number': tokenNumber,
//         'status': 'active',
//         'valid_from': validFrom.toIso8601String(),
//         'valid_until': validUntil.toIso8601String(),
//         'vehicle_number': vehicleNumber,
//         'weight_in_kg': weightInKg,
//         'material_type': materialType,
//         'created_by': currentUser?.id,
//         'created_at': DateTime.now().toIso8601String(),
//       });
//
//       await loadTokens();
//
//       Get.back();
//       Get.snackbar(
//         'Success',
//         'Token created successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         icon: const Icon(Icons.check_circle, color: Colors.white),
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create token: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> updateTokenStatus(String tokenId, String status) async {
//     try {
//       await supabase
//           .from(SupabaseConfig.tokensTable)
//           .update({'status': status})
//           .eq('id', tokenId);
//
//       await loadTokens();
//       Get.snackbar('Success', 'Token status updated');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update token: ${e.toString()}');
//     }
//   }
//
//   // Generate thermal print format for token (58mm width)
//   Future<void> printToken(TokenModel token) async {
//     try {
//       final now = DateTime.now();
//
//       // Thermal printer format (58mm paper width - approximately 32 characters)
//       final tokenData = '''
// ================================
//       TOKEN RECEIPT
// ================================
// Token No: ${token.tokenNumber}
// --------------------------------
// Vehicle: ${token.vehicleNumber ?? 'Not Assigned'}
// Material: ${token.materialType ?? 'N/A'}
// Weight: ${token.weightInKg != null ? '${token.weightInKg} Kg' : 'N/A'}
// --------------------------------
// Valid From:
// ${token.validFrom.day.toString().padLeft(2, '0')}/${token.validFrom.month.toString().padLeft(2, '0')}/${token.validFrom.year}
//
// Valid Until:
// ${token.validUntil.day.toString().padLeft(2, '0')}/${token.validUntil.month.toString().padLeft(2, '0')}/${token.validUntil.year}
// --------------------------------
// Status: ${token.status.toUpperCase()}
// --------------------------------
// Printed On:
// ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}
// ================================
//      THANK YOU
// ================================
//       ''';
//
//       // TODO: Integrate with thermal printer package
//       // For now, just showing in console and snackbar
//       print(tokenData);
//
//       Get.snackbar(
//         'Print Ready',
//         'Token ${token.tokenNumber} is ready to print',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         duration: const Duration(seconds: 3),
//         icon: const Icon(Icons.print, color: Colors.white),
//       );
//
//       // Show print preview dialog
//       Get.dialog(
//         AlertDialog(
//           title: const Text('Token Print Preview'),
//           content: SingleChildScrollView(
//             child: Text(
//               tokenData,
//               style: const TextStyle(
//                 fontFamily: 'monospace',
//                 fontSize: 12,
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Get.back(),
//               child: const Text('Close'),
//             ),
//             ElevatedButton.icon(
//               onPressed: () {
//                 // TODO: Actual thermal print implementation
//                 Get.back();
//                 Get.snackbar('Success', 'Token sent to printer');
//               },
//               icon: const Icon(Icons.print),
//               label: const Text('Print'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to print token: ${e.toString()}');
//     }
//   }
//
//   Future<void> deleteToken(String tokenId) async {
//     try {
//       final currentUser = authController.currentUser.value;
//
//       // Only SUPER_ADMIN can delete tokens
//       if (currentUser?.role != 'super_admin') {
//         Get.snackbar(
//           'Access Denied',
//           'Only Super Admin can delete tokens',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       await supabase
//           .from(SupabaseConfig.tokensTable)
//           .delete()
//           .eq('id', tokenId);
//
//       await loadTokens();
//       Get.snackbar('Success', 'Token deleted successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete token: ${e.toString()}');
//     }
//   }}
// // ============================================
// // TOKEN CONTROLLER - UPDATED
// // ============================================
// // class TokenController extends GetxController {
// //   final supabase = Supabase.instance.client;
// //   final authController = Get.find<AuthController>();
// //
// //   final RxList<TokenModel> tokens = <TokenModel>[].obs;
// //   final RxBool isLoading = false.obs;
// //
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     loadTokens();
// //   }
// //
// //   Future<void> loadTokens() async {
// //     try {
// //       isLoading.value = true;
// //
// //       final response = await supabase
// //           .from(SupabaseConfig.tokensTable)
// //           .select()
// //           .order('created_at', ascending: false);
// //
// //       tokens.value = (response as List)
// //           .map((e) => TokenModel.fromJson(e))
// //           .toList();
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to load tokens: ${e.toString()}');
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// //
// //   Future<void> createToken({
// //     required String tokenNumber,
// //     required DateTime validFrom,
// //     required DateTime validUntil,
// //     String? vehicleNumber,
// //   }) async {
// //     try {
// //       isLoading.value = true;
// //       final currentUser = authController.currentUser.value;
// //
// //       // SUPER ADMIN RESTRICTION: Cannot create tokens
// //       if (currentUser?.role == 'super_admin') {
// //         Get.snackbar(
// //           'Error',
// //           'Super Admin cannot create tokens. Only regular users can create tokens.',
// //           backgroundColor: Colors.red,
// //           colorText: Colors.white,
// //           duration: const Duration(seconds: 4),
// //         );
// //         return;
// //       }
// //
// //       await supabase.from(SupabaseConfig.tokensTable).insert({
// //         'token_number': tokenNumber,
// //         'status': 'active',
// //         'valid_from': validFrom.toIso8601String(),
// //         'valid_until': validUntil.toIso8601String(),
// //         'vehicle_number': vehicleNumber,
// //         'created_by': currentUser?.id,
// //         'created_at': DateTime.now().toIso8601String(),
// //       });
// //
// //       await loadTokens();
// //
// //       Get.back();
// //       Get.snackbar('Success', 'Token created successfully');
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to create token: ${e.toString()}');
// //     } finally {
// //       isLoading.value = false;
// //     }
// //   }
// //
// //   Future<void> updateTokenStatus(String tokenId, String status) async {
// //     try {
// //       await supabase
// //           .from(SupabaseConfig.tokensTable)
// //           .update({'status': status})
// //           .eq('id', tokenId);
// //
// //       await loadTokens();
// //       Get.snackbar('Success', 'Token status updated');
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to update token: ${e.toString()}');
// //     }
// //   }
// //
// //   // Generate thermal print format for token
// //   Future<void> printToken(TokenModel token) async {
// //     try {
// //       // This will generate thermal printer format
// //       // You'll need to integrate with a thermal printer package
// //       final tokenData = '''
// // ========================================
// //            TOKEN RECEIPT
// // ========================================
// // Token Number: ${token.tokenNumber}
// // ----------------------------------------
// // Vehicle: ${token.vehicleNumber ?? 'Not Assigned'}
// // Valid From: ${token.validFrom.day}/${token.validFrom.month}/${token.validFrom.year}
// // Valid Until: ${token.validUntil.day}/${token.validUntil.month}/${token.validUntil.year}
// // Status: ${token.status.toUpperCase()}
// // ----------------------------------------
// // Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}
// // Time: ${DateTime.now().hour}:${DateTime.now().minute}
// // ========================================
// //       ''';
// //
// //       print(tokenData); // For now, just print to console
// //
// //       Get.snackbar(
// //         'Success',
// //         'Token printed successfully',
// //         backgroundColor: Colors.green,
// //         colorText: Colors.white,
// //       );
// //     } catch (e) {
// //       Get.snackbar('Error', 'Failed to print token: ${e.toString()}');
// //     }
// //   }
// // }
// ============================================
// USER MANAGEMENT CONTROLLER - COMPLETE UPDATED
// ============================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../model/user_model.dart';
import 'auth_controller.dart';

// class UserManagementController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final authController = Get.put(AuthController());
//
//   final RxList<UserModel> users = <UserModel>[].obs;
//   final RxBool isLoading = false.obs;
//   final RxInt userCreationCount = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadUsers();
//     checkUserCreationLimit();
//   }
//
//   Future<void> checkUserCreationLimit() async {
//     try {
//       final currentUser = authController.currentUser.value;
//       if (currentUser?.role == 'admin') {
//         final response = await supabase
//             .from(SupabaseConfig.usersTable)
//             .select()
//             .eq('created_by', currentUser!.id)
//             .eq('role', 'user');
//
//         userCreationCount.value = (response as List).length;
//       }
//     } catch (e) {
//       print('Error checking user creation limit: $e');
//     }
//   }
//
//   Future<void> loadUsers() async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       var query = supabase
//           .from(SupabaseConfig.usersTable)
//           .select();
//
//       // If admin, only show users they created
//       if (currentUser?.role == 'admin') {
//         query = query.eq('created_by', currentUser!.id);
//       }
//
//       final response = await query.order('created_at', ascending: false);
//
//       users.value = (response as List)
//           .map((e) => UserModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       print('Failed to load users: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> createUser({
//     required String email,
//     required String fullName,
//     required String password,
//
//     required String role,
//     String? phone,
//     String? companyName,
//   }) async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       // ADMIN RESTRICTION: Can only create 1 user
//       if (currentUser?.role == 'admin') {
//         if (userCreationCount.value >= 1) {
//           Get.snackbar(
//             'Error',
//             'Admin can only create 1 user. You have already created a user.',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//             duration: const Duration(seconds: 4),
//           );
//           return;
//         }
//
//         // Admin can only create 'user' role
//         if (role != 'user') {
//           Get.snackbar(
//             'Error',
//             'Admin can only create users with "user" role',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//           return;
//         }
//       }
//
//       // SUPER ADMIN RESTRICTION: Cannot create users, only admins
//       if (currentUser?.role == 'super_admin' && role == 'user') {
//         Get.snackbar(
//           'Error',
//           'Super Admin cannot create users directly. Only admins can create users.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//         );
//         return;
//       }
//
//       final response = await supabase.functions.invoke(
//         'create-user',
//         body: {
//           'email': email,
//           'password': password,
//           'full_name': fullName,
//           'role': 'user',
//           'phone': phone,
//           'company_name': companyName,
//           'created_by': currentUser?.id,
//         },
//       );
//
//       final data = response.data;
//
//       if (data is Map && data['error'] != null) {
//         throw data['error'];
//       }
//
//       await loadUsers();
//       await checkUserCreationLimit();
//
//       Get.back();
//       Get.snackbar('Success', 'User created successfully');
//     } catch (e) {
//       print('createUser error: $e');
//       Get.snackbar('Error', 'Failed to create user: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // CREATE ADMIN METHOD (for Super Admin)
//   Future<void> createAdmin({
//     required String email,
//     required String password,
//     required String fullName,
//     required String phone,
//     String? companyName,
//   }) async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       // Only super_admin can create admins
//       if (currentUser?.role != 'super_admin') {
//         Get.snackbar(
//           'Access Denied',
//           'Only Super Admin can create admins',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       final response = await supabase.functions.invoke(
//         'create-user',
//         body: {
//           'email': email,
//           'password': password,
//           'full_name': fullName,
//           'role': 'admin',
//           'phone': phone,
//           'company_name': companyName,
//           'created_by': currentUser?.id,
//         },
//       );
//
//       final data = response.data;
//
//       if (data is Map && data['error'] != null) {
//         throw data['error'];
//       }
//
//       await loadUsers();
//
//       Get.back();
//       Get.snackbar(
//         'Success',
//         'Admin created successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       print('createAdmin error: $e');
//       Get.snackbar('Error', 'Failed to create admin: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> updateUserStatus(String userId, String status) async {
//     try {
//       await supabase
//           .from(SupabaseConfig.usersTable)
//           .update({'status': status})
//           .eq('id', userId);
//
//       await loadUsers();
//       Get.snackbar('Success', 'User status updated');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update status: ${e.toString()}');
//     }
//   }
//
//   Future<void> deleteUser(String userId) async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       // Get the user to check who created them
//       final userToDelete = users.firstWhere((u) => u.id == userId);
//
//       // Client-side validation (optional, server will also validate)
//       if (currentUser?.role == 'admin') {
//         if (userToDelete.createdBy != currentUser!.id) {
//           Get.snackbar(
//             'Error',
//             'You can only delete users you created',
//             backgroundColor: Colors.red,
//             colorText: Colors.white,
//           );
//           return;
//         }
//       }
//
//       // Call Edge Function instead of direct auth.admin call
//       final response = await supabase.functions.invoke(
//         'delete-user',
//         body: {
//           'userId': userId,
//           'currentUserId': currentUser?.id,
//           'currentUserRole': currentUser?.role,
//         },
//       );
//
//       final data = response.data;
//
//       if (data is Map && data['error'] != null) {
//         throw data['error'];
//       }
//
//       await loadUsers();
//       await checkUserCreationLimit();
//
//       Get.snackbar(
//         'Success',
//         'deleted successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       print('deleteUser error: $e');
//       Get.snackbar(
//         'Error',
//         'Failed to delete user: $e',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   bool canCreateUser() {
//     final currentUser = authController.currentUser.value;
//
//     if (currentUser?.role == 'admin') {
//       return userCreationCount.value < 1;
//     }
//
//     if (currentUser?.role == 'super_admin') {
//       return true;
//     }
//
//     return false;
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../model/user_model.dart';
import 'auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../model/user_model.dart';
import 'auth_controller.dart';

class UserManagementController extends GetxController {
  final supabase = Supabase.instance.client;
  final authController = Get.put(AuthController());

  final RxList<UserModel> users = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt userCreationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
    checkUserCreationLimit();
  }

  Future<void> checkUserCreationLimit() async {
    try {
      final currentUser = authController.currentUser.value;
      if (currentUser?.role == 'admin') {
        final response = await supabase
            .from(SupabaseConfig.usersTable)
            .select()
            .eq('created_by', currentUser!.id)
            .eq('role', 'user');

        userCreationCount.value = (response as List).length;
      }
    } catch (e) {
      print('Error checking user creation limit: $e');
    }
  }

  Future<void> loadUsers() async {
    try {
      isLoading.value = true;
      final currentUser = authController.currentUser.value;

      var query = supabase.from(SupabaseConfig.usersTable).select();

      if (currentUser?.role == 'admin') {
        query = query.eq('created_by', currentUser!.id);
      }

      final response = await query.order('created_at', ascending: false);

      users.value = (response as List).map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      print('Failed to load users: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // ADMIN creates USERS (max 2)
  Future<void> createUser({
    required String email,
    required String fullName,
    required String password,
    String? phone,
    String? companyName,
  }) async {
    try {
      isLoading.value = true;
      final currentUser = authController.currentUser.value;

      // ADMIN RESTRICTION: Can only create 2 users
      if (currentUser?.role == 'admin') {
        if (userCreationCount.value >= 2) {
          Get.snackbar(
            'Limit Reached',
            'Admin can only create 2 users. You have already created ${userCreationCount.value} users.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
            icon: const Icon(Icons.block, color: Colors.white),
          );
          return;
        }
      }

      // SUPER ADMIN RESTRICTION: Cannot create regular users
      if (currentUser?.role == 'super_admin') {
        Get.snackbar(
          'Access Denied',
          'Super Admin cannot create regular users. Only admins can create users.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
        );
        return;
      }

      final response = await supabase.functions.invoke(
        'create-user',
        body: {
          'email': email,
          'password': password,
          'full_name': fullName,
          'role': 'user',
          'user_type': 'user',
          'phone': phone,
          'company_name': companyName,
          'created_by': currentUser?.id,
        },
      );

      final data = response.data;

      if (data is Map && data['error'] != null) {
        throw data['error'];
      }

      await loadUsers();
      await checkUserCreationLimit();

      Get.back();
      Get.snackbar(
        'Success',
        'User created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
    } catch (e) {
      print('createUser error: $e');
      Get.snackbar('Error', 'Failed to create user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // SUPER ADMIN creates ADMINS and COMPANIES (no limit)
  Future<void> createAdminOrCompany({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String type, // 'admin' or 'company'
    String? companyName,
  }) async {
    try {
      isLoading.value = true;
      final currentUser = authController.currentUser.value;

      if (currentUser?.role != 'super_admin') {
        Get.snackbar(
          'Access Denied',
          'Only Super Admin can create admins and companies',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Validate company name for company type
      if (type == 'company' && (companyName?.trim().isEmpty ?? true)) {
        Get.snackbar(
          'Error',
          'Company name is required when creating a company',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      final response = await supabase.functions.invoke(
        'create-user',
        body: {
          'email': email,
          'password': password,
          'full_name': fullName,
          'role': 'admin',
          'user_type': 'user',
          'phone': phone,
          'company_name': companyName,
          'created_by': currentUser?.id,
        },
      );

      final data = response.data;

      if (data is Map && data['error'] != null) {
        throw data['error'];
      }

      await loadUsers();

      Get.back();
      Get.snackbar(
        'Success',
        '${type == 'admin' ? 'Admin' : 'Company'} created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('createAdminOrCompany error: $e');
      Get.snackbar('Error', 'Email already registered try new one.');
      // Get.snackbar('Error', 'Failed to create ${type}: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserStatus(String userId, String status) async {
    try {
      await supabase
          .from(SupabaseConfig.usersTable)
          .update({'status': status})
          .eq('id', userId);

      await loadUsers();
      Get.snackbar('Success', 'User status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update status: ${e.toString()}');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      isLoading.value = true;
      final currentUser = authController.currentUser.value;

      final userToDelete = users.firstWhere((u) => u.id == userId);

      // ADMIN: Can only delete users they created (role='user')
      if (currentUser?.role == 'admin') {
        if (userToDelete.createdBy != currentUser!.id) {
          Get.snackbar(
            'Error',
            'You can only delete users you created',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }

        if (userToDelete.role != 'user') {
          Get.snackbar(
            'Error',
            'Admin can only delete regular users',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
      }

      // SUPER ADMIN: Can delete admins and companies they created
      if (currentUser?.role == 'super_admin') {
        if (userToDelete.createdBy != currentUser!.id) {
          Get.snackbar(
            'Error',
            'You can only delete admins/companies you created',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return;
        }
      }

      final response = await supabase.functions.invoke(
        'delete-user',
        body: {
          'userId': userId,
          'currentUserId': currentUser?.id,
          'currentUserRole': currentUser?.role,
        },
      );

      final data = response.data;

      if (data is Map && data['error'] != null) {
        throw data['error'];
      }

      await loadUsers();
      await checkUserCreationLimit();

      Get.snackbar(
        'Success',
        'Deleted successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      print('deleteUser error: $e');
      Get.snackbar(
        'Error',
        'Failed to delete: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool canCreateUser() {
    final currentUser = authController.currentUser.value;

    if (currentUser?.role == 'admin') {
      return userCreationCount.value < 2;
    }

    return false;
  }

  bool canCreateAdminOrCompany() {
    final currentUser = authController.currentUser.value;
    return currentUser?.role == 'super_admin';
  }
}

class TokenController extends GetxController {
  final supabase = Supabase.instance.client;
  final authController = Get.find<AuthController>();

  final RxList<TokenModel> tokens = <TokenModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt nextSerialNumber = 1.obs;

  @override
  void onInit() {
    super.onInit();
    loadTokens();
    loadNextSerialNumber();
  }

  Future<void> loadTokens() async {
    try {
      isLoading.value = true;
      final currentUser = authController.currentUser.value;

      var query = supabase.from(SupabaseConfig.tokensTable).select();

      // USER: Only see their own tokens
      if (currentUser?.role == 'user') {
        query = query.eq('created_by', currentUser!.id);
      }
      // ADMIN & SUPER_ADMIN: See all tokens

      final response = await query.order('created_at', ascending: false);

      tokens.value = (response as List)
          .map((e) => TokenModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load tokens: ${e.toString()}');
      print('Load tokens error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadNextSerialNumber() async {
    try {
      final result = await supabase
          .from(SupabaseConfig.tokensTable)
          .select('serial_number')
          .order('serial_number', ascending: false)
          .limit(1)
          .maybeSingle();

      if (result != null) {
        final maxSerial = (result['serial_number'] as num?)?.toInt() ?? 0;
        nextSerialNumber.value = maxSerial + 1;
      } else {
        nextSerialNumber.value = 1;
      }
    } catch (e) {
      nextSerialNumber.value = 1;
      print('Error loading next serial number: $e');
    }
  }

  Future<String> generateTokenNumber() async {
    final now = DateTime.now();
    final dateStr = '${now.year % 100}${now.month.toString().padLeft(2, '0')}';
    final serial = nextSerialNumber.value.toString().padLeft(4, '0');
    return 'TKN$dateStr-$serial';
  }


  Future<int> generateSerialNumber() async {
    try {
      await loadNextSerialNumber();
      return nextSerialNumber.value;
    } catch (e) {
      print('Serial number generation error: $e');
      return DateTime.now().millisecondsSinceEpoch % 1000000;
    }
  }
// Updated createToken method in TokenController

  Future<void> createToken({
    required DateTime validFrom,
    required DateTime validUntil,
    required String driverName,
    required String driverMobile,
    required String vehicleNumber,
    String? vehicleType,
    int? quantity,
    String? place,
    String? materialType,
    double? weightInKg,
  }) async {
    try {
      isLoading.value = true;
      final currentUser = authController.currentUser.value;

      // SUPER ADMIN RESTRICTION: Cannot create tokens
      if (currentUser?.role == 'super_admin') {
        Get.snackbar(
          'Access Denied',
          'Super Admin cannot create tokens. Only regular users can create tokens.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 4),
          icon: const Icon(Icons.block, color: Colors.white),
        );
        return;
      }

      // ADMIN RESTRICTION: Cannot create tokens
      // if (currentUser?.role == 'admin') {
      //   Get.snackbar(
      //     'Access Denied',
      //     'Admin cannot create tokens. Only regular users can create tokens.',
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //     duration: const Duration(seconds: 4),
      //     icon: const Icon(Icons.block, color: Colors.white),
      //   );
      //   return;
      // }

      // Generate token number and serial number automatically
      final serialNumber = await generateSerialNumber();
      final tokenNumber = await generateTokenNumber();

      // Verify token doesn't already exist
      final existing = await supabase
          .from(SupabaseConfig.tokensTable)
          .select()
          .eq('token_number', tokenNumber)
          .maybeSingle();

      if (existing != null) {
        Get.snackbar(
          'Error',
          'Token already exists. Please try again.',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // Get supervisor name (username of creator)
      final supervisorName = currentUser?.fullName ?? currentUser?.email ?? 'Unknown';

      // Insert token with all fields
      await supabase.from(SupabaseConfig.tokensTable).insert({
        'token_number': tokenNumber,
        'serial_number': serialNumber,
        'print_sequence': 1,
        'status': 'active',
        'valid_from': validFrom.toIso8601String(),
        'valid_until': validUntil.toIso8601String(),

        // New fields from HTML
        'driver_name': driverName,
        'driver_mobile': driverMobile,
        'vehicle_number': vehicleNumber,
        'vehicle_type': vehicleType,
        'quantity': quantity,
        'place': place,
        'supervisor_name': supervisorName.toUpperCase(),

        // Optional fields
        'material_type': materialType,
        'weight_in_kg': weightInKg,

        // System fields
        'created_by': currentUser?.id,
        'created_at': DateTime.now().toIso8601String(),
        'print_count': 0,
      });

      await loadTokens();
      await loadNextSerialNumber();

      Get.back();
      Get.snackbar(
        'Success',
        'Token $tokenNumber created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create token: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Create token error: $e');
    } finally {
      isLoading.value = false;
    }
  }
  // Future<void> createToken({
  //   required DateTime validFrom,
  //   required DateTime validUntil,
  //   String? vehicleNumber,
  //   double? weightInKg,
  //   String? materialType,
  // }) async {
  //   try {
  //     isLoading.value = true;
  //     final currentUser = authController.currentUser.value;
  //
  //     // SUPER ADMIN RESTRICTION: Cannot create tokens
  //     if (currentUser?.role == 'super_admin') {
  //       Get.snackbar(
  //         'Access Denied',
  //         'Super Admin cannot create tokens. Only regular users can create tokens.',
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 4),
  //         icon: const Icon(Icons.block, color: Colors.white),
  //       );
  //       return;
  //     }
  //
  //     // ADMIN RESTRICTION: Cannot create tokens
  //     if (currentUser?.role == 'admin') {
  //       Get.snackbar(
  //         'Access Denied',
  //         'Admin cannot create tokens. Only regular users can create tokens.',
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 4),
  //         icon: const Icon(Icons.block, color: Colors.white),
  //       );
  //       return;
  //     }
  //
  //     // Generate token number and serial number automatically
  //     final serialNumber = await generateSerialNumber();
  //     final tokenNumber = await generateTokenNumber();
  //
  //     // Verify token doesn't already exist
  //     final existing = await supabase
  //         .from(SupabaseConfig.tokensTable)
  //         .select()
  //         .eq('token_number', tokenNumber)
  //         .maybeSingle();
  //
  //     if (existing != null) {
  //       Get.snackbar(
  //         'Error',
  //         'Token already exists. Please try again.',
  //         backgroundColor: Colors.orange,
  //         colorText: Colors.white,
  //       );
  //       return;
  //     }
  //
  //     await supabase.from(SupabaseConfig.tokensTable).insert({
  //       'token_number': tokenNumber,
  //       'serial_number': serialNumber,
  //       'print_sequence': 1,
  //       'status': 'active',
  //       'valid_from': validFrom.toIso8601String(),
  //       'valid_until': validUntil.toIso8601String(),
  //       'vehicle_number': vehicleNumber,
  //       'weight_in_kg': weightInKg,
  //       'material_type': materialType,
  //       'created_by': currentUser?.id,
  //       'created_at': DateTime.now().toIso8601String(),
  //       'print_count': 0,
  //     });
  //
  //     await loadTokens();
  //     await loadNextSerialNumber();
  //
  //     Get.back();
  //     Get.snackbar(
  //       'Success',
  //       'Token $tokenNumber created successfully',
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //       icon: const Icon(Icons.check_circle, color: Colors.white),
  //       duration: const Duration(seconds: 3),
  //     );
  //   } catch (e) {
  //     // Get.snackbar(
  //     //   'Error',
  //     //   'Failed to create token: ${e.toString()}',
  //     //   backgroundColor: Colors.red,
  //     //   colorText: Colors.white,
  //     // );
  //     print('Create token error: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> updateTokenStatus(String tokenId, String newStatus) async {
    try {
      await supabase
          .from(SupabaseConfig.tokensTable)
          .update({
        'status': newStatus,
        if (newStatus == 'used')
          'used_at': DateTime.now().toIso8601String(),
      })
          .eq('id', tokenId);

      await loadTokens();
      Get.snackbar(
        'Success',
        'Token status updated to $newStatus',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update token: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Update token status error: $e');
    }
  }

  Future<void> incrementPrintCount(String tokenId) async {
    try {
      // Get current token
      final token = tokens.firstWhereOrNull((t) => t.id == tokenId);
      if (token == null) return;

      // Increment print count
      await supabase
          .from(SupabaseConfig.tokensTable)
          .update({
        'print_count': token.printCount + 1,
        'print_sequence': token.printCount + 1,
        'last_printed_at': DateTime.now().toIso8601String(),
      })
          .eq('id', tokenId);

      await loadTokens();
    } catch (e) {
      print('Error incrementing print count: $e');
      Get.snackbar(
        'Warning',
        'Print count update failed: ${e.toString()}',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }

  Future<void> deleteToken(String tokenId) async {
    try {
      final currentUser = authController.currentUser.value;

      if (currentUser?.role != 'super_admin') {
        Get.snackbar(
          'Access Denied',
          'Only Super Admin can delete tokens',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      await supabase
          .from(SupabaseConfig.tokensTable)
          .delete()
          .eq('id', tokenId);

      await loadTokens();
      Get.snackbar(
        'Success',
        'Token deleted successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete token: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Delete token error: $e');
    }
  }

  // Get token by ID
  TokenModel? getTokenById(String id) {
    try {
      return tokens.firstWhereOrNull((token) => token.id == id);
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  // Search tokens
  List<TokenModel> searchTokens(String query) {
    if (query.isEmpty) return tokens;

    final lowerQuery = query.toLowerCase();
    return tokens
        .where((token) =>
    token.tokenNumber.toLowerCase().contains(lowerQuery) ||
        token.serialNumber.toString().contains(lowerQuery) ||
        (token.vehicleNumber?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }
}
// ============================================
// TOKEN CONTROLLER - UPDATED
// ============================================
// class TokenController extends GetxController {
//   final supabase = Supabase.instance.client;
//   final authController = Get.find<AuthController>();
//
//   final RxList<TokenModel> tokens = <TokenModel>[].obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadTokens();
//   }
//
//   Future<void> loadTokens() async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       var query = supabase.from(SupabaseConfig.tokensTable).select();
//
//       // USER: Only see their own tokens
//       if (currentUser?.role == 'user') {
//         query = query.eq('created_by', currentUser!.id);
//       }
//       // ADMIN & SUPER_ADMIN: See all tokens
//
//       final response = await query.order('created_at', ascending: false);
//
//       tokens.value = (response as List)
//           .map((e) => TokenModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load tokens: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> createToken({
//     required String tokenNumber,
//     required DateTime validFrom,
//     required DateTime validUntil,
//     String? vehicleNumber,
//     double? weightInKg,
//     String? materialType,
//   }) async {
//     try {
//       isLoading.value = true;
//       final currentUser = authController.currentUser.value;
//
//       // SUPER ADMIN RESTRICTION: Cannot create tokens
//       if (currentUser?.role == 'super_admin') {
//         Get.snackbar(
//           'Access Denied',
//           'Super Admin cannot create tokens. Only regular users can create tokens.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//           icon: const Icon(Icons.block, color: Colors.white),
//         );
//         return;
//       }
//
//       // ADMIN RESTRICTION: Cannot create tokens
//       if (currentUser?.role == 'admin') {
//         Get.snackbar(
//           'Access Denied',
//           'Admin cannot create tokens. Only regular users can create tokens.',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//           duration: const Duration(seconds: 4),
//           icon: const Icon(Icons.block, color: Colors.white),
//         );
//         return;
//       }
//
//       // Check if token number already exists
//       final existing = await supabase
//           .from(SupabaseConfig.tokensTable)
//           .select()
//           .eq('token_number', tokenNumber)
//           .maybeSingle();
//
//       if (existing != null) {
//         Get.snackbar(
//           'Error',
//           'Token number already exists. Please use a different number.',
//           backgroundColor: Colors.orange,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       await supabase.from(SupabaseConfig.tokensTable).insert({
//         'token_number': tokenNumber,
//         'status': 'active',
//         'valid_from': validFrom.toIso8601String(),
//         'valid_until': validUntil.toIso8601String(),
//         'vehicle_number': vehicleNumber,
//         'weight_in_kg': weightInKg,
//         'material_type': materialType,
//         'created_by': currentUser?.id,
//         'created_at': DateTime.now().toIso8601String(),
//       });
//
//       await loadTokens();
//
//       Get.back();
//       Get.snackbar(
//         'Success',
//         'Token created successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//         icon: const Icon(Icons.check_circle, color: Colors.white),
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create token: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> updateTokenStatus(String tokenId, String status) async {
//     try {
//       await supabase
//           .from(SupabaseConfig.tokensTable)
//           .update({'status': status})
//           .eq('id', tokenId);
//
//       await loadTokens();
//       Get.snackbar('Success', 'Token status updated');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update token: ${e.toString()}');
//     }
//   }
//
//
//   Future<void> deleteToken(String tokenId) async {
//     try {
//       final currentUser = authController.currentUser.value;
//
//       if (currentUser?.role != 'super_admin') {
//         Get.snackbar(
//           'Access Denied',
//           'Only Super Admin can delete tokens',
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         return;
//       }
//
//       await supabase
//           .from(SupabaseConfig.tokensTable)
//           .delete()
//           .eq('id', tokenId);
//
//       await loadTokens();
//       Get.snackbar('Success', 'Token deleted successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to delete token: ${e.toString()}');
//     }
//   }
// }

// ============================================
// USER MODEL - UPDATED
// ============================================
// class UserModel {
//   final String id;
//   final String email;
//   final String fullName;
//   final String role;
//   final String status;
//   final String? phone;
//   final String? companyName;
//   final String? createdBy;
//   final DateTime createdAt;
//   final DateTime? lastLogin;
//   final Map<String, dynamic>? deviceInfo;
//   final String? ipAddress;
//
//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fullName,
//     required this.role,
//     required this.status,
//     this.phone,
//     this.companyName,
//     this.createdBy,
//     required this.createdAt,
//     this.lastLogin,
//     this.deviceInfo,
//     this.ipAddress,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] as String,
//       email: json['email'] as String,
//       fullName: json['full_name'] as String,
//       role: json['role'] as String,
//       status: json['status'] as String,
//       phone: json['phone'] as String?,
//       companyName: json['company_name'] as String?,
//       createdBy: json['created_by'] as String?,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       lastLogin: json['last_login'] != null
//           ? DateTime.parse(json['last_login'] as String)
//           : null,
//       deviceInfo: json['device_info'] as Map<String, dynamic>?,
//       ipAddress: json['ip_address'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'full_name': fullName,
//       'role': role,
//       'status': status,
//       'phone': phone,
//       'company_name': companyName,
//       'created_by': createdBy,
//       'created_at': createdAt.toIso8601String(),
//       'last_login': lastLogin?.toIso8601String(),
//       'device_info': deviceInfo,
//       'ip_address': ipAddress,
//     };
//   }
//
//   bool get isSuperAdmin => role == 'super_admin';
//   bool get isAdmin => role == 'admin';
//   bool get isUser => role == 'user';
//   bool get isViewer => role == 'viewer';
//   bool get isActive => status == 'active';
//   bool get isBlocked => status == 'blocked';
// }
//
// // ============================================
// // TOKEN MODEL - UPDATED
// // ============================================
// class TokenModel {
//   final String id;
//   final String tokenNumber;
//   final String status;
//   final DateTime validFrom;
//   final DateTime validUntil;
//   final String? vehicleNumber;
//   final double? weightInKg;
//   final String? materialType;
//   final String? createdBy;
//   final DateTime createdAt;
//   final DateTime? usedAt;
//   final String? usedBy;
//
//   TokenModel({
//     required this.id,
//     required this.tokenNumber,
//     required this.status,
//     required this.validFrom,
//     required this.validUntil,
//     this.vehicleNumber,
//     this.weightInKg,
//     this.materialType,
//     this.createdBy,
//     required this.createdAt,
//     this.usedAt,
//     this.usedBy,
//   });
//
//   factory TokenModel.fromJson(Map<String, dynamic> json) {
//     return TokenModel(
//       id: json['id'] as String,
//       tokenNumber: json['token_number'] as String,
//       status: json['status'] as String,
//       validFrom: DateTime.parse(json['valid_from'] as String),
//       validUntil: DateTime.parse(json['valid_until'] as String),
//       vehicleNumber: json['vehicle_number'] as String?,
//       weightInKg: json['weight_in_kg'] != null
//           ? (json['weight_in_kg'] as num).toDouble()
//           : null,
//       materialType: json['material_type'] as String?,
//       createdBy: json['created_by'] as String?,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       usedAt: json['used_at'] != null
//           ? DateTime.parse(json['used_at'] as String)
//           : null,
//       usedBy: json['used_by'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'token_number': tokenNumber,
//       'status': status,
//       'valid_from': validFrom.toIso8601String(),
//       'valid_until': validUntil.toIso8601String(),
//       'vehicle_number': vehicleNumber,
//       'weight_in_kg': weightInKg,
//       'material_type': materialType,
//       'created_by': createdBy,
//       'created_at': createdAt.toIso8601String(),
//       'used_at': usedAt?.toIso8601String(),
//       'used_by': usedBy,
//     };
//   }
//
//   bool get isValid {
//     final now = DateTime.now();
//     return status == 'active' &&
//         now.isAfter(validFrom) &&
//         now.isBefore(validUntil);
//   }
//
//   bool get isExpired {
//     final now = DateTime.now();
//     return status == 'expired' || now.isAfter(validUntil);
//   }
//
//   bool get isUsed => status == 'used';
//
//   String get statusDisplay {
//     if (isUsed) return 'Used';
//     if (isExpired) return 'Expired';
//     if (isValid) return 'Active';
//     return 'Inactive';
//   }
// }