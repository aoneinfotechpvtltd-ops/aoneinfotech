import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import '../config/supabase_config.dart';
import '../model/user_model.dart';
import '../routes/app_route.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;

  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthState();
  }

  Future<void> checkAuthState() async {
    try {
      final session = supabase.auth.currentSession;
      if (session != null) {
        await loadUserData();
      }
    } catch (e) {
      print('Error checking auth state: $e');
    }
  }

  Future<void> loadUserData() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response = await supabase
          .from(SupabaseConfig.usersTable)
          .select()
          .eq('id', userId)
          .single();

      currentUser.value = UserModel.fromJson(response);
      isLoggedIn.value = true;
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      // Sign in with Supabase Auth
      final authResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw 'Login failed';
      }

      // Load user profile
      await loadUserData();

      // Update last login
      await supabase
          .from(SupabaseConfig.usersTable)
          .update({
        'last_login': DateTime.now().toIso8601String(),
      })
          .eq('id', authResponse.user!.id);

      // Log activity
      await _logActivity('login', 'user', authResponse.user!.id);

      // Navigate based on role
      _navigateBasedOnRole();

      Get.snackbar(
        'Success',
        'Login successful!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      if (currentUser.value != null) {
        await _logActivity('logout', 'user', currentUser.value!.id);
      }

      await supabase.auth.signOut();
      currentUser.value = null;
      isLoggedIn.value = false;

      Get.offAllNamed(AppRoutes.splash);

      Get.snackbar(
        'Success',
        'Logged out successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Logout failed: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateBasedOnRole() {
    if (currentUser.value == null) return;

    switch (currentUser.value!.role) {
      case 'super_admin':
        Get.offAllNamed(AppRoutes.superAdminDashboard);
        break;
      case 'admin':
        Get.offAllNamed(AppRoutes.adminDashboard);
        break;
      case 'user':
        Get.offAllNamed(AppRoutes.userDashboard);
        break;
      default:
        Get.offAllNamed(AppRoutes.userDashboard);
    }
  }

  Future<void> _logActivity(String action, String entityType, String entityId) async {
    try {
      await supabase.from(SupabaseConfig.activityLogsTable).insert({
        'user_id': currentUser.value?.id ?? supabase.auth.currentUser?.id,
        'action': action,
        'entity_type': entityType,
        'entity_id': entityId,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error logging activity: $e');
    }
  }

  bool hasPermission(String permission) {
    if (currentUser.value == null) return false;

    final role = currentUser.value!.role;

    switch (permission) {
      case 'manage_admins':
        return role == 'super_admin';
      case 'manage_users':
        return role == 'super_admin' || role == 'admin';
      case 'create_challan':
        return role == 'user' || role == 'admin';
      case 'edit_challan':
        return role == 'admin' || role == 'super_admin';
      case 'manage_tokens':
        return role == 'super_admin';
      case 'view_reports':
        return true;
      case 'approve_reprint':
        return role == 'admin' || role == 'super_admin';
      case 'system_settings':
        return role == 'super_admin';
      default:
        return false;
    }
  }
}
// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter/material.dart';
// import '../config/supabase_config.dart';
// import '../model/user_model.dart';
// import '../routes/app_route.dart';
//
// class AuthController extends GetxController {
//   final supabase = Supabase.instance.client;
//
//   final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
//   final RxBool isLoading = false.obs;
//   final RxBool isLoggedIn = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     checkAuthState();
//   }
//
//   Future<void> checkAuthState() async {
//     try {
//       final session = supabase.auth.currentSession;
//       if (session != null && session.user != null) {
//         await _ensureUserRow(session.user!);
//       }
//     } catch (e) {
//       debugPrint('Error checking auth state: $e');
//     }
//   }
//
//   /// users table से data load करता है (अगर row नहीं है तो null)
//   Future<void> loadUserData() async {
//     try {
//       final userId = supabase.auth.currentUser?.id;
//       if (userId == null) return;
//
//       final response = await supabase
//           .from(SupabaseConfig.usersTable)
//           .select()
//           .eq('id', userId)
//           .maybeSingle(); // <-- important: single() नहीं
//
//       if (response == null) {
//         // अभी तक profile नहीं बनी
//         currentUser.value = null;
//         isLoggedIn.value = false;
//         return;
//       }
//
//       currentUser.value = UserModel.fromJson(response);
//       isLoggedIn.value = true;
//     } catch (e) {
//       debugPrint('Error loading user data: $e');
//       currentUser.value = null;
//       isLoggedIn.value = false;
//     }
//   }
//
//   /// Login + users table में row ensure
//   Future<void> login(String email, String password) async {
//     try {
//       isLoading.value = true;
//
//       final authResponse = await supabase.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );
//
//       if (authResponse.user == null) {
//         throw 'Invalid login response';
//       }
//
//       final authUser = authResponse.user!;
//
//       // 1) users table में row ensure करो (create अगर missing है)
//       await _ensureUserRow(authUser);
//
//       if (currentUser.value == null) {
//         throw 'User profile not found/created';
//       }
//
//       // 2) Last login update
//       await supabase
//           .from(SupabaseConfig.usersTable)
//           .update({
//         'last_login': DateTime.now().toIso8601String(),
//       })
//           .eq('id', authUser.id);
//
//       // 3) Activity log
//       await _logActivity('login', 'user', authUser.id);
//
//       // 4) Role के हिसाब से route
//       _navigateBasedOnRole();
//
//       Get.snackbar(
//         'Success',
//         'Login successful!',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       debugPrint('Login error: $e');
//       Get.snackbar(
//         'Error',
//         'Login failed: $e',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Logout
//   Future<void> logout() async {
//     try {
//       isLoading.value = true;
//
//       if (currentUser.value != null) {
//         await _logActivity('logout', 'user', currentUser.value!.id);
//       }
//
//       await supabase.auth.signOut();
//       currentUser.value = null;
//       isLoggedIn.value = false;
//
//       Get.offAllNamed(AppRoutes.login);
//
//       Get.snackbar(
//         'Success',
//         'Logged out successfully',
//         backgroundColor: Colors.green,
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         'Logout failed: $e',
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// users table में row create/load सुनिश्चित करता है
//   Future<void> _ensureUserRow(User authUser) async {
//     try {
//       final userId = authUser.id;
//
//       // 1) पहले check करो row exist करती है क्या
//       final existing = await supabase
//           .from(SupabaseConfig.usersTable)
//           .select()
//           .eq('id', userId)
//           .maybeSingle();
//
//       if (existing != null) {
//         currentUser.value = UserModel.fromJson(existing);
//         isLoggedIn.value = true;
//         return;
//       }
//
//       // 2) Row नहीं है → नई row insert करो
//       // पहली बार के लिए default role "user"
//       final defaultRole = 'user';
//
//       final insertData = {
//         'id': userId, // Important: auth.uid से match
//         'email': authUser.email,
//         'full_name': (authUser.userMetadata?['full_name'] ??
//             authUser.email?.split('@').first ??
//             'Unnamed User'),
//         'role': defaultRole,
//         'status': 'active',
//         'phone': authUser.phone,
//         'created_at': DateTime.now().toIso8601String(),
//         'created_by': userId,
//         'device_info': {},
//         'ip_address': null,
//       };
//
//       final inserted = await supabase
//           .from(SupabaseConfig.usersTable)
//           .insert(insertData)
//           .select()
//           .single();
//
//       currentUser.value = UserModel.fromJson(inserted);
//       isLoggedIn.value = true;
//     } catch (e) {
//       debugPrint('Error ensuring user row: $e');
//       rethrow;
//     }
//   }
//
//   void _navigateBasedOnRole() {
//     if (currentUser.value == null) return;
//
//     switch (currentUser.value!.role) {
//       case 'super_admin':
//         Get.offAllNamed(AppRoutes.superAdminDashboard);
//         break;
//       case 'admin':
//         Get.offAllNamed(AppRoutes.adminDashboard);
//         break;
//       case 'user':
//         Get.offAllNamed(AppRoutes.userDashboard);
//         break;
//       default:
//         Get.offAllNamed(AppRoutes.userDashboard);
//     }
//   }
//
//   Future<void> _logActivity(
//       String action, String entityType, String entityId) async {
//     try {
//       await supabase.from(SupabaseConfig.activityLogsTable).insert({
//         'user_id': currentUser.value?.id ?? supabase.auth.currentUser?.id,
//         'action': action,
//         'entity_type': entityType,
//         'entity_id': entityId,
//         'created_at': DateTime.now().toIso8601String(),
//       });
//     } catch (e) {
//       debugPrint('Error logging activity: $e');
//     }
//   }
//
//   bool hasPermission(String permission) {
//     if (currentUser.value == null) return false;
//
//     final role = currentUser.value!.role;
//
//     switch (permission) {
//       case 'manage_admins':
//         return role == 'super_admin';
//       case 'manage_users':
//         return role == 'super_admin' || role == 'admin';
//       case 'create_challan':
//         return role == 'user' || role == 'admin';
//       case 'edit_challan':
//         return role == 'admin' || role == 'super_admin';
//       case 'manage_tokens':
//         return role == 'super_admin';
//       case 'view_reports':
//         return true;
//       case 'approve_reprint':
//         return role == 'admin' || role == 'super_admin';
//       case 'system_settings':
//         return role == 'super_admin';
//       default:
//         return false;
//     }
//   }
// }
