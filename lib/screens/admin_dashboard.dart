import 'package:aoneinfotech/screens/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../controllers/user_management_controller.dart';
import '../main.dart';
import '../model/user_model.dart';
import '../routes/app_route.dart';
import '../utilis/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../routes/app_route.dart';
import '../utilis/app_colors.dart';

// SUPER ADMIN DASHBOARD
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../routes/app_route.dart';
import '../utilis/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../routes/app_route.dart';
import '../utilis/app_colors.dart';

// class SuperAdminDashboard extends StatelessWidget {
//   const SuperAdminDashboard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();
//     final dashboardController = Get.put(DashboardController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Super Admin Dashboard'),
//         backgroundColor: AppColors.superAdmin,
//         actions: [
//           IconButton(
//             icon: Obx(() {
//               final pending = dashboardController.pendingReprintRequests.value;
//               return Stack(
//                 children: [
//                   const Icon(Icons.notifications_outlined),
//                   if (pending > 0)
//                     Positioned(
//                       right: 0,
//                       child: Container(
//                         padding: const EdgeInsets.all(2),
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         constraints: const BoxConstraints(
//                           minWidth: 14,
//                           minHeight: 14,
//                         ),
//                         child: Text(
//                           pending.toString(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 8,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                 ],
//               );
//             }),
//             onPressed: () => Get.toNamed(AppRoutes.reprintRequests),
//           ),
//           PopupMenuButton(
//             icon: const Icon(Icons.more_vert),
//             itemBuilder: (context) => [
//               // const PopupMenuItem(
//               //   value: 'profile',
//               //   child: Row(
//               //     children: [
//               //       Icon(Icons.person_outline),
//               //       SizedBox(width: 8),
//               //       Text('Profile'),
//               //     ],
//               //   ),
//               // ),
//               const PopupMenuItem(
//                 value: 'settings',
//                 child: Row(
//                   children: [
//                     Icon(Icons.settings_outlined),
//                     SizedBox(width: 8),
//                     Text('System Settings'),
//                   ],
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 'logout',
//                 child: Row(
//                   children: [
//                     Icon(Icons.logout, color: Colors.red),
//                     SizedBox(width: 8),
//                     Text('Logout', style: TextStyle(color: Colors.red)),
//                   ],
//                 ),
//               ),
//             ],
//             onSelected: (value) {
//               if (value == 'logout') {
//                 authController.logout();
//               } else if (value == 'settings') {
//                 Get.toNamed(AppRoutes.systemSettings);
//               }
//             },
//           ),
//         ],
//       ),
//       drawer: _buildDrawer(context, dashboardController),
//       body: RefreshIndicator(
//         onRefresh: () => dashboardController.loadDashboardData(),
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildWelcomeCard(authController),
//               const SizedBox(height: 20),
//               Obx(() => _buildSystemOverview(dashboardController)),
//               const SizedBox(height: 20),
//               Obx(() => _buildStatsGrid(dashboardController)),
//               const SizedBox(height: 20),
//               _buildManagementActions(context),
//               const SizedBox(height: 150),
//               // Row(
//               //   crossAxisAlignment: CrossAxisAlignment.start,
//               //   children: [
//               //     Expanded(
//               //       child: _buildRecentActivitiesSection(dashboardController),
//               //     ),
//               //     const SizedBox(width: 16),
//               //     Expanded(
//               //       child: _buildSystemHealthSection(),
//               //     ),
//               //   ],
//               // ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: 'admin',
//             onPressed: () => Get.toNamed(AppRoutes.adminManagement),
//             backgroundColor: AppColors.warning,
//             child: const Icon(Icons.admin_panel_settings),
//             tooltip: 'Admin Management',
//           ).animate().scale(delay: 400.ms),
//           const SizedBox(height: 12),
//           FloatingActionButton.extended(
//             heroTag: 'settings',
//             onPressed: () => Get.toNamed(AppRoutes.systemSettings),
//             backgroundColor: AppColors.superAdmin,
//             icon: const Icon(Icons.settings),
//             label: const Text('Settings'),
//           ).animate().scale(delay: 500.ms),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawer(BuildContext context, DashboardController controller) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColors.superAdmin,
//                   AppColors.superAdmin.withOpacity(0.7),
//                 ],
//               ),
//             ),
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Icon(Icons.security, size: 48, color: Colors.white),
//                 SizedBox(height: 8),
//                 Text(
//                   'Super Admin',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'Full System Control',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.dashboard),
//             title: const Text('Dashboard'),
//             onTap: () => Get.back(),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.admin_panel_settings),
//             title: const Text('Admin Management'),
//             onTap: () => Get.toNamed(AppRoutes.adminManagement),
//           ),
//           ListTile(
//             leading: const Icon(Icons.receipt_long),
//             title: const Text('All Challans'),
//             onTap: () => Get.toNamed(AppRoutes.challanList),
//           ),
//           ListTile(
//             leading: const Icon(Icons.print),
//             title: const Text('Reprint Requests'),
//             trailing: Obx(() {
//               final pending = controller.pendingReprintRequests.value;
//               return pending > 0
//                   ? Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   pending.toString(),
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                   ),
//                 ),
//               )
//                   : const SizedBox();
//             }),
//             onTap: () => Get.toNamed(AppRoutes.reprintRequests),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.assessment),
//             title: const Text('Reports & Analytics'),
//             onTap: () => Get.toNamed(AppRoutes.reports),
//           ),
//           const Divider(),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('System Settings'),
//             onTap: () => Get.toNamed(AppRoutes.systemSettings),
//           ),
//           // ListTile(
//           //   leading: const Icon(Icons.backup),
//           //   title: const Text('Backup & Restore'),
//           //   onTap: () {
//           //     Get.snackbar(
//           //       'Feature',
//           //       'Backup feature coming soon',
//           //       snackPosition: SnackPosition.BOTTOM,
//           //     );
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWelcomeCard(AuthController authController) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             AppColors.superAdmin,
//             AppColors.superAdmin.withOpacity(0.7),
//           ],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.superAdmin.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(
//               Icons.security,
//               color: Colors.white,
//               size: 32,
//             ),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Welcome Super Admin!',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   authController.currentUser.value?.fullName ?? 'Super Admin',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'SUPER ADMIN',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ).animate().fadeIn().slideX(begin: -0.2);
//   }
//
//   Widget _buildSystemOverview(DashboardController controller) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.blue.shade50, Colors.blue.shade100],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.blue.shade200),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: _buildOverviewItem(
//               'Total Revenue',
//               '₹${controller.monthRevenue.value.toStringAsFixed(0)}',
//               Icons.currency_rupee,
//               Colors.green,
//             ),
//           ),
//           Container(width: 1, height: 40, color: Colors.blue.shade200),
//           Expanded(
//             child: _buildOverviewItem(
//               'Total Users',
//               controller.totalUsers.value.toString(),
//               Icons.people,
//               Colors.blue,
//             ),
//           ),
//           Container(width: 1, height: 40, color: Colors.blue.shade200),
//           Expanded(
//             child: _buildOverviewItem(
//               'Pending Actions',
//               controller.pendingReprintRequests.value.toString(),
//               Icons.pending_actions,
//               Colors.orange,
//             ),
//           ),
//         ],
//       ),
//     ).animate().fadeIn(delay: 100.ms);
//   }
//
//   Widget _buildOverviewItem(
//       String label, String value, IconData icon, Color color) {
//     return Column(
//       children: [
//         Icon(icon, color: color, size: 24),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 11,
//             color: AppColors.textSecondary,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatsGrid(DashboardController controller) {
//     return GridView.count(
//       crossAxisCount: responsive!.isMobile?2:4,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       mainAxisSpacing: 16,
//       crossAxisSpacing: 16,
//       childAspectRatio: 1.3,
//       children: [
//         _buildStatCard(
//           'Today\'s Challans',
//           controller.todayChallans.value.toString(),
//           Icons.receipt_long,
//           AppColors.primary,
//         ),
//         _buildStatCard(
//           'Week Challans',
//           controller.weekChallans.value.toString(),
//           Icons.calendar_today,
//           AppColors.success,
//         ),
//         _buildStatCard(
//           'Month Challans',
//           controller.monthChallans.value.toString(),
//           Icons.trending_up,
//           AppColors.warning,
//         ),
//         _buildStatCard(
//           'Total Challans',
//           controller.totalChallans.value.toString(),
//           Icons.bar_chart,
//           AppColors.info,
//         ),
//         _buildStatCard(
//           'Active Tokens',
//           controller.totalTokens.value.toString(),
//           Icons.verified,
//           AppColors.secondary,
//         ),
//         _buildStatCard(
//           'All Admins',
//           controller.totalUsers.value.toString(),
//           Icons.admin_panel_settings,
//           AppColors.superAdmin,
//         ),
//       ],
//     ).animate().fadeIn(delay: 200.ms);
//   }
//
//   Widget _buildStatCard(
//       String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, color: color, size: 24),
//           ),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 11,
//               color: AppColors.textSecondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildManagementActions(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'System Management',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 12),
//         GridView.count(
//           crossAxisCount: responsive!.isMobile?3:4,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           mainAxisSpacing: 12,
//           crossAxisSpacing: 12,
//           children: [
//             _buildActionCard(
//               'Admin\nManagement',
//               Icons.admin_panel_settings,
//               AppColors.superAdmin,
//                   () => Get.toNamed(AppRoutes.adminManagement),
//             ),
//             _buildActionCard(
//               'System\nSettings',
//               Icons.settings,
//               AppColors.secondary,
//                   () => Get.toNamed(AppRoutes.systemSettings),
//             ),
//             _buildActionCard(
//               'Reprint\nRequests',
//               Icons.print,
//               AppColors.error,
//                   () => Get.toNamed(AppRoutes.reprintRequests),
//             ),
//             _buildActionCard(
//               'All\nChallans',
//               Icons.list_alt,
//               AppColors.primary,
//                   () => Get.toNamed(AppRoutes.challanList),
//             ),
//             _buildActionCard(
//               'Reports &\nAnalytics',
//               Icons.assessment,
//               AppColors.success,
//                   () => Get.toNamed(AppRoutes.reports),
//             ),
//             _buildActionCard(
//               'Delete\nTokens',
//               Icons.delete_forever,
//               AppColors.warning,
//                   () => Get.toNamed(AppRoutes.tokenManagement),
//             ),
//           ],
//         ),
//       ],
//     ).animate().fadeIn(delay: 300.ms);
//   }
//
//   Widget _buildActionCard(
//       String title, IconData icon, Color color, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: color, size: 24),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecentActivitiesSection(DashboardController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Recent System Activities',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (controller.recentActivities.isEmpty) {
//             return Container(
//               padding: const EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Center(
//                 child: Column(
//                   children: [
//                     Icon(Icons.history, size: 48, color: AppColors.textTertiary),
//                     SizedBox(height: 8),
//                     Text(
//                       'No recent activities',
//                       style: TextStyle(color: AppColors.textSecondary),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//
//           return ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: controller.recentActivities.length.clamp(0, 8),
//             itemBuilder: (context, index) {
//               final activity = controller.recentActivities[index];
//               return _buildActivityCard(activity);
//             },
//           );
//         }),
//       ],
//     ).animate().fadeIn(delay: 400.ms);
//   }
//
//   Widget _buildSystemHealthSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'System Health',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimary,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               _buildHealthItem('Database', 'Healthy', Icons.check_circle,
//                   AppColors.success),
//               const Divider(),
//               _buildHealthItem(
//                   'API Status', 'Running', Icons.check_circle, AppColors.success),
//               const Divider(),
//               _buildHealthItem('Storage', 'Optimal', Icons.storage,
//                   AppColors.success),
//               const Divider(),
//               _buildHealthItem('Backup', 'Scheduled', Icons.backup,
//                   AppColors.info),
//               const Divider(),
//               _buildHealthItem('Security', 'Protected', Icons.security,
//                   AppColors.success),
//             ],
//           ),
//         ),
//       ],
//     ).animate().fadeIn(delay: 500.ms);
//   }
//
//   Widget _buildHealthItem(
//       String label, String status, IconData icon, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Icon(icon, color: color, size: 20),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               status,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: color,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActivityCard(Map<String, dynamic> activity) {
//     IconData icon;
//     Color color;
//
//     switch (activity['action']) {
//       case 'login':
//         icon = Icons.login;
//         color = AppColors.success;
//         break;
//       case 'create_challan':
//         icon = Icons.add_circle;
//         color = AppColors.primary;
//         break;
//       case 'create_admin':
//         icon = Icons.person_add;
//         color = AppColors.superAdmin;
//         break;
//       case 'approve_reprint':
//         icon = Icons.check_circle;
//         color = AppColors.success;
//         break;
//       case 'update_settings':
//         icon = Icons.settings;
//         color = AppColors.warning;
//         break;
//       default:
//         icon = Icons.info;
//         color = AppColors.info;
//     }
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         dense: true,
//         leading: Icon(icon, color: color, size: 20),
//         title: Text(
//           activity['action'].toString().replaceAll('_', ' ').toUpperCase(),
//           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
//         ),
//         subtitle: Text(
//           activity['users']?['full_name'] ?? 'System',
//           style: const TextStyle(fontSize: 10),
//         ),
//         trailing: Text(
//           _formatTime(activity['created_at']),
//           style: const TextStyle(fontSize: 10, color: AppColors.textTertiary),
//         ),
//       ),
//     );
//   }
//
//   String _formatTime(String? timestamp) {
//     if (timestamp == null) return '';
//     final date = DateTime.parse(timestamp);
//     final now = DateTime.now();
//     final diff = now.difference(date);
//
//     if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
//     if (diff.inHours < 24) return '${diff.inHours}h ago';
//     return '${diff.inDays}d ago';
//   }
// }// ADMIN DASHBOARD (Similar structure with limited features)
class SuperAdminDashboard extends StatelessWidget {
  const SuperAdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final dashboardController = Get.put(DashboardController());

