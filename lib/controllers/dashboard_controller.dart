// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../model/user_model.dart';
// import '../config/supabase_config.dart';
//
// // DASHBOARD CONTROLLER
// class DashboardController extends GetxController {
//   final supabase = Supabase.instance.client;
//
//   final RxInt todayChallans = 0.obs;
//   final RxInt weekChallans = 0.obs;
//   final RxInt monthChallans = 0.obs;
//   final RxInt totalChallans = 0.obs;
//   final RxList<ChallanModel> recentChallans = <ChallanModel>[].obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadDashboardData();
//   }
//
//   Future<void> loadDashboardData() async {
//     try {
//       isLoading.value = true;
//
//       final now = DateTime.now();
//       final todayStart = DateTime(now.year, now.month, now.day);
//       final weekStart = now.subtract(Duration(days: now.weekday - 1));
//       final monthStart = DateTime(now.year, now.month, 1);
//
//       // Today's challans
//       final todayResponse = await supabase
//           .from(SupabaseConfig.challansTable)
//           .select()
//           .gte('created_at', todayStart.toIso8601String())
//           .count();
//       todayChallans.value = todayResponse.count ?? 0;
//
//       // Week's challans
//       final weekResponse = await supabase
//           .from(SupabaseConfig.challansTable)
//           .select()
//           .gte('created_at', weekStart.toIso8601String())
//           .count();
//       weekChallans.value = weekResponse.count ?? 0;
//
//       // Month's challans
//       final monthResponse = await supabase
//           .from(SupabaseConfig.challansTable)
//           .select()
//           .gte('created_at', monthStart.toIso8601String())
//           .count();
//       monthChallans.value = monthResponse.count ?? 0;
//
//       // Total challans
//       final totalResponse = await supabase
//           .from(SupabaseConfig.challansTable)
//           .select()
//           .count();
//       totalChallans.value = totalResponse.count ?? 0;
//
//       // Recent challans
//       final recentResponse = await supabase
//           .from(SupabaseConfig.challansTable)
//           .select()
//           .order('created_at', ascending: false)
//           .limit(5);
//
//       recentChallans.value = (recentResponse as List)
//           .map((e) => ChallanModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       print('Error loading dashboard data: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/user_model.dart';
import '../config/supabase_config.dart';
import 'auth_controller.dart';

class DashboardController extends GetxController {
  final supabase = Supabase.instance.client;
  final authController = Get.find<AuthController>();

  final RxInt todayChallans = 0.obs;
  final RxInt weekChallans = 0.obs;
  final RxInt monthChallans = 0.obs;
  final RxInt totalChallans = 0.obs;
  final RxInt totalUsers = 0.obs;
  final RxInt totalTokens = 0.obs;
  final RxInt pendingReprintRequests = 0.obs;
  final RxDouble todayRevenue = 0.0.obs;
  final RxDouble monthRevenue = 0.0.obs;

  final RxList<ChallanModel> recentChallans = <ChallanModel>[].obs;
  final RxList<Map<String, dynamic>> recentActivities = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;

      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final monthStart = DateTime(now.year, now.month, 1);

      final role = authController.currentUser.value?.role ?? 'user';

      // Today's challans
      var todayQuery = supabase
          .from(SupabaseConfig.challansTable)
          .select()
          .gte('created_at', todayStart.toIso8601String());

      if (role == 'user') {
        todayQuery = todayQuery.eq('created_by', authController.currentUser.value!.id);
      }

      final todayResponse = await todayQuery.count();
      todayChallans.value = todayResponse.count ?? 0;

      // Week's challans
      var weekQuery = supabase
          .from(SupabaseConfig.challansTable)
          .select()
          .gte('created_at', weekStart.toIso8601String());

      if (role == 'user') {
        weekQuery = weekQuery.eq('created_by', authController.currentUser.value!.id);
      }

      final weekResponse = await weekQuery.count();
      weekChallans.value = weekResponse.count ?? 0;

      // Month's challans
      var monthQuery = supabase
          .from(SupabaseConfig.challansTable)
          .select()
          .gte('created_at', monthStart.toIso8601String());

      if (role == 'user') {
        monthQuery = monthQuery.eq('created_by', authController.currentUser.value!.id);
      }

      final monthResponse = await monthQuery.count();
      monthChallans.value = monthResponse.count ?? 0;

      // Total challans
      var totalQuery = supabase.from(SupabaseConfig.challansTable).select();

      if (role == 'user') {
        totalQuery = totalQuery.eq('created_by', authController.currentUser.value!.id);
      }

      final totalResponse = await totalQuery.count();
      totalChallans.value = totalResponse.count ?? 0;

      // Revenue calculations
      if (role != 'user') {
        final todayRevenueData = await supabase
            .from(SupabaseConfig.challansTable)
            .select('total_amount')
            .gte('created_at', todayStart.toIso8601String());

        todayRevenue.value = (todayRevenueData as List).fold<double>(
          0.0,
              (sum, item) => sum + (item['total_amount'] as num? ?? 0).toDouble(),
        );

        final monthRevenueData = await supabase
            .from(SupabaseConfig.challansTable)
            .select('total_amount')
            .gte('created_at', monthStart.toIso8601String());

        monthRevenue.value = (monthRevenueData as List).fold<double>(
          0.0,
              (sum, item) => sum + (item['total_amount'] as num? ?? 0).toDouble(),
        );
      }

      // Admin/Super Admin specific data
      if (role == 'admin' || role == 'super_admin') {
        final usersResponse = await supabase
            .from(SupabaseConfig.usersTable)
            .select()
            .count();
        totalUsers.value = usersResponse.count ?? 0;

        final tokensResponse = await supabase
            .from(SupabaseConfig.tokensTable)
            .select()
            .eq('status', 'active')
            .count();
        totalTokens.value = tokensResponse.count ?? 0;

        final reprintResponse = await supabase
            .from(SupabaseConfig.reprintRequestsTable)
            .select()
            .eq('status', 'pending')
            .count();
        pendingReprintRequests.value = reprintResponse.count ?? 0;
      }

      // Recent challans
      var recentQuery = supabase
          .from(SupabaseConfig.challansTable)
          .select();

      if (role == 'user') {
        recentQuery = recentQuery.eq('created_by', authController.currentUser.value!.id);
      }

      final recentResponse = await recentQuery.order('created_at', ascending: false)
          .limit(5);
      recentChallans.value = (recentResponse as List)
          .map((e) => ChallanModel.fromJson(e))
          .toList();

      // Recent activities (Admin/Super Admin only)
      if (role == 'admin' || role == 'super_admin') {
        final activitiesResponse = await supabase
            .from(SupabaseConfig.activityLogsTable)
            .select('*, users!user_id(full_name)')
            .order('created_at', ascending: false)
            .limit(10);

        recentActivities.value = (activitiesResponse as List)
            .map((e) => e as Map<String, dynamic>)
            .toList();
      }
    } catch (e) {
      print('Error loading dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}