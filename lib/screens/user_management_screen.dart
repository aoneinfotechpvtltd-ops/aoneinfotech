// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/user_management_controller.dart';
// import '../../controllers/auth_controller.dart';
// import '../model/user_model.dart';
// import '../utilis/app_colors.dart';
//
// class EnhancedUserManagementScreen extends StatelessWidget {
//   const EnhancedUserManagementScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserManagementController());
//     final authController = Get.find<AuthController>();
//     final currentUser = authController.currentUser.value;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Management'),
//         backgroundColor: currentUser?.role == 'super_admin'
//             ? AppColors.superAdmin
//             : AppColors.admin,
//         elevation: 0,
//         actions: [
//           Obx(() => Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             child: Center(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   'Total: ${controller.users.length}',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           )),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Role info banner
//           _buildRoleInfoBanner(currentUser),
//
//           // User list
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (controller.users.isEmpty) {
//                 return _buildEmptyState(currentUser);
//               }
//
//               return RefreshIndicator(
//                 onRefresh: controller.loadUsers,
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: controller.users.length,
//                   itemBuilder: (context, index) {
//                     final user = controller.users[index];
//                     return _buildEnhancedUserCard(user, controller, currentUser!);
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//       floatingActionButton: Obx(() {
//         final canCreate = controller.canCreateUser();
//
//         return FloatingActionButton.extended(
//           onPressed: canCreate
//               ? () => _showAddUserDialog(context, controller, currentUser!)
//               : null,
//           backgroundColor: canCreate
//               ? (currentUser?.role == 'super_admin' ? AppColors.superAdmin : AppColors.admin)
//               : Colors.grey,
//           icon: Icon(canCreate ? Icons.person_add : Icons.block),
//           label: Text(
//             currentUser?.role == 'admin'
//                 ? (controller.userCreationCount.value >= 1
//                 ? 'Limit Reached'
//                 : 'Add User')
//                 : 'Add Admin',
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildRoleInfoBanner(UserModel? currentUser) {
//     Color bgColor;
//     String title;
//     String description;
//     IconData icon;
//
//     if (currentUser?.role == 'super_admin') {
//       bgColor = AppColors.superAdmin;
//       title = 'Super Admin Access';
//       description = 'You can create admins and manage all users';
//       icon = Icons.security;
//     } else {
//       bgColor = AppColors.admin;
//       title = 'Admin Access';
//       description = 'You can create 1 user and manage your users';
//       icon = Icons.admin_panel_settings;
//     }
//
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [bgColor, bgColor.withOpacity(0.7)],
//         ),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: bgColor.withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
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
//             child: Icon(icon, color: Colors.white, size: 28),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   description,
//                   style: const TextStyle(
//                     color: Colors.white70,
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(UserModel? currentUser) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(32),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.people_outline,
//               size: 64,
//               color: Colors.grey[400],
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             currentUser?.role == 'admin'
//                 ? 'No Users Created Yet'
//                 : 'No Users Available',
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: AppColors.textPrimary,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             currentUser?.role == 'admin'
//                 ? 'Create your first user to get started'
//                 : 'Add admins to manage the system',
//             style: const TextStyle(
//               fontSize: 14,
//               color: AppColors.textSecondary,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEnhancedUserCard(
//       UserModel user,
//       UserManagementController controller,
//       UserModel currentUser,
//       ) {
//     Color roleColor = _getRoleColor(user.role);
//     final canDelete = currentUser.role == 'super_admin' ||
//         (currentUser.role == 'admin' && user.createdBy == currentUser.id);
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: roleColor.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.white,
//               roleColor.withOpacity(0.05),
//             ],
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with avatar and status
//             Row(
//               children: [
//                 Hero(
//                   tag: 'user_${user.id}',
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [roleColor, roleColor.withOpacity(0.7)],
//                       ),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: roleColor.withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         user.fullName[0].toUpperCase(),
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.fullName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(Icons.email_outlined, size: 14, color: Colors.grey[600]),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               user.email,
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey[600],
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [roleColor, roleColor.withOpacity(0.8)],
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: roleColor.withOpacity(0.3),
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     user.role.toUpperCase().replaceAll('_', ' '),
//                     style: const TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//             const Divider(height: 1),
//             const SizedBox(height: 16),
//
//             // Details section
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildDetailChip(
//                     user.isActive ? 'Active' : 'Blocked',
//                     user.isActive ? Icons.check_circle : Icons.block,
//                     user.isActive ? AppColors.success : AppColors.error,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 if (user.phone != null)
//                   Expanded(
//                     child: _buildDetailChip(
//                       user.phone!,
//                       Icons.phone,
//                       AppColors.info,
//                     ),
//                   ),
//               ],
//             ),
//
//             const SizedBox(height: 16),
//
//             // Action buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 OutlinedButton.icon(
//                   onPressed: () {
//                     controller.updateUserStatus(
//                       user.id,
//                       user.isActive ? 'blocked' : 'active',
//                     );
//                   },
//                   icon: Icon(
//                     user.isActive ? Icons.block : Icons.check_circle,
//                     size: 18,
//                   ),
//                   label: Text(user.isActive ? 'Block' : 'Activate'),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: user.isActive ? AppColors.error : AppColors.success,
//                     side: BorderSide(
//                       color: user.isActive ? AppColors.error : AppColors.success,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 if (canDelete) ...[
//                   const SizedBox(width: 8),
//                   IconButton(
//                     onPressed: () => _showDeleteConfirmation(controller, user),
//                     icon: const Icon(Icons.delete_outline),
//                     color: AppColors.error,
//                     style: IconButton.styleFrom(
//                       backgroundColor: AppColors.error.withOpacity(0.1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getRoleColor(String role) {
//     switch (role) {
//       case 'super_admin':
//         return AppColors.superAdmin;
//       case 'admin':
//         return AppColors.admin;
//       case 'user':
//         return AppColors.user;
//       default:
//         return AppColors.viewer;
//     }
//   }
//
//   Widget _buildDetailChip(String label, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 8),
//           Flexible(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: color,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showAddUserDialog(
//       BuildContext context,
//       UserManagementController controller,
//       UserModel currentUser,
//       ) {
//     final formKey = GlobalKey<FormState>();
//     final emailController = TextEditingController();
//     final nameController = TextEditingController();
//     final phoneController = TextEditingController();
//     final selectedRole = (currentUser.role == 'admin' ? 'user' : 'admin').obs;
//
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           constraints: const BoxConstraints(maxWidth: 400),
//           child: Form(
//             key: formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: (currentUser.role == 'super_admin'
//                               ? AppColors.superAdmin
//                               : AppColors.admin).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           Icons.person_add,
//                           color: currentUser.role == 'super_admin'
//                               ? AppColors.superAdmin
//                               : AppColors.admin,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               currentUser.role == 'admin' ? 'Add New User' : 'Add New Admin',
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               currentUser.role == 'admin'
//                                   ? 'Create a user account'
//                                   : 'Create an admin account',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//
//                   TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       labelText: 'Full Name *',
//                       prefixIcon: const Icon(Icons.person_outline),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
//                   ),
//                   const SizedBox(height: 16),
//
//                   TextFormField(
//                     controller: emailController,
//                     decoration: InputDecoration(
//                       labelText: 'Email *',
//                       prefixIcon: const Icon(Icons.email_outlined),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (v) {
//                       if (v?.isEmpty ?? true) return 'Required';
//                       if (!v!.contains('@')) return 'Invalid email';
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 16),
//
//                   TextFormField(
//                     controller: phoneController,
//                     decoration: InputDecoration(
//                       labelText: 'Phone',
//                       prefixIcon: const Icon(Icons.phone_outlined),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     keyboardType: TextInputType.phone,
//                   ),
//
//                   if (currentUser.role == 'super_admin') ...[
//                     const SizedBox(height: 16),
//                     Obx(() => DropdownButtonFormField<String>(
//                       value: selectedRole.value,
//                       decoration: InputDecoration(
//                         labelText: 'Role *',
//                         prefixIcon: const Icon(Icons.shield_outlined),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       items: ['admin']
//                           .map((role) => DropdownMenuItem(
//                         value: role,
//                         child: Text(role.toUpperCase()),
//                       ))
//                           .toList(),
//                       onChanged: (value) {
//                         if (value != null) selectedRole.value = value;
//                       },
//                     )),
//                   ],
//
//                   const SizedBox(height: 24),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => Get.back(),
//                         child: const Text('Cancel'),
//                       ),
//                       const SizedBox(width: 12),
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           if (formKey.currentState!.validate()) {
//                             controller.createUser(
//                               email: emailController.text.trim(),
//                               fullName: nameController.text.trim(),
//                               role: selectedRole.value,
//                               phone: phoneController.text.trim().isNotEmpty
//                                   ? phoneController.text.trim()
//                                   : null,
//                             );
//                           }
//                         },
//                         icon: const Icon(Icons.add),
//                         label: const Text('Create'),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: currentUser.role == 'super_admin'
//                               ? AppColors.superAdmin
//                               : AppColors.admin,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showDeleteConfirmation(UserManagementController controller, UserModel user) {
//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: Container(
//           padding: const EdgeInsets.all(24),
//           constraints: const BoxConstraints(maxWidth: 400),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.error.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.delete_forever,
//                   color: AppColors.error,
//                   size: 48,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Delete User',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 'Are you sure you want to delete ${user.fullName}? This action cannot be undone.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => Get.back(),
//                       style: OutlinedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text('Cancel'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         controller.deleteUser(user.id);
//                         Get.back();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.error,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text('Delete'),
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
// }