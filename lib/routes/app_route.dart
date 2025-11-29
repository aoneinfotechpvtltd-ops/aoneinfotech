import 'package:aoneinfotech/landing_page.dart';
import 'package:get/get.dart';
import '../screens/admin_dashboard.dart';
import '../screens/challan/challan_list.dart';
import '../screens/challan/create_challan.dart';
import '../screens/login_screen.dart';
import '../screens/print_token_report.dart';
import '../screens/reprint_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/user_dashboard.dart';
import '../screens/user_management.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/challan_controller.dart';
import '../controllers/user_management_controller.dart';
import '../controllers/token_controller.dart';
import '../controllers/reports_controller.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';
  static const superAdminDashboard = '/super-admin-dashboard';
  static const adminDashboard = '/admin-dashboard';
  static const userDashboard = '/user-dashboard';
  static const createChallan = '/create-challan';
  static const challanList = '/challan-list';
  static const challanAdminList = '/challan-admin-list';
  static const challanDetail = '/challan-detail';
  static const challanAdminDetail = '/challan-admin-detail';
  static const userManagement = '/user-management';
  static const adminManagement = '/admin-management';
  static const reports = '/reports';
  static const tokenReport = '/token-report';
  static const tokenManagement = '/token-management';
  static const systemSettings = '/system-settings';
  static const reprintRequests = '/reprint-requests';

  static final routes = [
    GetPage(
      name: splash,
      page: () => const HomePageScreen(),
    ),GetPage(
      name: home,
      page: () => const HomePageScreen(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: superAdminDashboard,
      page: () => const SuperAdminDashboard(),
      binding: BindingsBuilder(() {
Get.put(DashboardController());
      }),
    ),
    GetPage(
      name: adminDashboard,
      page: () => const AdminDashboard(),
      binding: BindingsBuilder(() {
Get.put(DashboardController());
      }),
    ),
    GetPage(
      name: userDashboard,
      page: () => const UserDashboard(),
      binding: BindingsBuilder(() {
Get.put(DashboardController());
        Get.put(ChallanController());
      }),
    ),
    GetPage(
      name: createChallan,
      page: () => const CreateChallanScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChallanController());
      }),
    ),
    GetPage(
      name: challanList,
      page: () => const ChallanListScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChallanController());
      }),
    ),
    GetPage(
      name: challanAdminList,
      page: () => const ChallanAdminListScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChallanController());
      }),
    ),
    GetPage(
      name: challanDetail,
      page: () => const ChallanDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChallanController());
      }),
    ), GetPage(
      name: challanAdminDetail,
      page: () => const ChallanAdminDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChallanController());
      }),
    ),
    GetPage(
      name: userManagement,
      page: () => const EnhancedUserManagementScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserManagementController());
      }),
    ),
    GetPage(
      name: adminManagement,
      page: () => const AdminManagementScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => UserManagementController());
      }),
    ),
    GetPage(
      name: reports,
      page: () => const ReportsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ReportsController());
      }),
    ),
    GetPage(
      name: tokenReport,
      page: () {
        final args = Get.arguments ?? {};
        return PrintTokenReportScreen(
          isAdmin: args['isAdmin'] ?? false,
        );
      },
      binding: BindingsBuilder(() {
        Get.put(TokenController());
      }),
    ),

    GetPage(
      name: tokenManagement,
      page: () => const TokenManagementScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TokenController());
      }),
    ),
    GetPage(
      name: systemSettings,
      page: () => const SystemSettingsScreen(),
    ),
    GetPage(
      name: reprintRequests,
      page: () => const ReprintRequestsScreen(),
      binding: BindingsBuilder(() {
        Get.put(ChallanController());
      }),
    ),
  ];
}