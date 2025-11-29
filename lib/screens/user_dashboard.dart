// import 'package:aoneinfotech/config/print_pdf.dart';
// import 'package:aoneinfotech/main.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../controllers/auth_controller.dart';
// import '../../controllers/dashboard_controller.dart';
// import '../../controllers/token_controller.dart';
// import '../controllers/user_management_controller.dart';
// import '../routes/app_route.dart';
// import '../utilis/app_colors.dart';
//
// class UserDashboard extends StatelessWidget {
//   const UserDashboard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authController = Get.find<AuthController>();
//     final dashboardController = Get.put(DashboardController());
//     final tokenController = Get.put(TokenController());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Dashboard'),
//         backgroundColor: AppColors.primary,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined),
//             onPressed: () {
//               Get.snackbar(
//                 'Notifications',
//                 'No new notifications',
//                 snackPosition: SnackPosition.BOTTOM,
//               );
//             },
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
//               }
//             },
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           await dashboardController.loadDashboardData();
//           await tokenController.loadTokens();
//         },
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildWelcomeCard(authController),
//               const SizedBox(height: 20),
//               Obx(() => _buildStatsGrid(dashboardController)),
//               const SizedBox(height: 20),
//               _buildQuickActions(context, tokenController),
//               // const SizedBox(height: 20),
//               // _buildTokensSection(tokenController),
//               // const SizedBox(height: 20),
//               // _buildRecentChallansSection(dashboardController),
//               SizedBox(height: 150,)
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: 'token',
//             onPressed: () => _showAddTokenDialog(context, tokenController),
//             backgroundColor: AppColors.info,
//             child: const Icon(Icons.token),
//             tooltip: 'Create Token',
//           ).animate().scale(delay: 400.ms),
//           const SizedBox(height: 12),
//           FloatingActionButton.extended(
//             heroTag: 'challan',
//             onPressed: () => Get.toNamed(AppRoutes.createChallan),
//             backgroundColor: AppColors.primary,
//             icon: const Icon(Icons.add),
//             label: const Text('New Challan'),
//           ).animate().scale(delay: 500.ms),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWelcomeCard(AuthController authController) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: AppColors.primaryGradient,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.primary.withOpacity(0.3),
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
//               Icons.person,
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
//                   'Welcome Back!',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   authController.currentUser.value?.fullName ?? 'User',
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
//               'USER',
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
//   Widget _buildStatsGrid(DashboardController controller) {
//     return GridView.count(
//       crossAxisCount: responsive!.isMobile?2:3,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       mainAxisSpacing: 16,
//       crossAxisSpacing: 16,
//       childAspectRatio: 1.5,
//       children: [
//         _buildStatCard(
//           'Today\'s Challans',
//           controller.todayChallans.value.toString(),
//           Icons.receipt_long,
//           AppColors.primary,
//         ),
//         _buildStatCard(
//           'This Week',
//           controller.weekChallans.value.toString(),
//           Icons.calendar_today,
//           AppColors.success,
//         ),
//         _buildStatCard(
//           'This Month',
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
//       ],
//     ).animate().fadeIn(delay: 200.ms);
//   }
//
//   Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
//         crossAxisAlignment: CrossAxisAlignment.start,
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
//             style: const TextStyle(
//               fontSize: 12,
//               color: AppColors.textSecondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQuickActions(BuildContext context, TokenController tokenController) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Quick Actions',
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
//               'Create Challan',
//               Icons.add_circle_outline,
//               AppColors.primary,
//                   () => Get.toNamed(AppRoutes.createChallan),
//             ),
//             _buildActionCard(
//               'Create Token',
//               Icons.token,
//               AppColors.info,
//                   () => _showAddTokenDialog(context, tokenController),
//             ),
//             _buildActionCard(
//               'View Challans',
//               Icons.list_alt,
//               AppColors.success,
//                   () => Get.toNamed(AppRoutes.challanList),
//             ),
//             _buildActionCard(
//               'My Tokens',
//               Icons.verified,
//               AppColors.secondary,
//                   () => Get.toNamed(AppRoutes.tokenManagement),
//             ),
//             _buildActionCard(
//               'Print Token Report',
//               Icons.token,
//               AppColors.secondary,
//                   () => Get.toNamed(AppRoutes.tokenReport),
//             ),
//             _buildActionCard(
//               'Reports',
//               Icons.bar_chart,
//               AppColors.warning,
//                   () => Get.toNamed(AppRoutes.reports),
//             ),
//             _buildActionCard(
//               'Help',
//               Icons.help_outline,
//               AppColors.textSecondary,
//                   () {
//                 Get.snackbar(
//                   'Help',
//                   'Contact your admin for assistance',
//                   snackPosition: SnackPosition.BOTTOM,
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     ).animate().fadeIn(delay: 300.ms);
//   }
//
//   Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
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
//               child: Icon(icon, color: color, size: 28),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 11,
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
//   Widget _buildTokensSection(TokenController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'My Tokens',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             TextButton(
//               onPressed: () => Get.toNamed(AppRoutes.tokenManagement),
//               child: const Text('View All'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (controller.tokens.isEmpty) {
//             return Container(
//               padding: const EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Center(
//                 child: Column(
//                   children: [
//                     const Icon(Icons.token, size: 48, color: AppColors.textTertiary),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'No tokens yet',
//                       style: TextStyle(color: AppColors.textSecondary),
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton.icon(
//                       onPressed: () => _showAddTokenDialog(Get.context!, controller),
//                       icon: const Icon(Icons.add),
//                       label: const Text('Create Your First Token'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.info,
//                         foregroundColor: Colors.white,
//                       ),
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
//             itemCount: controller.tokens.length.clamp(0, 3),
//             itemBuilder: (context, index) {
//               final token = controller.tokens[index];
//               return _buildTokenCard(token, controller);
//             },
//           );
//         }),
//       ],
//     ).animate().fadeIn(delay: 400.ms);
//   }
//
//   Widget _buildTokenCard(dynamic token, TokenController controller) {
//     // final isValid = token.validUntil;
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: ( AppColors.success ).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(
//                 Icons.token,
//                 color:  AppColors.success ,
//                 size: 24,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     token.tokenNumber,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     token.vehicleNumber ?? 'No vehicle',
//                     style: const TextStyle(
//                       color: AppColors.textSecondary,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color: ( AppColors.success ).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     token.statusDisplay,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: AppColors.success ,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 IconButton(
//                   onPressed: () => generateTokenPDF(token),
//                   icon: const Icon(Icons.print),
//                   color: AppColors.primary,
//                   iconSize: 20,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecentChallansSection(DashboardController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Recent Challans',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//             TextButton(
//               onPressed: () => Get.toNamed(AppRoutes.challanList),
//               child: const Text('View All'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (controller.recentChallans.isEmpty) {
//             return Container(
//               padding: const EdgeInsets.all(32),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Center(
//                 child: Column(
//                   children: [
//                     Icon(Icons.receipt_long, size: 48, color: AppColors.textTertiary),
//                     SizedBox(height: 8),
//                     Text(
//                       'No challans yet',
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
//             itemCount: controller.recentChallans.length.clamp(0, 5),
//             itemBuilder: (context, index) {
//               final challan = controller.recentChallans[index];
//               return _buildChallanCard(challan);
//             },
//           );
//         }),
//       ],
//     ).animate().fadeIn(delay: 500.ms);
//   }
//
//   Widget _buildChallanCard(dynamic challan) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: InkWell(
//         onTap: () => Get.toNamed(AppRoutes.challanDetail, arguments: challan),
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(
//                   Icons.receipt,
//                   color: AppColors.primary,
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       challan.challanNumber ?? 'N/A',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       challan.vehicleNumber ?? 'N/A',
//                       style: const TextStyle(
//                         color: AppColors.textSecondary,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     '₹${challan.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: AppColors.success,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.success.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       'Active',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: AppColors.success,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   void _showAddTokenDialog(BuildContext context, TokenController controller) {
//     final formKey = GlobalKey<FormState>();
//     final driverNameController = TextEditingController();
//     final driverMobileController = TextEditingController();
//     final vehicleNumberController = TextEditingController();
//     final materialController = TextEditingController();
//     final placeController = TextEditingController();
//
//     final validFrom = DateTime.now().obs;
//     final validUntil = DateTime.now().add(const Duration(days: 30)).obs;
//     final selectedVehicleType = Rx<String?>(null);
//     final selectedQuantity = Rx<int?>(0);
//
//     // Vehicle types list
//     final vehicleTypes = [
//       'TRACTOR (100 CFT)',
//       'MINI HAIVA (150 CFT)',
//       '06 TAYER (300 CFT)',
//       '10 TAYER (450 CFT)',
//       '12 TAYER (600 CFT)',
//       '14 TAYER (750 CFT)',
//       '16 TAYER (775 CFT)',
//       '18 TAYER (800 CFT)',
//       '22 TAYER (850 CFT)',
//     ];
//
//     // Quantity list
//     final quantities = [0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
//       550, 600, 650, 700, 750, 800, 850, 900, 950, 1000];
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add Print Token'),
//         content: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.info.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Column(
//                     children: [
//                       Icon(Icons.info, color: AppColors.info),
//                       SizedBox(height: 8),
//                       Text(
//                         'Token Number & Serial Number will be auto-generated',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: AppColors.info,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Driver Name
//                 TextFormField(
//                   controller: driverNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Driver Name *',
//                     prefixIcon: Icon(Icons.person),
//                     hintText: 'Enter driver name',
//                   ),
//                   textCapitalization: TextCapitalization.words,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Driver name is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//
//                 // Driver Mobile
//                 TextFormField(
//                   controller: driverMobileController,
//                   decoration: const InputDecoration(
//                     labelText: 'Driver Mobile No *',
//                     prefixIcon: Icon(Icons.phone),
//                     hintText: 'Enter 10 digit mobile number',
//                   ),
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Mobile number is required';
//                     }
//                     if (value.trim().length != 10) {
//                       return 'Mobile number must be 10 digits';
//                     }
//                     if (!RegExp(r'^[0-9]+$').hasMatch(value.trim())) {
//                       return 'Only numbers allowed';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//
//                 // Vehicle Number
//                 TextFormField(
//                   controller: vehicleNumberController,
//                   decoration: const InputDecoration(
//                     labelText: 'Vehicle Number *',
//                     prefixIcon: Icon(Icons.local_shipping),
//                     hintText: 'e.g., GJ01AB1234',
//                   ),
//                   textCapitalization: TextCapitalization.characters,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Vehicle number is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//
//                 // Vehicle Type Dropdown
//                 Obx(() => DropdownButtonFormField<String>(
//                   value: selectedVehicleType.value,
//                   decoration: const InputDecoration(
//                     labelText: 'Vehicle Type *',
//                     prefixIcon: Icon(Icons.local_shipping),
//                   ),
//                   items: vehicleTypes.map((type) {
//                     return DropdownMenuItem(
//                       value: type,
//                       child: Text(type, style: const TextStyle(fontSize: 13)),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     selectedVehicleType.value = value;
//                   },
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Vehicle type is required';
//                     }
//                     return null;
//                   },
//                 )),
//                 const SizedBox(height: 12),
//
//                 // Quantity Dropdown
//                 Obx(() => DropdownButtonFormField<int>(
//                   value: selectedQuantity.value,
//                   decoration: const InputDecoration(
//                     labelText: 'Quantity *',
//                     prefixIcon: Icon(Icons.scale),
//                   ),
//                   items: quantities.map((qty) {
//                     return DropdownMenuItem(
//                       value: qty,
//                       child: Text(qty.toString()),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     selectedQuantity.value = value;
//                   },
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Quantity is required';
//                     }
//                     return null;
//                   },
//                 )),
//                 const SizedBox(height: 12),
//
//                 // Place
//                 TextFormField(
//                   controller: placeController,
//                   decoration: const InputDecoration(
//                     labelText: 'Place',
//                     prefixIcon: Icon(Icons.location_on),
//                     hintText: 'Enter place/location',
//                   ),
//                   textCapitalization: TextCapitalization.words,
//                 ),
//                 const SizedBox(height: 12),
//
//                 // Material Type
//                 TextFormField(
//                   controller: materialController,
//                   decoration: const InputDecoration(
//                     labelText: 'Material Type',
//                     prefixIcon: Icon(Icons.inventory_2),
//                     hintText: 'e.g., Sand, Gravel',
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.success.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     children: [
//                       const Text(
//                         'Validity Period',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Obx(() => Text(
//                         'Valid for 30 days from ${validFrom.value.day}/${validFrom.value.month}/${validFrom.value.year}',
//                         style: const TextStyle(fontSize: 12),
//                         textAlign: TextAlign.center,
//                       )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (formKey.currentState!.validate()) {
//                 controller.createToken(
//                   validFrom: validFrom.value,
//                   validUntil: validUntil.value,
//                   driverName: driverNameController.text.trim(),
//                   driverMobile: driverMobileController.text.trim(),
//                   vehicleNumber: vehicleNumberController.text.trim().toUpperCase(),
//                   vehicleType: selectedVehicleType.value,
//                   quantity: selectedQuantity.value ?? 0,
//                   place: placeController.text.trim().isNotEmpty
//                       ? placeController.text.trim()
//                       : null,
//                   materialType: materialController.text.trim().isNotEmpty
//                       ? materialController.text.trim()
//                       : null,
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.info,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Create & Print'),
//           ),
//         ],
//       ),
//     );
//   }
//   // void _showAddTokenDialog(BuildContext context, TokenController controller) {
//   //   final formKey = GlobalKey<FormState>();
//   //   final vehicleNumberController = TextEditingController();
//   //   final weightController = TextEditingController();
//   //   final materialController = TextEditingController();
//   //   final validFrom = DateTime.now().obs;
//   //   final validUntil = DateTime.now().add(const Duration(days: 30)).obs;
//   //
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: const Text('Create New Token'),
//   //       content: Form(
//   //         key: formKey,
//   //         child: SingleChildScrollView(
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               Container(
//   //                 padding: const EdgeInsets.all(12),
//   //                 decoration: BoxDecoration(
//   //                   color: AppColors.info.withOpacity(0.1),
//   //                   borderRadius: BorderRadius.circular(8),
//   //                 ),
//   //                 child: const Column(
//   //                   children: [
//   //                     Icon(Icons.info, color: AppColors.info),
//   //                     SizedBox(height: 8),
//   //                     Text(
//   //                       'Token Number & Serial Number will be auto-generated',
//   //                       style: TextStyle(
//   //                         fontSize: 12,
//   //                         color: AppColors.info,
//   //                       ),
//   //                       textAlign: TextAlign.center,
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ),
//   //               const SizedBox(height: 16),
//   //               TextFormField(
//   //                 controller: vehicleNumberController,
//   //                 decoration: const InputDecoration(
//   //                   labelText: 'Vehicle Number',
//   //                   prefixIcon: Icon(Icons.local_shipping),
//   //                   hintText: 'e.g., GJ01AB1234',
//   //                 ),
//   //                 textCapitalization: TextCapitalization.characters,
//   //               ),
//   //               const SizedBox(height: 12),
//   //               TextFormField(
//   //                 controller: materialController,
//   //                 decoration: const InputDecoration(
//   //                   labelText: 'Material Type',
//   //                   prefixIcon: Icon(Icons.inventory_2),
//   //                   hintText: 'e.g., Sand, Gravel',
//   //                 ),
//   //               ),
//   //               const SizedBox(height: 12),
//   //               TextFormField(
//   //                 controller: weightController,
//   //                 decoration: const InputDecoration(
//   //                   labelText: 'Weight (Kg)',
//   //                   prefixIcon: Icon(Icons.scale),
//   //                 ),
//   //                 keyboardType: TextInputType.number,
//   //               ),
//   //               const SizedBox(height: 16),
//   //               Container(
//   //                 padding: const EdgeInsets.all(12),
//   //                 decoration: BoxDecoration(
//   //                   color: AppColors.success.withOpacity(0.1),
//   //                   borderRadius: BorderRadius.circular(8),
//   //                 ),
//   //                 child: Column(
//   //                   children: [
//   //                     const Text(
//   //                       'Validity Period',
//   //                       style: TextStyle(
//   //                         fontWeight: FontWeight.bold,
//   //                         fontSize: 14,
//   //                       ),
//   //                     ),
//   //                     const SizedBox(height: 8),
//   //                     Obx(() => Text(
//   //                       'Valid for 30 days from ${validFrom.value.day}/${validFrom.value.month}/${validFrom.value.year}',
//   //                       style: const TextStyle(fontSize: 12),
//   //                       textAlign: TextAlign.center,
//   //                     )),
//   //                   ],
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () => Get.back(),
//   //           child: const Text('Cancel'),
//   //         ),
//   //         ElevatedButton(
//   //           onPressed: () {
//   //             if (formKey.currentState!.validate()) {
//   //               controller.createToken(
//   //                 validFrom: validFrom.value,
//   //                 validUntil: validUntil.value,
//   //                 vehicleNumber: vehicleNumberController.text.trim().isNotEmpty
//   //                     ? vehicleNumberController.text.trim().toUpperCase()
//   //                     : null,
//   //                 weightInKg: weightController.text.trim().isNotEmpty
//   //                     ? double.tryParse(weightController.text.trim())
//   //                     : null,
//   //                 materialType: materialController.text.trim().isNotEmpty
//   //                     ? materialController.text.trim()
//   //                     : null,
//   //               );
//   //             }
//   //           },
//   //           style: ElevatedButton.styleFrom(
//   //             backgroundColor: AppColors.info,
//   //             foregroundColor: Colors.white,
//   //           ),
//   //           child: const Text('Create & Print'),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//
// }
import 'package:aoneinfotech/config/print_pdf.dart';
import 'package:aoneinfotech/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/dashboard_controller.dart';
import '../../controllers/token_controller.dart';
import '../controllers/user_management_controller.dart';
import '../routes/app_route.dart';
import '../utilis/app_colors.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final dashboardController = Get.put(DashboardController());
    final tokenController = Get.put(TokenController());

    return Scaffold(
      body: Row(
        children: [
          // Permanent Sidebar
          _buildPermanentSidebar(authController, tokenController),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // AppBar
                _buildAppBar(authController),

                // Content
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await dashboardController.loadDashboardData();
                      await tokenController.loadTokens();
                    },
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

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'token',
            onPressed: () => _showAddTokenDialog(context, tokenController),
            backgroundColor: AppColors.info,
            child: const Icon(Icons.token),
            tooltip: 'Create Token',
          ).animate().scale(delay: 400.ms),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'challan',
            onPressed: () => Get.toNamed(AppRoutes.createChallan),
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.add),
            label: const Text('New Challan'),
          ).animate().scale(delay: 500.ms),
        ],
      ),
    );
  }

  // Permanent Sidebar with White Theme
  Widget _buildPermanentSidebar(AuthController authController, TokenController tokenController) {
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
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // User Avatar
                CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    authController.currentUser.value?.fullName?[0].toUpperCase() ?? 'U',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // User Name
                Text(
                  authController.currentUser.value?.fullName ?? 'User',
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

                // User Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'USER',
                    style: TextStyle(
                      color: AppColors.primary,
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
                  onTap: () {},
                  isActive: true,
                ),
                _buildSidebarItem(
                  icon: Icons.receipt_long,
                  title: 'Print Token Report',
                  onTap: () => Get.toNamed(AppRoutes.tokenReport, arguments: {"isAdmin": false}),
                ),
                _buildSidebarItem(
                  icon: Icons.verified,
                  title: 'My Tokens',
                  onTap: () => Get.toNamed(AppRoutes.tokenManagement),
                ),
                _buildSidebarItem(
                  icon: Icons.list_alt,
                  title: 'View Challans',
                  onTap: () => Get.toNamed(AppRoutes.challanList),
                ),
                _buildSidebarItem(
                  icon: Icons.bar_chart,
                  title: 'Reports',
                  onTap: () => Get.toNamed(AppRoutes.reports),
                ),

                const Divider(height: 24, thickness: 1, color: Color(0xFFE0E0E0)),

                _buildSidebarItem(
                  icon: Icons.add_circle_outline,
                  title: 'Create Challan',
                  onTap: () => Get.toNamed(AppRoutes.createChallan),
                ),
                _buildSidebarItem(
                  icon: Icons.token,
                  title: 'Create Token',
                  onTap: () {
                    final tokenController = Get.find<TokenController>();
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
                // _buildSidebarItem(
                //   icon: Icons.help_outline,
                //   title: 'Help',
                //   onTap: () {
                //     Get.snackbar(
                //       'Help',
                //       'Contact your admin for assistance',
                //       snackPosition: SnackPosition.BOTTOM,
                //     );
                //   },
                // ),
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
                  ? AppColors.primary.withOpacity(0.1)
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
                      ? AppColors.primary
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
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // AppBar
  Widget _buildAppBar(AuthController authController) {
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
            'User Dashboard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          // IconButton(
          //   icon: const Icon(Icons.notifications_outlined),
          //   onPressed: () {
          //     Get.snackbar(
          //       'Notifications',
          //       'No new notifications',
          //       snackPosition: SnackPosition.BOTTOM,
          //     );
          //   },
          // ),
          const SizedBox(width: 8),
          // PopupMenuButton(
          //   icon: const Icon(Icons.more_vert),
          //   itemBuilder: (context) => [
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
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
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
              Icons.person,
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
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  authController.currentUser.value?.fullName ?? 'User',
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
              'USER',
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
          'Today\'s Challans',
          controller.todayChallans.value.toString(),
          Icons.receipt_long,
          AppColors.primary,
        ),
        _buildStatCard(
          'This Week',
          controller.weekChallans.value.toString(),
          Icons.calendar_today,
          AppColors.success,
        ),
        _buildStatCard(
          'This Month',
          controller.monthChallans.value.toString(),
          Icons.trending_up,
          AppColors.warning,
        ),
        _buildStatCard(
          'Total Challans',
          controller.totalChallans.value.toString(),
          Icons.bar_chart,
          AppColors.info,
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, TokenController tokenController) {
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
              'Create Challan',
              Icons.add_circle_outline,
              AppColors.primary,
                  () => Get.toNamed(AppRoutes.createChallan),
            ),
            _buildActionCard(
              'Create Token',
              Icons.token,
              AppColors.info,
                  () => _showAddTokenDialog(context, tokenController),
            ),
            _buildActionCard(
              'View Challans',
              Icons.list_alt,
              AppColors.success,
                  () => Get.toNamed(AppRoutes.challanList),
            ),
            _buildActionCard(
              'My Tokens',
              Icons.verified,
              AppColors.secondary,
                  () => Get.toNamed(AppRoutes.tokenManagement),
            ),
            _buildActionCard(
              'Print Token Report',
              Icons.receipt_long,
              AppColors.secondary,
              () => Get.toNamed(AppRoutes.tokenReport, arguments: {"isAdmin": false}),
            ),
            _buildActionCard(
              'Reports',
              Icons.bar_chart,
              AppColors.warning,
                  () => Get.toNamed(AppRoutes.reports),
            ),
            // _buildActionCard(
            //   'Help',
            //   Icons.help_outline,
            //   AppColors.textSecondary,
            //       () {
            //     Get.snackbar(
            //       'Help',
            //       'Contact your admin for assistance',
            //       snackPosition: SnackPosition.BOTTOM,
            //     );
            //   },
            // ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
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
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
    final selectedQuantity = Rx<int?>(0);

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

    final quantities = [0, 50, 100, 150, 200, 250, 300, 350, 400, 450, 500,
      550, 600, 650, 700, 750, 800, 850, 900, 950, 1000];

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
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vehicle number is required';
                    }
                    return null;
                  },
                ),
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
                Obx(() => DropdownButtonFormField<int>(
                  value: selectedQuantity.value,
                  decoration: const InputDecoration(
                    labelText: 'Quantity *',
                    prefixIcon: Icon(Icons.scale),
                  ),
                  items: quantities.map((qty) {
                    return DropdownMenuItem(
                      value: qty,
                      child: Text(qty.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedQuantity.value = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Quantity is required';
                    }
                    return null;
                  },
                )),
                const SizedBox(height: 12),
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
                    hintText: 'e.g., Sand, Gravel',
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
                  quantity: selectedQuantity.value ?? 0,
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