    return Scaffold(
      body: Row(
        children: [
          // Permanent Sidebar
          _buildPermanentSidebar(authController, dashboardController),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // AppBar
                _buildAppBar(authController, dashboardController),

                // Content
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => dashboardController.loadDashboardData(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildWelcomeCard(authController),
                          const SizedBox(height: 20),
                          Obx(() => _buildSystemOverview(dashboardController)),
                          const SizedBox(height: 20),
                          Obx(() => _buildStatsGrid(dashboardController)),
                          const SizedBox(height: 20),
                          _buildManagementActions(context),
                          const SizedBox(height: 150),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.adminManagement),
        backgroundColor: AppColors.superAdmin,
        icon: const Icon(Icons.admin_panel_settings),
        label: const Text('Admin Management'),
      ).animate().scale(delay: 500.ms),
    );
  }

  // Permanent Sidebar with White Theme
  Widget _buildPermanentSidebar(
      AuthController authController,
      DashboardController dashboardController,
      ) {
    final currentRoute = Get.currentRoute;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with A One Infotech
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Company Name
                const Text(
                  'A One Infotech',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.superAdmin,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Super Admin Avatar
                CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColors.superAdmin.withOpacity(0.1),
                  child: Text(
                    authController.currentUser.value?.fullName?[0]
                        .toUpperCase() ??
                        'S',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.superAdmin,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Admin Name
                Text(
                  authController.currentUser.value?.fullName ?? 'Super Admin',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Super Admin Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.superAdmin.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.superAdmin.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'SUPER ADMIN',
                    style: TextStyle(
                      color: AppColors.superAdmin,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              children: [
                _buildSidebarItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () => Get.toNamed(AppRoutes.superAdminDashboard),
                  isActive: currentRoute == AppRoutes.superAdminDashboard,
                ),
                _buildSidebarItem(
                  icon: Icons.admin_panel_settings,
                  title: 'Admin Management',
                  onTap: () => Get.toNamed(AppRoutes.adminManagement),
                  isActive: currentRoute == AppRoutes.adminManagement,
                ),
                _buildSidebarItem(
                  icon: Icons.receipt_long,
                  title: 'Print Token Report',
                  onTap: () => Get.toNamed(AppRoutes.tokenReport, arguments: {"isAdmin": false}),
                ),
                // _buildSidebarItem(
                //   icon: Icons.receipt_long,
                //   title: 'All Challans',
                //   onTap: () => Get.toNamed(AppRoutes.challanList),
                //   isActive: currentRoute == AppRoutes.challanList,
                // ),
                _buildSidebarItem(
                  icon: Icons.print,
                  title: 'Reprint Requests',
                  onTap: () => Get.toNamed(AppRoutes.reprintRequests),
                  isActive: currentRoute == AppRoutes.reprintRequests,
                  trailing: Obx(() {
                    final pending =
                        dashboardController.pendingReprintRequests.value;
                    return pending > 0
                        ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        pending.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        : const SizedBox.shrink();
                  }),
                ),
                _buildSidebarItem(
                  icon: Icons.assessment,
                  title: 'Reports & Analytics',
                  onTap: () => Get.toNamed(AppRoutes.reports),
                  isActive: currentRoute == AppRoutes.reports,
                ),
                const Divider(
                  height: 24,
                  thickness: 1,
                  color: Color(0xFFE0E0E0),
                ),
                _buildSidebarItem(
                  icon: Icons.settings,
                  title: 'System Settings',
                  onTap: () => Get.toNamed(AppRoutes.systemSettings),
                  isActive: currentRoute == AppRoutes.systemSettings,
                ),
              ],
            ),
          ),

          // Footer
          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildSidebarItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  isLogout: true,
                  onTap: () => authController.logout(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
    bool isActive = false,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.superAdmin.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isLogout
                      ? Colors.red.shade400
                      : isActive
                      ? AppColors.superAdmin
                      : AppColors.textSecondary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isLogout
                          ? Colors.red.shade400
                          : isActive
                          ? AppColors.superAdmin
                          : AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // AppBar
  Widget _buildAppBar(
      AuthController authController,
      DashboardController dashboardController,
      ) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Super Admin Dashboard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(AuthController authController) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.superAdmin,
            AppColors.superAdmin.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.superAdmin.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.security,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Super Admin!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  authController.currentUser.value?.fullName ?? 'Super Admin',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'SUPER ADMIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.2);
  }

  Widget _buildSystemOverview(DashboardController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.blue.shade100],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildOverviewItem(
              'Total Revenue',
              '₹${controller.monthRevenue.value.toStringAsFixed(0)}',
              Icons.currency_rupee,
              Colors.green,
            ),
          ),
          Container(width: 1, height: 40, color: Colors.blue.shade200),
          Expanded(
            child: _buildOverviewItem(
              'Total Users',
              controller.totalUsers.value.toString(),
              Icons.people,
              Colors.blue,
            ),
          ),
          Container(width: 1, height: 40, color: Colors.blue.shade200),
          Expanded(
            child: _buildOverviewItem(
              'Pending Actions',
              controller.pendingReprintRequests.value.toString(),
              Icons.pending_actions,
              Colors.orange,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms);
  }

  Widget _buildOverviewItem(
      String label,
      String value,
      IconData icon,
      Color color,
      ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatsGrid(DashboardController controller) {
    return GridView.count(
      crossAxisCount: responsive!.isMobile ? 2 : 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          'Today\'s Tokens',
          controller.todayChallans.value.toString(),
          Icons.receipt_long,
          AppColors.primary,
        ),
        _buildStatCard(
          'Week Tokens',
          controller.weekChallans.value.toString(),
          Icons.calendar_today,
          AppColors.success,
        ),
        _buildStatCard(
          'Month Tokens',
          controller.monthChallans.value.toString(),
          Icons.trending_up,
          AppColors.warning,
        ),
        _buildStatCard(
          'Total Tokens',
          controller.totalChallans.value.toString(),
          Icons.bar_chart,
          AppColors.info,
        ),
        _buildStatCard(
          'Active Tokens',
          controller.totalTokens.value.toString(),
          Icons.verified,
          AppColors.secondary,
        ),
        // _buildStatCard(
        //   'All Admins',
        //   controller.totalUsers.value.toString(),
        //   Icons.admin_panel_settings,
        //   AppColors.superAdmin,
        // ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Management',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: responsive!.isMobile ? 3 : 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _buildActionCard(
              'Admin\nManagement',
              Icons.admin_panel_settings,
              AppColors.superAdmin,
                  () => Get.toNamed(AppRoutes.adminManagement),
            ),
            _buildActionCard(
               'Print Token Report',
              Icons.receipt_long,
               AppColors.admin,
               () => Get.toNamed(AppRoutes.tokenReport, arguments: {"isAdmin": false}),
            ),
            _buildActionCard(
              'Reprint\nRequests',
              Icons.print,
              AppColors.error,
                  () => Get.toNamed(AppRoutes.reprintRequests),
            ),
            _buildActionCard(
              'All\nTokens',
              Icons.list_alt,
              AppColors.primary,
                  () => Get.toNamed(AppRoutes.tokenReport),
            ),
            _buildActionCard(
              'Reports &\nAnalytics',
              Icons.assessment,
              AppColors.success,
                  () => Get.toNamed(AppRoutes.reports),
            ),
            _buildActionCard(
              'System\nSettings',
              Icons.settings,
              AppColors.secondary,
                  () => Get.toNamed(AppRoutes.systemSettings),
            ),

            // _buildActionCard(
            //   'Delete\nTokens',
            //   Icons.delete_forever,
            //   AppColors.warning,
            //       () => Get.toNamed(AppRoutes.tokenManagement),
            // ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildActionCard(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final dashboardController = Get.put(DashboardController());
    final tokenController = Get.put(TokenController());

    return Scaffold(
      body: Row(
        children: [
          // Permanent Sidebar
          _buildPermanentSidebar(
              authController, dashboardController, tokenController),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // AppBar
                _buildAppBar(authController, dashboardController),

                // Content
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => dashboardController.loadDashboardData(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildWelcomeCard(authController),
                          const SizedBox(height: 20),
                          Obx(() => _buildStatsGrid(dashboardController)),
                          const SizedBox(height: 20),
                          _buildQuickActions(context, tokenController),
                          // const SizedBox(height: 20),
                          // _buildRecentChallansSection(dashboardController),
                          const SizedBox(height: 150),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed:                   () => _showAddTokenDialog(context, tokenController),

        backgroundColor: AppColors.admin,
        icon: const Icon(Icons.add),
        label: const Text('New Token'),
      ).animate().scale(delay: 500.ms),
    );
  }

  // Permanent Sidebar with White Theme
  Widget _buildPermanentSidebar(AuthController authController,
      DashboardController dashboardController,
      TokenController tokenController,) {
    final currentRoute = Get.currentRoute;

    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with A One Infotech
          Container(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Company Name
                const Text(
                  'A One Infotech',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.admin,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Admin Avatar
                CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColors.admin.withOpacity(0.1),
                  child: Text(
                    authController.currentUser.value?.fullName?[0]
                        .toUpperCase() ?? 'A',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.admin,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Admin Name
                Text(
                  authController.currentUser.value?.fullName ?? 'Admin',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Admin Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.admin.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.admin.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'ADMIN',
                    style: TextStyle(
                      color: AppColors.admin,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              children: [
                _buildSidebarItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () => Get.toNamed(AppRoutes.adminDashboard),
                  isActive: currentRoute == AppRoutes.adminDashboard,
                ),
                _buildSidebarItem(
                  icon: Icons.people,
                  title: 'User Management',
                  onTap: () => Get.toNamed(AppRoutes.userManagement),
                  isActive: currentRoute == AppRoutes.userManagement,
                ),
                // _buildSidebarItem(
                //   icon: Icons.receipt_long,
                //   title: 'All Challans',
                //   onTap: () => Get.toNamed(AppRoutes.challanList),
                //   isActive: currentRoute == AppRoutes.challanList,
                // ),
                // _buildSidebarItem(
                //   icon: Icons.print,
                //   title: 'Reprint Requests',
                //   onTap: () => Get.toNamed(AppRoutes.reprintRequests),
                //   isActive: currentRoute == AppRoutes.reprintRequests,
                //   trailing: Obx(() {
                //     final pending = dashboardController.pendingReprintRequests
                //         .value;
                //     return pending > 0
                //         ? Container(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 6, vertical: 2),
                //       decoration: BoxDecoration(
                //         color: Colors.red,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Text(
                //         pending.toString(),
                //         style: const TextStyle(
                //           color: Colors.white,
                //           fontSize: 10,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     )
                //         : const SizedBox.shrink();
                //   }),
                // ),
                _buildSidebarItem(
                  icon: Icons.receipt_long,
                  title: 'Print Token Report',
                  onTap: () => Get.toNamed(AppRoutes.tokenReport, arguments: {"isAdmin": true}),
                  isActive: currentRoute == AppRoutes.tokenReport,
                ),
                _buildSidebarItem(
                  icon: Icons.bar_chart,
                  title: 'Reports',
                  onTap: () => Get.toNamed(AppRoutes.reports),
                  isActive: currentRoute == AppRoutes.reports,
                ),

                const Divider(
                    height: 24, thickness: 1, color: Color(0xFFE0E0E0)),

                // _buildSidebarItem(
                //   icon: Icons.add_circle_outline,
                //   title: 'Create Challan',
                //   onTap: () => Get.toNamed(AppRoutes.createChallan),
                //   isActive: currentRoute == AppRoutes.createChallan,
                // ),
                _buildSidebarItem(
                  icon: Icons.token,
                  title: 'Create Token',
                  onTap: () {
                    _showAddTokenDialog(Get.context!, tokenController);
                  },
                ),
              ],
            ),
          ),

          // Footer
          const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                _buildSidebarItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  isLogout: true,
                  onTap: () => authController.logout(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
    bool isActive = false,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.admin.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isLogout
                      ? Colors.red.shade400
                      : isActive
                      ? AppColors.admin
                      : AppColors.textSecondary,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: isLogout
                          ? Colors.red.shade400
                          : isActive
                          ? AppColors.admin
                          : AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // AppBar
  Widget _buildAppBar(AuthController authController,
      DashboardController dashboardController) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'Admin Dashboard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          // IconButton(
          //   icon: Obx(() {
          //     final pending = dashboardController.pendingReprintRequests.value;
          //     return Stack(
          //       children: [
          //         const Icon(Icons.notifications_outlined),
          //         if (pending > 0)
          //           Positioned(
          //             right: 0,
          //             child: Container(
          //               padding: const EdgeInsets.all(2),
          //               decoration: BoxDecoration(
          //                 color: Colors.red,
          //                 borderRadius: BorderRadius.circular(6),
          //               ),
          //               constraints: const BoxConstraints(
          //                 minWidth: 14,
          //                 minHeight: 14,
          //               ),
          //               child: Text(
          //                 pending.toString(),
          //                 style: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 8,
          //                 ),
          //                 textAlign: TextAlign.center,
          //               ),
          //             ),
          //           ),
          //       ],
          //     );
          //   }),
          //   onPressed: () => Get.toNamed(AppRoutes.reprintRequests),
          // ),
          // const SizedBox(width: 8),
          // PopupMenuButton(
          //   icon: const Icon(Icons.more_vert),
          //   itemBuilder: (context) =>
          //   [
          //     const PopupMenuItem(
          //       value: 'logout',
          //       child: Row(
          //         children: [
          //           Icon(Icons.logout, color: Colors.red),
          //           SizedBox(width: 8),
          //           Text('Logout', style: TextStyle(color: Colors.red)),
          //         ],
          //       ),
          //     ),
          //   ],
          //   onSelected: (value) {
          //     if (value == 'logout') {
          //       authController.logout();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(AuthController authController) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.admin, AppColors.admin.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.admin.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome Admin!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  authController.currentUser.value?.fullName ?? 'Admin',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'ADMIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideX(begin: -0.2);
  }

  Widget _buildStatsGrid(DashboardController controller) {
    return GridView.count(
      crossAxisCount: responsive!.isMobile ? 2 : 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          'Today\'s Tokens',
          controller.todayChallans.value.toString(),
          Icons.receipt_long,
          AppColors.primary,
          '₹${controller.todayRevenue.value.toStringAsFixed(0)}',
        ),
        _buildStatCard(
          'Total Users',
          controller.totalUsers.value.toString(),
          Icons.people,
          AppColors.success,
          'Active users',
        ),
        _buildStatCard(
          'Month Tokens',
          controller.monthChallans.value.toString(),
          Icons.trending_up,
          AppColors.warning,
          '₹${controller.monthRevenue.value.toStringAsFixed(0)}',
        ),
        _buildStatCard(
          'Pending Reprints',
          controller.pendingReprintRequests.value.toString(),
          Icons.print_disabled,
          AppColors.error,
          'Needs approval',
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildStatCard(String title,
      String value,
      IconData icon,
      Color color,
      String subtitle,) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context,
      TokenController tokenController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: responsive!.isMobile ? 3 : 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _buildActionCard(
              'Create Token',
              Icons.add_circle_outline,
              AppColors.primary,
                  () => _showAddTokenDialog(context, tokenController),
            ),
            _buildActionCard(
              'Manage Users',
              Icons.people_outline,
              AppColors.success,
                  () => Get.toNamed(AppRoutes.userManagement),
            ),
            _buildActionCard(
              'Print Token Report',
              Icons.receipt_long,
              AppColors.secondary,
               () => Get.toNamed(AppRoutes.tokenReport, arguments: {"isAdmin": true}),
            ),
            // _buildActionCard(
            //   'Reprint Requests',
            //   Icons.print,
            //   AppColors.error,
            //       () => Get.toNamed(AppRoutes.reprintRequests),
            // ),
            // _buildActionCard(
            //   'All Challans',
            //   Icons.list_alt,
            //   AppColors.warning,
            //       () => Get.toNamed(AppRoutes.challanAdminList),
            // ),
            _buildActionCard(
              'Reports',
              Icons.assessment,
              AppColors.admin,
                  () => Get.toNamed(AppRoutes.reports),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildActionCard(String title,
      IconData icon,
      Color color,
      VoidCallback onTap,) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentChallansSection(DashboardController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Challans',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.challanList),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.recentChallans.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Column(
                  children: [
                    Icon(Icons.receipt_long,
                        size: 48, color: AppColors.textTertiary),
                    SizedBox(height: 8),
                    Text(
                      'No recent challans',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.recentChallans.length.clamp(0, 5),
            itemBuilder: (context, index) {
              final challan = controller.recentChallans[index];
              return _buildChallanCard(challan);
            },
          );
        }),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildChallanCard(ChallanModel challan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.challanDetail, arguments: challan),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.receipt,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challan.challanNumber ?? 'N/A',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      challan.vehicleNumber ?? 'N/A',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₹${challan.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // void _showAddTokenDialog(BuildContext context, TokenController controller) {
  //   final formKey = GlobalKey<FormState>();
  //   final driverNameController = TextEditingController();
  //   final driverMobileController = TextEditingController();
  //   final vehicleNumberController = TextEditingController();
  //   final materialController = TextEditingController();
  //   final placeController = TextEditingController();
  //
  //   final validFrom = DateTime.now().obs;
  //   final validUntil = DateTime.now().add(const Duration(days: 30)).obs;
  //   final selectedVehicleType = Rx<String?>(null);
  //   final selectedQuantity = Rx<int?>(0);
  //
  //   final vehicleTypes = [
  //     'TRACTOR (100 CFT)',
  //     'MINI HAIVA (150 CFT)',
  //     '06 TAYER (300 CFT)',
  //     '10 TAYER (450 CFT)',
  //     '12 TAYER (600 CFT)',
  //     '14 TAYER (750 CFT)',
  //     '16 TAYER (775 CFT)',
  //     '18 TAYER (800 CFT)',
  //     '22 TAYER (850 CFT)',
  //   ];
  //
  //   final quantities = [0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
  //     550, 600, 650, 700, 750, 800, 850, 900, 950, 1000];
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Add Print Token'),
  //       content: Form(
  //         key: formKey,
  //         child: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.info.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: const Column(
  //                   children: [
  //                     Icon(Icons.info, color: AppColors.info),
  //                     SizedBox(height: 8),
  //                     Text(
  //                       'Token Number & Serial Number will be auto-generated',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         color: AppColors.info,
  //                       ),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               TextFormField(
  //                 controller: driverNameController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Driver Name *',
  //                   prefixIcon: Icon(Icons.person),
  //                   hintText: 'Enter driver name',
  //                 ),
  //                 textCapitalization: TextCapitalization.words,
  //                 validator: (value) {
  //                   if (value == null || value.trim().isEmpty) {
  //                     return 'Driver name is required';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(height: 12),
  //               TextFormField(
  //                 controller: driverMobileController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Driver Mobile No *',
  //                   prefixIcon: Icon(Icons.phone),
  //                   hintText: 'Enter 10 digit mobile number',
  //                 ),
  //                 keyboardType: TextInputType.phone,
  //                 maxLength: 10,
  //                 validator: (value) {
  //                   if (value == null || value.trim().isEmpty) {
  //                     return 'Mobile number is required';
  //                   }
  //                   if (value.trim().length != 10) {
  //                     return 'Mobile number must be 10 digits';
  //                   }
  //                   if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
  //                     return 'Only numbers allowed';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(height: 12),
  //               TextFormField(
  //                 controller: vehicleNumberController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Vehicle Number *',
  //                   prefixIcon: Icon(Icons.local_shipping),
  //                   hintText: 'e.g., GJ01AB1234',
  //                 ),
  //                 textCapitalization: TextCapitalization.characters,
  //                 validator: (value) {
  //                   if (value == null || value.trim().isEmpty) {
  //                     return 'Vehicle number is required';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(height: 12),
  //               Obx(() => DropdownButtonFormField<String>(
  //                 value: selectedVehicleType.value,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Vehicle Type *',
  //                   prefixIcon: Icon(Icons.local_shipping),
  //                 ),
  //                 items: vehicleTypes.map((type) {
  //                   return DropdownMenuItem(
  //                     value: type,
  //                     child: Text(type, style: const TextStyle(fontSize: 13)),
  //                   );
  //                 }).toList(),
  //                 onChanged: (value) {
  //                   selectedVehicleType.value = value;
  //                 },
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Vehicle type is required';
  //                   }
  //                   return null;
  //                 },
  //               )),
  //               const SizedBox(height: 12),
  //               Obx(() => DropdownButtonFormField<int>(
  //                 value: selectedQuantity.value,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Quantity *',
  //                   prefixIcon: Icon(Icons.scale),
  //                 ),
  //                 items: quantities.map((qty) {
  //                   return DropdownMenuItem(
  //                     value: qty,
  //                     child: Text(qty.toString()),
  //                   );
  //                 }).toList(),
  //                 onChanged: (value) {
  //                   selectedQuantity.value = value;
  //                 },
  //                 validator: (value) {
  //                   if (value == null) {
  //                     return 'Quantity is required';
  //                   }
  //                   return null;
  //                 },
  //               )),
  //               const SizedBox(height: 12),
  //               TextFormField(
  //                 controller: placeController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Place',
  //                   prefixIcon: Icon(Icons.location_on),
  //                   hintText: 'Enter place/location',
  //                 ),
  //                 textCapitalization: TextCapitalization.words,
  //               ),
  //               const SizedBox(height: 12),
  //               TextFormField(
  //                 controller: materialController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Material Type',
  //                   prefixIcon: Icon(Icons.inventory_2),
  //                   hintText: 'e.g., Sand, Gravel',
  //                 ),
  //               ),
  //               const SizedBox(height: 16),
  //               Container(
  //                 padding: const EdgeInsets.all(12),
  //                 decoration: BoxDecoration(
  //                   color: AppColors.success.withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     const Text(
  //                       'Validity Period',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 14,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Obx(() => Text(
  //                       'Valid for 30 days from ${validFrom.value.day}/${validFrom.value.month}/${validFrom.value.year}',
  //                       style: const TextStyle(fontSize: 12),
  //                       textAlign: TextAlign.center,
  //                     )),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Get.back(),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () {
  //             if (formKey.currentState!.validate()) {
  //               controller.createToken(
  //                 validFrom: validFrom.value,
  //                 validUntil: validUntil.value,
  //                 driverName: driverNameController.text.trim(),
  //                 driverMobile: driverMobileController.text.trim(),
  //                 vehicleNumber: vehicleNumberController.text.trim().toUpperCase(),
  //                 vehicleType: selectedVehicleType.value,
  //                 quantity: selectedQuantity.value ?? 0,
  //                 place: placeController.text.trim().isNotEmpty
  //                     ? placeController.text.trim()
  //                     : null,
  //                 materialType: materialController.text.trim().isNotEmpty
  //                     ? materialController.text.trim()
  //                     : null,
  //               );
  //             }
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: AppColors.info,
  //             foregroundColor: Colors.white,
  //           ),
  //           child: const Text('Create & Print'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  void _showAddTokenDialog(BuildContext context, TokenController controller) {
    final formKey = GlobalKey<FormState>();
    final driverNameController = TextEditingController();
    final driverMobileController = TextEditingController();
    final vehicleNumberController = TextEditingController();
    final materialController = TextEditingController();
    final placeController = TextEditingController();

    final validFrom = DateTime.now().obs;
    final validUntil = DateTime.now().add(const Duration(days: 30)).obs;
    final selectedVehicleType = Rx<String?>(null);
    // final selectedQuantity = Rx<int?>(0);

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

    // final quantities = [0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
    //   550, 600, 650, 700, 750, 800, 850, 900, 950, 1000];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Print Token'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.info, color: AppColors.info),
                      SizedBox(height: 8),
                      Text(
                        'Token Number & Serial Number will be auto-generated',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.info,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: driverNameController,
                  decoration: const InputDecoration(
                    labelText: 'Driver Name *',
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Enter driver name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Driver name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: driverMobileController,
                  decoration: const InputDecoration(
                    labelText: 'Driver Mobile No *',
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Enter 10 digit mobile number',
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Mobile number is required';
                    }
                    if (value.trim().length != 10) {
                      return 'Mobile number must be 10 digits';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
                      return 'Only numbers allowed';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: vehicleNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Number *',
                    prefixIcon: Icon(Icons.local_shipping),
                    hintText: 'e.g., GJ01AB1234',
                  ),
                  textCapitalization: TextCapitalization.characters, // optional
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vehicle number is required';
                    }
                    return null;
                  },
                )
                ,
                const SizedBox(height: 12),
                Obx(() => DropdownButtonFormField<String>(
                  value: selectedVehicleType.value,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Type *',
                    prefixIcon: Icon(Icons.local_shipping),
                  ),
                  items: vehicleTypes.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type, style: const TextStyle(fontSize: 13)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedVehicleType.value = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle type is required';
                    }
                    return null;
                  },
                )),
                const SizedBox(height: 12),
                // Obx(() => DropdownButtonFormField<int>(
                //   value: selectedQuantity.value,
                //   decoration: const InputDecoration(
                //     labelText: 'Quantity *',
                //     prefixIcon: Icon(Icons.scale),
                //   ),
                //   items: quantities.map((qty) {
                //     return DropdownMenuItem(
                //       value: qty,
                //       child: Text(qty.toString()),
                //     );
                //   }).toList(),
                //   onChanged: (value) {
                //     selectedQuantity.value = value;
                //   },
                //   validator: (value) {
                //     if (value == null) {
                //       return 'Quantity is required';
                //     }
                //     return null;
                //   },
                // )),
                // const SizedBox(height: 12),
                TextFormField(
                  controller: placeController,
                  decoration: const InputDecoration(
                    labelText: 'Place',
                    prefixIcon: Icon(Icons.location_on),
                    hintText: 'Enter place/location',
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: materialController,
                  decoration: const InputDecoration(
                    labelText: 'Material Type',
                    prefixIcon: Icon(Icons.inventory_2),
                    // hintText: 'e.g., Sand, Gravel',
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Validity Period',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Text(
                        'Valid for 30 days from ${validFrom.value.day}/${validFrom.value.month}/${validFrom.value.year}',
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                controller.createToken(
                  validFrom: validFrom.value,
                  validUntil: validUntil.value,
                  driverName: driverNameController.text.trim(),
                  driverMobile: driverMobileController.text.trim(),
                  vehicleNumber: vehicleNumberController.text.trim().toUpperCase(),
                  vehicleType: selectedVehicleType.value,
                  // quantity: selectedQuantity.value ?? 0,
                  place: placeController.text.trim().isNotEmpty
                      ? placeController.text.trim()
                      : null,
                  materialType: materialController.text.trim().isNotEmpty
                      ? materialController.text.trim()
                      : null,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.info,
              foregroundColor: Colors.white,
            ),
            child: const Text('Create & Print'),
          ),
        ],
      ),
    );
  }

}