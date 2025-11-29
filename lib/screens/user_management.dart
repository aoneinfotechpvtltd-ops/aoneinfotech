import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../controllers/user_management_controller.dart';
import '../../controllers/token_controller.dart';
import '../config/print_pdf.dart';
import '../controllers/auth_controller.dart';
import '../model/user_model.dart';
import '../utilis/app_colors.dart';

// USER MANAGEMENT SCREEN
// class UserManagementScreen extends StatelessWidget {
//   const UserManagementScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<UserManagementController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Management'),
//         backgroundColor: AppColors.primary,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.loadUsers,
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: controller.users.length,
//             itemBuilder: (context, index) {
//               final user = controller.users[index];
//               return _buildUserCard(user, controller);
//             },
//           ),
//         );
//       }),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showAddUserDialog(context, controller),
//         backgroundColor: AppColors.primary,
//         icon: const Icon(Icons.add),
//         label: const Text('Add User'),
//       ),
//     );
//   }
//
//   Widget _buildUserCard(UserModel user, UserManagementController controller) {
//     Color roleColor;
//     switch (user.role) {
//       case 'super_admin':
//         roleColor = AppColors.superAdmin;
//         break;
//       case 'admin':
//         roleColor = AppColors.admin;
//         break;
//       case 'user':
//         roleColor = AppColors.user;
//         break;
//       default:
//         roleColor = AppColors.viewer;
//     }
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: roleColor.withOpacity(0.1),
//                   child: Text(
//                     user.fullName[0].toUpperCase(),
//                     style: TextStyle(
//                       color: roleColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.fullName,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         user.email,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: roleColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     user.role.toUpperCase().replaceAll('_', ' '),
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: roleColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInfoChip(
//                     user.isActive ? 'Active' : 'Blocked',
//                     user.isActive ? Icons.check_circle : Icons.block,
//                     user.isActive ? AppColors.success : AppColors.error,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 if (user.phone != null)
//                   Expanded(
//                     child: _buildInfoChip(
//                       user.phone!,
//                       Icons.phone,
//                       AppColors.info,
//                     ),
//                   ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton.icon(
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
//                   style: TextButton.styleFrom(
//                     foregroundColor:
//                     user.isActive ? AppColors.error : AppColors.success,
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   onPressed: () => _showDeleteConfirmation(controller, user),
//                   icon: const Icon(Icons.delete_outline),
//                   color: AppColors.error,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoChip(String label, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 6),
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
//   // void _showAddUserDialog(BuildContext context, UserManagementController controller) {
//   //   final formKey = GlobalKey<FormState>();
//   //   final emailController = TextEditingController();
//   //   final nameController = TextEditingController();
//   //   final phoneController = TextEditingController();
//   //   final selectedRole = 'user'.obs;
//   //
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //       title: const Text('Add New User'),
//   //       content: Form(
//   //         key: formKey,
//   //         child: SingleChildScrollView(
//   //           child: Column(
//   //             mainAxisSize: MainAxisSize.min,
//   //             children: [
//   //               TextFormField(
//   //                 controller: nameController,
//   //                 decoration: const InputDecoration(
//   //                   labelText: 'Full Name *',
//   //                   prefixIcon: Icon(Icons.person),
//   //                 ),
//   //                 validator: (v) =>
//   //                 v?.isEmpty ?? true ? 'Required' : null,
//   //               ),
//   //               const SizedBox(height: 16),
//   //               TextFormField(
//   //                 controller: emailController,
//   //                 decoration: const InputDecoration(
//   //                   labelText: 'Email *',
//   //                   prefixIcon: Icon(Icons.email),
//   //                 ),
//   //                 keyboardType: TextInputType.emailAddress,
//   //                 validator: (v) {
//   //                   if (v?.isEmpty ?? true) return 'Required';
//   //                   if (!v!.contains('@')) return 'Invalid email';
//   //                   return null;
//   //                 },
//   //               ),
//   //               const SizedBox(height: 16),
//   //               TextFormField(
//   //                 controller: phoneController,
//   //                 decoration: const InputDecoration(
//   //                   labelText: 'Phone',
//   //                   prefixIcon: Icon(Icons.phone),
//   //                 ),
//   //                 keyboardType: TextInputType.phone,
//   //               ),
//   //               const SizedBox(height: 16),
//   //               Obx(() => DropdownButtonFormField<String>(
//   //                 value: selectedRole.value,
//   //                 decoration: const InputDecoration(
//   //                   labelText: 'Role *',
//   //                   prefixIcon: Icon(Icons.shield),
//   //                 ),
//   //                 items: ['user', 'admin']
//   //                     .map((role) => DropdownMenuItem(
//   //                   value: role,
//   //                   child: Text(role.toUpperCase()),
//   //                 ))
//   //                     .toList(),
//   //                 onChanged: (value) {
//   //                   if (value != null) selectedRole.value = value;
//   //                 },
//   //               )),
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
//   //               controller.createUser(
//   //                 email: emailController.text.trim(),
//   //                 fullName: nameController.text.trim(),
//   //                 role: selectedRole.value,
//   //                 phone: phoneController.text.trim().isNotEmpty
//   //                     ? phoneController.text.trim()
//   //                     : null,
//   //               );
//   //             }
//   //           },
//   //           style: ElevatedButton.styleFrom(
//   //             backgroundColor: AppColors.primary,
//   //             foregroundColor: Colors.white,
//   //           ),
//   //           child: const Text('Add User'),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   void _showAddUserDialog(
//       BuildContext context,
//       UserManagementController controller,
//       ) {
//     final formKey = GlobalKey<FormState>();
//     final emailController = TextEditingController();
//     final nameController = TextEditingController();
//     final phoneController = TextEditingController();
//     final companyController = TextEditingController();
//     final passwordController = TextEditingController();   // 👈 NEW
//     final selectedRole = 'user'.obs;
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add New User'),
//         content: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Full Name
//                 TextFormField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Full Name *',
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Email
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email *',
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (v) {
//                     if (v?.isEmpty ?? true) return 'Required';
//                     if (!v!.contains('@')) return 'Invalid email';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Password
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password *',
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                   obscureText: true,
//                   validator: (v) {
//                     if (v?.isEmpty ?? true) return 'Required';
//                     if (v!.length < 6) return 'Minimum 6 characters';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Phone (Optional)
//                 TextFormField(
//                   controller: phoneController,
//                   decoration: const InputDecoration(
//                     labelText: 'Phone (Optional)',
//                     prefixIcon: Icon(Icons.phone),
//                   ),
//                   keyboardType: TextInputType.phone,
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Company Name (Optional)
//                 TextFormField(
//                   controller: companyController,
//                   decoration: const InputDecoration(
//                     labelText: 'Company Name (Optional)',
//                     prefixIcon: Icon(Icons.business),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Role
//                 Obx(
//                       () => DropdownButtonFormField<String>(
//                     value: selectedRole.value,
//                     decoration: const InputDecoration(
//                       labelText: 'Role *',
//                       prefixIcon: Icon(Icons.shield),
//                     ),
//                     items: ['user']
//                         .map(
//                           (role) => DropdownMenuItem(
//                         value: role,
//                         child: Text(role.toUpperCase()),
//                       ),
//                     )
//                         .toList(),
//                     onChanged: (value) {
//                       if (value != null) selectedRole.value = value;
//                     },
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
//                 controller.createUser(
//                   email: emailController.text.trim(),
//                   fullName: nameController.text.trim(),
//                   role: selectedRole.value,
//                   password: passwordController.text.trim(),          // 👈 HERE
//                   phone: phoneController.text.trim().isNotEmpty
//                       ? phoneController.text.trim()
//                       : null,
//                   companyName: companyController.text.trim().isNotEmpty
//                       ? companyController.text.trim()
//                       : null,
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primary,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Add User'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showDeleteConfirmation(UserManagementController controller, UserModel user) {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Delete User'),
//         content: Text('Are you sure you want to delete ${user.fullName}?'),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               controller.deleteUser(user.id);
//               Get.back();
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.error,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class UserManagementScreen extends StatelessWidget {
//   const UserManagementScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserManagementController());
//     final authController = Get.find<AuthController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Management'),
//         backgroundColor: AppColors.primary,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => controller.loadUsers(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         final regularUsers = controller.users
//             .where((u) => u.role == 'user')
//             .toList();
//
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (regularUsers.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.people_outline,
//                   size: 64,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'No Users Found',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.loadUsers,
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: regularUsers.length,
//             itemBuilder: (context, index) {
//               final user = regularUsers[index];
//               final isCompany = user.userType == 'company';
//
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12.withOpacity(0.05),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 48,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: (isCompany ? Colors.orange : AppColors.primary)
//                             .withOpacity(0.1),
//                       ),
//                       alignment: Alignment.center,
//                       child: Icon(
//                         isCompany ? Icons.business : Icons.person,
//                         color: isCompany ? Colors.orange : AppColors.primary,
//                         size: 24,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             user.fullName,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             user.email,
//                             style: const TextStyle(fontSize: 13),
//                           ),
//                           if (user.phone != null) ...[
//                             const SizedBox(height: 4),
//                             Text(
//                               user.phone!,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                           ],
//                           if (user.companyName != null) ...[
//                             const SizedBox(height: 4),
//                             Row(
//                               children: [
//                                 Icon(
//                                   Icons.business,
//                                   size: 12,
//                                   color: Colors.grey[600],
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   user.companyName!,
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey[600],
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: (isCompany ? Colors.orange : AppColors.primary)
//                                 .withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             isCompany ? 'COMPANY' : 'USER',
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: isCompany ? Colors.orange : AppColors.primary,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         if (authController.currentUser.value?.role == 'admin')
//                           GestureDetector(
//                             onTap: () => controller.deleteUser(user.id),
//                             child: Icon(
//                               Icons.delete_outline,
//                               color: AppColors.error,
//                               size: 22,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//       floatingActionButton: Obx(() {
//         final currentUser = authController.currentUser.value;
//         if (currentUser?.role == 'admin' && controller.canCreateUser()) {
//           return FloatingActionButton.extended(
//             onPressed: () => _showCreateUserDialog(context, controller),
//             backgroundColor: AppColors.primary,
//             icon: const Icon(Icons.person_add),
//             label: Text(
//               'Add User/Company (${controller.userCreationCount.value}/2)',
//             ),
//           );
//         }
//         return const SizedBox.shrink();
//       }),
//     );
//   }
//
//   void _showCreateUserDialog(
//       BuildContext context, UserManagementController controller) {
//     final formKey = GlobalKey<FormState>();
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final fullNameController = TextEditingController();
//     final phoneController = TextEditingController();
//     final companyNameController = TextEditingController();
//
//     final RxString selectedUserType = 'user'.obs;
//      Rxn<String> selectedCompany = Rxn<String>();
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add User or Company'),
//         content: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Obx(() => Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // User Type Dropdown
//                 DropdownButtonFormField<String>(
//                   value: selectedUserType.value,
//                   decoration: const InputDecoration(
//                     labelText: 'Type *',
//                     prefixIcon: Icon(Icons.category),
//                   ),
//                   items: [
//                     const DropdownMenuItem(
//                       value: 'user',
//                       child: Text('User'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'company',
//                       enabled: controller.canCreateCompany(),
//                       child: Row(
//                         children: [
//                           const Text('Company'),
//                           if (!controller.canCreateCompany())
//                             const Text(
//                               ' (Limit Reached)',
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.red,
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                   onChanged: (value) {
//                     if (value != null) {
//                       selectedUserType.value = value;
//                       selectedCompany.value = null;
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 12),
//
//                 TextFormField(
//                   controller: fullNameController,
//                   decoration: InputDecoration(
//                     labelText: selectedUserType.value == 'company'
//                         ? 'Contact Person Name *'
//                         : 'Full Name *',
//                     prefixIcon: const Icon(Icons.person),
//                   ),
//                   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 12),
//
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email *',
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (v) {
//                     if (v?.isEmpty ?? true) return 'Required';
//                     if (!GetUtils.isEmail(v!)) return 'Invalid email';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//
//                 TextFormField(
//                   controller: phoneController,
//                   decoration: const InputDecoration(
//                     labelText: 'Phone *',
//                     prefixIcon: Icon(Icons.phone),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 12),
//
//                 // Company Name Field (only for new company)
//                 if (selectedUserType.value == 'company')
//                   TextFormField(
//                     controller: companyNameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Company Name *',
//                       prefixIcon: Icon(Icons.business),
//                     ),
//                     validator: (v) {
//                       if (selectedUserType.value == 'company') {
//                         return v?.isEmpty ?? true ? 'Required' : null;
//                       }
//                       return null;
//                     },
//                   ),
//
//                 // Company Dropdown (only for user type and if companies exist)
//                 if (selectedUserType.value == 'user' &&
//                     controller.existingCompanies.isNotEmpty) ...[
//                   const SizedBox(height: 12),
//                   DropdownButtonFormField<String>(
//                     value: selectedCompany.value,
//                     decoration: const InputDecoration(
//                       labelText: 'Select Company (Optional)',
//                       prefixIcon: Icon(Icons.business),
//                     ),
//                     items: [
//                       const DropdownMenuItem(
//                         value: null,
//                         child: Text('No Company'),
//                       ),
//                       ...controller.existingCompanies.map((company) {
//                         return DropdownMenuItem(
//                           value: company,
//                           child: Text(company),
//                         );
//                       }).toList(),
//                     ],
//                     onChanged: (value) {
//                       selectedCompany.value = value;
//                     },
//                   ),
//                 ],
//
//                 const SizedBox(height: 12),
//
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password *',
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                   obscureText: true,
//                   validator: (v) {
//                     if (v?.isEmpty ?? true) return 'Required';
//                     if (v!.length < 6) return 'Minimum 6 characters';
//                     return null;
//                   },
//                 ),
//               ],
//             )),
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
//                 controller.createUser(
//                   email: emailController.text.trim(),
//                   password: passwordController.text,
//                   fullName: fullNameController.text.trim(),
//                   userType: selectedUserType.value,
//                   phone: phoneController.text.trim(),
//                   companyName: selectedUserType.value == 'company'
//                       ? companyNameController.text.trim()
//                       : null,
//                   selectedCompany: selectedUserType.value == 'user'
//                       ? selectedCompany.value
//                       : null,
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primary,
//               foregroundColor: Colors.white,
//             ),
//             child: Obx(() => Text(
//               selectedUserType.value == 'company' ? 'Create Company' : 'Create User',
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AdminManagementScreen extends StatelessWidget {
  const AdminManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserManagementController());
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin & Company Management'),
        backgroundColor: AppColors.superAdmin,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadUsers(),
          ),
        ],
      ),
      body: Obx(() {
        // Show admins and companies (exclude regular users)
        final adminsAndCompanies = controller.users
            .where((u) => u.role == 'admin' || u.role == 'super_admin' || u.userType == 'company')
            .toList();

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (adminsAndCompanies.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Admins or Companies Found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadUsers,
          child: ListView.builder(
            padding: const EdgeInsets.only(right: 16,left: 16,top: 16,bottom: 180),
            itemCount: adminsAndCompanies.length,
            itemBuilder: (context, index) {
              final item = adminsAndCompanies[index];
              final isSuperAdmin = item.role == 'super_admin';
              final isAdmin = item.role == 'admin';
              final isCompany = item.userType == 'company';
              final isCurrentUser = item.id == authController.currentUser.value?.id;

              Color itemColor = isCompany
                  ? AppColors.info
                  : (isSuperAdmin ? AppColors.superAdmin : AppColors.admin);

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: itemColor.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: itemColor.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        isCompany ? Icons.business : Icons.person,
                        color: itemColor,
                        size: 24,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Middle Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (isCurrentUser)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.info.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'YOU',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.info,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Text(
                            item.email,
                            style: const TextStyle(fontSize: 13),
                          ),

                          if (item.phone != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              item.phone!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],

                          if (item.companyName != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.business, size: 12, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  item.companyName!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Right Column (Type Badge + Delete)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: itemColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isCompany
                                ? 'COMPANY'
                                : item.role.toUpperCase().replaceAll('_', ' '),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: itemColor,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Super Admin can delete admins and companies they created
                        if (authController.currentUser.value?.role == 'super_admin' &&
                            !isSuperAdmin &&
                            !isCurrentUser &&
                            item.createdBy == authController.currentUser.value?.id)
                          GestureDetector(
                            onTap: () => _confirmDelete(context, controller, item),
                            child: Icon(
                              Icons.delete_outline,
                              color: AppColors.error,
                              size: 22,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: Obx(() {
        // Only super_admin can create admins and companies
        if (authController.currentUser.value?.role == 'super_admin') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                onPressed: () => _showCreateDialog(context, controller, 'company'),
                backgroundColor: AppColors.info,
                heroTag: 'create_company',
                icon: const Icon(Icons.business),
                label: const Text('Create Company'),
              ),
              const SizedBox(height: 12),
              FloatingActionButton.extended(
                onPressed: () => _showCreateDialog(context, controller, 'admin'),
                backgroundColor: AppColors.superAdmin,
                heroTag: 'create_admin',
                icon: const Icon(Icons.person_add),
                label: const Text('Create Admin'),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  void _confirmDelete(BuildContext context, UserManagementController controller, UserModel item) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete ${item.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteUser(item.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showCreateDialog(
      BuildContext context, UserManagementController controller, String type) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create New ${type == 'admin' ? 'Admin' : 'Company'}'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: type == 'company' ? 'Company Owner Name *' : 'Full Name *',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Required';
                    if (!GetUtils.isEmail(v!)) return 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone *',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                ),
                if (type == 'company') ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: companyController,
                    decoration: const InputDecoration(
                      labelText: 'Company Name *',
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: (v) => v?.isEmpty ?? true ? 'Company name required' : null,
                  ),
                ] else ...[
                  const SizedBox(height: 12),
                  // TextFormField(
                  //   controller: companyController,
                  //   decoration: const InputDecoration(
                  //     labelText: 'Company Name (Optional)',
                  //     prefixIcon: Icon(Icons.business),
                  //   ),
                  // ),
                ],
                const SizedBox(height: 12),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password *',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Required';
                    if (v!.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
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
                controller.createAdminOrCompany(
                  email: emailController.text.trim(),
                  password: passwordController.text,
                  fullName: fullNameController.text.trim(),
                  phone: phoneController.text.trim(),
                  type: type,
                  companyName: companyController.text.trim().isNotEmpty
                      ? companyController.text.trim()
                      : null,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: type == 'company' ? AppColors.info : AppColors.superAdmin,
              foregroundColor: Colors.white,
            ),
            child: Text('Create ${type == 'admin' ? 'Admin' : 'Company'}'),
          ),
        ],
      ),
    );
  }
}

// class AdminManagementScreen extends StatelessWidget {
//   const AdminManagementScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(UserManagementController());
//     final authController = Get.find<AuthController>();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Management'),
//         backgroundColor: AppColors.superAdmin,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => controller.loadUsers(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         final admins = controller.users
//             .where((u) => u.role == 'admin' || u.role == 'super_admin')
//             .toList();
//
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (admins.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.admin_panel_settings_outlined,
//                   size: 64,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'No Admins Found',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.loadUsers,
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: admins.length,
//             itemBuilder: (context, index) {
//               final admin = admins[index];
//               final isSuperAdmin = admin.role == 'super_admin';
//               final isCurrentUser = admin.id == authController.currentUser.value?.id;
//
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12.withOpacity(0.05),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Avatar
//                     Container(
//                       width: 48,
//                       height: 48,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: (isSuperAdmin ? AppColors.superAdmin : AppColors.admin)
//                             .withOpacity(0.1),
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         admin.fullName[0].toUpperCase(),
//                         style: TextStyle(
//                           color: isSuperAdmin ? AppColors.superAdmin : AppColors.admin,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(width: 16),
//
//                     // Middle Column (Name, email, phone, company)
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   admin.fullName,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//
//                               if (isCurrentUser)
//                                 Container(
//                                   padding:
//                                   const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.info.withOpacity(0.1),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: const Text(
//                                     'YOU',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       color: AppColors.info,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 6),
//
//                           Text(
//                             admin.email,
//                             style: const TextStyle(fontSize: 13),
//                           ),
//
//                           if (admin.phone != null) ...[
//                             const SizedBox(height: 4),
//                             Text(
//                               admin.phone!,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                           ],
//
//                           if (admin.companyName != null) ...[
//                             const SizedBox(height: 4),
//                             Text(
//                               admin.companyName!,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: AppColors.textSecondary,
//                               ),
//                             ),
//                           ],
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(width: 12),
//
//                     // Right Column (Role + Delete Button)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: (isSuperAdmin ? AppColors.superAdmin : AppColors.admin)
//                                 .withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             admin.role.toUpperCase().replaceAll('_', ' '),
//                             style: TextStyle(
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                               color: isSuperAdmin ? AppColors.superAdmin : AppColors.admin,
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         if (authController.currentUser.value?.role == 'super_admin' &&
//                             !isSuperAdmin &&
//                             !isCurrentUser)
//                           GestureDetector(
//                             onTap: () => controller.deleteUser(admin.id),
//                             child: Icon(
//                               Icons.delete_outline,
//                               color: AppColors.error,
//                               size: 22,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//       floatingActionButton: Obx(() {
//         // Only super_admin can create new admins
//         if (authController.currentUser.value?.role == 'super_admin') {
//           return FloatingActionButton.extended(
//             onPressed: () => _showCreateAdminDialog(context, controller),
//             backgroundColor: AppColors.superAdmin,
//             icon: const Icon(Icons.person_add),
//             label: const Text('Create Admin'),
//           );
//         }
//         return const SizedBox.shrink();
//       }),
//     );
//   }
//
//   void _showCreateAdminDialog(
//       BuildContext context, UserManagementController controller) {
//     final formKey = GlobalKey<FormState>();
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();
//     final fullNameController = TextEditingController();
//     final phoneController = TextEditingController();
//     final companyController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Create New Admin'),
//         content: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: fullNameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Full Name *',
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email *',
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (v) {
//                     if (v?.isEmpty ?? true) return 'Required';
//                     if (!GetUtils.isEmail(v!)) return 'Invalid email';
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 TextFormField(
//                   controller: phoneController,
//                   decoration: const InputDecoration(
//                     labelText: 'Phone *',
//                     prefixIcon: Icon(Icons.phone),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   maxLength: 10,
//                   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 TextFormField(
//                   controller: companyController,
//                   decoration: const InputDecoration(
//                     labelText: 'Company Name',
//                     prefixIcon: Icon(Icons.business),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 TextFormField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password *',
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                   obscureText: true,
//                   validator: (v) {
//                     if (v?.isEmpty ?? true) return 'Required';
//                     if (v!.length < 6) return 'Minimum 6 characters';
//                     return null;
//                   },
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
//                 controller.createAdmin(
//                   email: emailController.text.trim(),
//                   password: passwordController.text,
//                   fullName: fullNameController.text.trim(),
//                   phone: phoneController.text.trim(),
//                   companyName: companyController.text.trim().isNotEmpty
//                       ? companyController.text.trim()
//                       : null,
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.superAdmin,
//               foregroundColor: Colors.white,
//             ),
//             child: const Text('Create Admin'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// TOKEN MANAGEMENT SCREEN


// class TokenManagementScreen extends StatelessWidget {
//   const TokenManagementScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(TokenController());
//     final authController = Get.find<AuthController>();
//     final currentRole = authController.currentUser.value?.role;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Token Management'),
//         backgroundColor: AppColors.info,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => controller.loadTokens(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (controller.tokens.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.token_outlined,
//                   size: 64,
//                   color: Colors.grey[400],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'No Tokens Found',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 if (currentRole == 'user') ...[
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Create your first token!',
//                     style: TextStyle(color: AppColors.textSecondary),
//                   ),
//                 ],
//               ],
//             ),
//           );
//         }
//
//         return RefreshIndicator(
//           onRefresh: controller.loadTokens,
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: controller.tokens.length,
//             itemBuilder: (context, index) {
//               final token = controller.tokens[index];
//               return _buildTokenCard(token, controller, currentRole);
//             },
//           ),
//         );
//       }),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => _showAddTokenDialog(context, controller),
//         backgroundColor: AppColors.info,
//         icon: const Icon(Icons.add),
//         label: const Text('Create Token'),
//       ).animate().scale(delay: 300.ms)
//     );
//   }
//
//   Widget _buildTokenCard(
//       TokenModel token, TokenController controller, String? currentRole) {
//     final isValid = token.isValid;
//     final canDelete = currentRole == 'super_admin';
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: (isValid ? AppColors.success : AppColors.error)
//                         .withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     Icons.token,
//                     color: isValid ? AppColors.success : AppColors.error,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         token.tokenNumber,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         token.vehicleNumber ?? 'No vehicle assigned',
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   decoration: BoxDecoration(
//                     color: (isValid ? AppColors.success : AppColors.error)
//                         .withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     token.status.toUpperCase(),
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.bold,
//                       color: isValid ? AppColors.success : AppColors.error,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(height: 24),
//             if (token.materialType != null || token.weightInKg != null) ...[
//               Row(
//                 children: [
//                   if (token.materialType != null)
//                     Expanded(
//                       child: _buildInfoColumn('Material', token.materialType!),
//                     ),
//                   if (token.weightInKg != null)
//                     Expanded(
//                       child: _buildInfoColumn(
//                           'Weight', '${token.weightInKg} Kg'),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//             ],
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildInfoColumn(
//                     'Valid From',
//                     '${token.validFrom.day.toString().padLeft(2, '0')}/${token.validFrom.month.toString().padLeft(2, '0')}/${token.validFrom.year}',
//                   ),
//                 ),
//                 Expanded(
//                   child: _buildInfoColumn(
//                     'Valid Until',
//                     '${token.validUntil.day.toString().padLeft(2, '0')}/${token.validUntil.month.toString().padLeft(2, '0')}/${token.validUntil.year}',
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 if (canDelete)
//                   TextButton.icon(
//                     onPressed: () => controller.deleteToken(token.id),
//                     icon: const Icon(Icons.delete, size: 18),
//                     label: const Text('Delete'),
//                     style: TextButton.styleFrom(
//                       foregroundColor: AppColors.error,
//                     ),
//                   ),
//                 const SizedBox(width: 8),
//                 ElevatedButton.icon(
//                   onPressed: () =>generateTokenPDF(token),
//                   icon: const Icon(Icons.print, size: 18),
//                   label: const Text('Print Token'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     foregroundColor: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoColumn(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 12,
//             color: AppColors.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showAddTokenDialog(BuildContext context, TokenController controller) {
//     final formKey = GlobalKey<FormState>();
//     final tokenNumberController = TextEditingController();
//     final vehicleNumberController = TextEditingController();
//     final weightController = TextEditingController();
//     final materialController = TextEditingController();
//     final validFrom = DateTime.now().obs;
//     final validUntil = DateTime.now().add(const Duration(days: 30)).obs;
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Create New Token'),
//         content: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: tokenNumberController,
//                   decoration: const InputDecoration(
//                     labelText: 'Token Number *',
//                     prefixIcon: Icon(Icons.token),
//                     hintText: 'e.g., TKN001',
//                   ),
//                   textCapitalization: TextCapitalization.characters,
//                   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
//                 ),
//                 const SizedBox(height: 12),
//                 TextFormField(
//                   controller: vehicleNumberController,
//                   decoration: const InputDecoration(
//                     labelText: 'Vehicle Number',
//                     prefixIcon: Icon(Icons.local_shipping),
//                     hintText: 'e.g., GJ01AB1234',
//                   ),
//                   textCapitalization: TextCapitalization.characters,
//                 ),
//                 const SizedBox(height: 12),
//                 TextFormField(
//                   controller: materialController,
//                   decoration: const InputDecoration(
//                     labelText: 'Material Type',
//                     prefixIcon: Icon(Icons.inventory_2),
//                     hintText: 'e.g., Sand, Gravel',
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 TextFormField(
//                   controller: weightController,
//                   decoration: const InputDecoration(
//                     labelText: 'Weight (Kg)',
//                     prefixIcon: Icon(Icons.scale),
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: AppColors.info.withOpacity(0.1),
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
//                   // tokenNumber: tokenNumberController.text.trim().toUpperCase(),
//                   validFrom: validFrom.value,
//                   validUntil: validUntil.value,
//                   vehicleNumber: vehicleNumberController.text.trim().isNotEmpty
//                       ? vehicleNumberController.text.trim().toUpperCase()
//                       : null,
//                   weightInKg: weightController.text.trim().isNotEmpty
//                       ? double.tryParse(weightController.text.trim())
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
// }


class TokenManagementScreen extends StatelessWidget {
  const TokenManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TokenController());
    final authController = Get.find<AuthController>();
    final currentRole = authController.currentUser.value?.role;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Token Management'),
        backgroundColor: AppColors.info,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadTokens(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.tokens.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.token_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Tokens Found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (currentRole == 'user') ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Create your first token!',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadTokens,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.tokens.length,
            itemBuilder: (context, index) {
              final token = controller.tokens[index];
              return buildTokenCard(token,controller);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTokenDialog(context, controller),
        backgroundColor: AppColors.info,
        icon: const Icon(Icons.add),
        label: const Text('Create Token'),
      ).animate().scale(delay: 300.ms),
    );
  }
// Updated Token Card Widget showing all fields

  Widget buildTokenCard(TokenModel token,TokenController controller) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Token Number
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Token No',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        token.tokenNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(token.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _getStatusColor(token.status),
                    ),
                  ),
                  child: Text(
                    token.status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(token.status),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Driver Information
            _buildInfoRow(
              Icons.person,
              'Driver Name',
              token.driverName,
            ),
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.phone,
              'Driver Mobile',
              token.driverMobile,
            ),
            const SizedBox(height: 8),

            // Vehicle Information
            _buildInfoRow(
              Icons.local_shipping,
              'Vehicle No',
              token.vehicleNumber,
            ),
            const SizedBox(height: 8),
            if (token.vehicleType != null)
              _buildInfoRow(
                Icons.directions_car,
                'Vehicle Type',
                token.vehicleType!,
              ),
            const SizedBox(height: 8),

            // Quantity
            _buildInfoRow(
              Icons.scale,
              'Quantity',
              '${token.quantity} CFT',
            ),
            const SizedBox(height: 8),

            // Place
            if (token.place != null && token.place!.isNotEmpty)
              _buildInfoRow(
                Icons.location_on,
                'Place',
                token.place!,
              ),
            const SizedBox(height: 8),

            // Supervisor Name
            _buildInfoRow(
              Icons.supervisor_account,
              'Supervisor',
              token.supervisorName,
            ),

            // Material Type (if exists)
            if (token.materialType != null && token.materialType!.isNotEmpty) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                Icons.inventory_2,
                'Material',
                token.materialType!,
              ),
            ],

            const Divider(height: 24),

            // Footer: Serial Number and Print Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Serial: #${token.serialNumber}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Printed: ${token.printCount}x',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            // Action Buttons
            const SizedBox(height: 12),
            Row(
              children: [
                // Expanded(
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       // Print token action
                //     },
                //     icon: const Icon(Icons.print, size: 18),
                //     label: const Text('Print'),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.info,
                //       foregroundColor: Colors.white,
                //     ),
                //   ),
                // ),
                // const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                   controller.deleteToken(token.id);
                    // More options
                  },
                  icon: const Icon(Icons.delete,color: Colors.red,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'used':
        return Colors.orange;
      case 'expired':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  // Widget _buildTokenCard(BuildContext context,
  //     TokenModel token, TokenController controller, String? currentRole) {
  //   final isValid = token.isValid;
  //   final canDelete = currentRole == 'super_admin';
  //   final serialStr = token.serialNumber.toString().padLeft(8, '0');
  //   final printSeqStr = token.printSequence.toString().padLeft(8, '0');
  //
  //   return Card(
  //     margin: const EdgeInsets.only(bottom: 12),
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               Container(
  //                 padding: const EdgeInsets.all(10),
  //                 decoration: BoxDecoration(
  //                   color: (isValid ? AppColors.success : AppColors.error)
  //                       .withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Icon(
  //                   Icons.token,
  //                   color: isValid ? AppColors.success : AppColors.error,
  //                   size: 24,
  //                 ),
  //               ),
  //               const SizedBox(width: 12),
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       token.tokenNumber,
  //                       style: const TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 4),
  //                     Row(
  //                       children: [
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 8,
  //                             vertical: 4,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: AppColors.primary.withOpacity(0.1),
  //                             borderRadius: BorderRadius.circular(4),
  //                           ),
  //                           child: Text(
  //                             'SN: $serialStr',
  //                             style: const TextStyle(
  //                               fontSize: 10,
  //                               color: AppColors.primary,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                         const SizedBox(width: 8),
  //                         Container(
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 8,
  //                             vertical: 4,
  //                           ),
  //                           decoration: BoxDecoration(
  //                             color: AppColors.info.withOpacity(0.1),
  //                             borderRadius: BorderRadius.circular(4),
  //                           ),
  //                           child: Text(
  //                             'Seq: $printSeqStr',
  //                             style: const TextStyle(
  //                               fontSize: 10,
  //                               color: AppColors.info,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 12,
  //                   vertical: 6,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: (isValid ? AppColors.success : AppColors.error)
  //                       .withOpacity(0.1),
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 child: Text(
  //                   token.status.toUpperCase(),
  //                   style: TextStyle(
  //                     fontSize: 10,
  //                     fontWeight: FontWeight.bold,
  //                     color: isValid ? AppColors.success : AppColors.error,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const Divider(height: 24),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _buildInfoColumn(
  //                   'Vehicle',
  //                   token.vehicleNumber ?? 'Not Assigned',
  //                 ),
  //               ),
  //               Expanded(
  //                 child: _buildInfoColumn(
  //                   'Material',
  //                   token.materialType ?? 'N/A',
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 12),
  //           if (token.weightInKg != null)
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: _buildInfoColumn(
  //                     'Weight',
  //                     '${token.weightInKg} Kg',
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: _buildInfoColumn(
  //                     'Print Count',
  //                     token.printCount.toString(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           const SizedBox(height: 12),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _buildInfoColumn(
  //                   'Valid From',
  //                   '${token.validFrom.day.toString().padLeft(2, '0')}/${token.validFrom.month.toString().padLeft(2, '0')}/${token.validFrom.year}',
  //                 ),
  //               ),
  //               Expanded(
  //                 child: _buildInfoColumn(
  //                   'Valid Until',
  //                   '${token.validUntil.day.toString().padLeft(2, '0')}/${token.validUntil.month.toString().padLeft(2, '0')}/${token.validUntil.year}',
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               if (canDelete)
  //                 TextButton.icon(
  //                   onPressed: () => _showDeleteConfirmation(
  //                     context,
  //                     token,
  //                     controller,
  //                   ),
  //                   icon: const Icon(Icons.delete, size: 18),
  //                   label: const Text('Delete'),
  //                   style: TextButton.styleFrom(
  //                     foregroundColor: AppColors.error,
  //                   ),
  //                 ),
  //               const SizedBox(width: 8),
  //               ElevatedButton.icon(
  //                 onPressed: () => generateTokenPDF(token),
  //                 icon: const Icon(Icons.print, size: 18),
  //                 label: const Text('Print Token'),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: AppColors.primary,
  //                   foregroundColor: Colors.white,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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

    // Vehicle types list
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

    // Quantity list
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

                // Driver Name
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

                // Driver Mobile
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

                // Vehicle Number
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

                // Vehicle Type Dropdown
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

                // Quantity Dropdown
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

                // Place
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

                // Material Type
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

  void _showDeleteConfirmation(
      BuildContext context,
      TokenModel token,
      TokenController controller,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Token'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to delete this token?'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Token: ${token.tokenNumber}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Serial: ${token.serialNumber.toString().padLeft(8, '0')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteToken(token.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
class EnhancedUserManagementScreen extends StatelessWidget {
  const EnhancedUserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserManagementController());
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: AppColors.admin,
        actions: [
          Obx(() => Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Users: ${controller.userCreationCount.value}/2',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadUsers(),
          ),
        ],
      ),
      body: Obx(() {
        // Show only regular users (role='user', user_type='user')
        final regularUsers = controller.users
            .where((u) => u.role == 'user' && u.userType == 'user')
            .toList();

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (regularUsers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people_outline,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Users Found',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first user',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 24),
                if (controller.canCreateUser())
                  ElevatedButton.icon(
                    onPressed: () => _showCreateUserDialog(context, controller),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Create User'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.admin,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadUsers,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: regularUsers.length,
            itemBuilder: (context, index) {
              final user = regularUsers[index];
              final isCurrentUser = user.id == authController.currentUser.value?.id;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.user.withOpacity(0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.user.withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        user.fullName[0].toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.user,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Middle Column (User Details)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  user.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              if (isCurrentUser)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.info.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'YOU',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.info,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              const Icon(Icons.email, size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  user.email,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          if (user.phone != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 14, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  user.phone!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          if (user.companyName != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.business, size: 14, color: AppColors.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  user.companyName!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: 8),

                          // Status Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: user.isActive
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  user.isActive ? Icons.check_circle : Icons.block,
                                  size: 12,
                                  color: user.isActive ? Colors.green : Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  user.status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: user.isActive ? Colors.green : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Right Column (Actions)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // User Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.user.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'USER',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.user,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Delete Button (Admin can delete users they created)
                        if (authController.currentUser.value?.role == 'admin' &&
                            user.createdBy == authController.currentUser.value?.id)
                          GestureDetector(
                            onTap: () => _confirmDelete(context, controller, user),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                color: AppColors.error,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: Obx(() {
        // Admin can create users if limit not reached
        if (authController.currentUser.value?.role == 'admin' &&
            controller.canCreateUser()) {
          return FloatingActionButton.extended(
            onPressed: () => _showCreateUserDialog(context, controller),
            backgroundColor: AppColors.admin,
            icon: const Icon(Icons.person_add),
            label: Text('Create User (${controller.userCreationCount.value}/2)'),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  void _confirmDelete(BuildContext context, UserManagementController controller, UserModel user) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete ${user.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.deleteUser(user.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showCreateUserDialog(BuildContext context, UserManagementController controller) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.person_add, color: AppColors.admin),
            const SizedBox(width: 8),
            const Text('Create New User'),
          ],
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Info Banner
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.info.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppColors.info, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'You can create ${2 - controller.userCreationCount.value} more user(s)',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.info,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Required';
                    if (!GetUtils.isEmail(v!)) return 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: companyController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name (Optional)',
                    prefixIcon: Icon(Icons.business),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password *',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Required';
                    if (v!.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
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
                controller.createUser(
                  email: emailController.text.trim(),
                  password: passwordController.text,
                  fullName: fullNameController.text.trim(),
                  phone: phoneController.text.trim().isNotEmpty
                      ? phoneController.text.trim()
                      : null,
                  companyName: companyController.text.trim().isNotEmpty
                      ? companyController.text.trim()
                      : null,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.admin,
              foregroundColor: Colors.white,
            ),
            child: const Text('Create User'),
          ),
        ],
      ),
    );
  }
}  // void _showAddUserDialog(
  //     BuildContext context,
  //     UserManagementController controller,
  //     ) {
  //   final formKey = GlobalKey<FormState>();
  //   final emailController = TextEditingController();
  //   final nameController = TextEditingController();
  //   final phoneController = TextEditingController();
  //   final companyController = TextEditingController();
  //   final passwordController = TextEditingController();   // 👈 NEW
  //   final selectedRole = 'user'.obs;
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Add New User'),
  //       content: Form(
  //         key: formKey,
  //         child: SingleChildScrollView(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Full Name
  //               TextFormField(
  //                 controller: nameController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Full Name *',
  //                   prefixIcon: Icon(Icons.person),
  //                 ),
  //                 validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
  //               ),
  //               const SizedBox(height: 16),
  //
  //               // Email
  //               TextFormField(
  //                 controller: emailController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Email *',
  //                   prefixIcon: Icon(Icons.email),
  //                 ),
  //                 keyboardType: TextInputType.emailAddress,
  //                 validator: (v) {
  //                   if (v?.isEmpty ?? true) return 'Required';
  //                   if (!v!.contains('@')) return 'Invalid email';
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(height: 16),
  //
  //               // Password
  //               TextFormField(
  //                 controller: passwordController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Password *',
  //                   prefixIcon: Icon(Icons.lock),
  //                 ),
  //                 obscureText: true,
  //                 validator: (v) {
  //                   if (v?.isEmpty ?? true) return 'Required';
  //                   if (v!.length < 6) return 'Minimum 6 characters';
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(height: 16),
  //
  //               // Phone (Optional)
  //               TextFormField(
  //                 controller: phoneController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Phone (Optional)',
  //                   prefixIcon: Icon(Icons.phone),
  //                 ),
  //                 keyboardType: TextInputType.phone,
  //               ),
  //               const SizedBox(height: 16),
  //
  //               // Company Name (Optional)
  //               TextFormField(
  //                 controller: companyController,
  //                 decoration: const InputDecoration(
  //                   labelText: 'Company Name (Optional)',
  //                   prefixIcon: Icon(Icons.business),
  //                 ),
  //               ),
  //
  //               // Role
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
  //               controller.createUser(
  //                 email: emailController.text.trim(),
  //                 fullName: nameController.text.trim(),
  //                 role: 'user',
  //                 password: passwordController.text.trim(),          // 👈 HERE
  //                 phone: phoneController.text.trim().isNotEmpty
  //                     ? phoneController.text.trim()
  //                     : null,
  //                 companyName: companyController.text.trim().isNotEmpty
  //                     ? companyController.text.trim()
  //                     : null,
  //               );
  //             }
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: AppColors.primary,
  //             foregroundColor: Colors.white,
  //           ),
  //           child: const Text('Add User'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // void _showAddUserDialog(
  //     BuildContext context,
  //     UserManagementController controller,
  //     UserModel currentUser,
  //     ) {
  //   final formKey = GlobalKey<FormState>();
  //   final emailController = TextEditingController();
  //   final nameController = TextEditingController();
  //   final phoneController = TextEditingController();
  //   final selectedRole = (currentUser.role == 'admin' ? 'user' : 'admin').obs;
  //
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       child: Container(
  //         padding: const EdgeInsets.all(24),
  //         constraints: const BoxConstraints(maxWidth: 400),
  //         child: Form(
  //           key: formKey,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Container(
  //                       padding: const EdgeInsets.all(12),
  //                       decoration: BoxDecoration(
  //                         color: (currentUser.role == 'super_admin'
  //                             ? AppColors.superAdmin
  //                             : AppColors.admin).withOpacity(0.1),
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       child: Icon(
  //                         Icons.person_add,
  //                         color: currentUser.role == 'super_admin'
  //                             ? AppColors.superAdmin
  //                             : AppColors.admin,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 16),
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             currentUser.role == 'admin' ? 'Add New User' : 'Add New Admin',
  //                             style: const TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           Text(
  //                             currentUser.role == 'admin'
  //                                 ? 'Create a user account'
  //                                 : 'Create an admin account',
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               color: Colors.grey[600],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 24),
  //
  //                 TextFormField(
  //                   controller: nameController,
  //                   decoration: InputDecoration(
  //                     labelText: 'Full Name *',
  //                     prefixIcon: const Icon(Icons.person_outline),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                   ),
  //                   validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
  //                 ),
  //                 const SizedBox(height: 16),
  //
  //                 TextFormField(
  //                   controller: emailController,
  //                   decoration: InputDecoration(
  //                     labelText: 'Email *',
  //                     prefixIcon: const Icon(Icons.email_outlined),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                   ),
  //                   keyboardType: TextInputType.emailAddress,
  //                   validator: (v) {
  //                     if (v?.isEmpty ?? true) return 'Required';
  //                     if (!v!.contains('@')) return 'Invalid email';
  //                     return null;
  //                   },
  //                 ),
  //                 const SizedBox(height: 16),
  //
  //                 TextFormField(
  //                   controller: phoneController,
  //                   decoration: InputDecoration(
  //                     labelText: 'Phone',
  //                     prefixIcon: const Icon(Icons.phone_outlined),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(12),
  //                     ),
  //                   ),
  //                   keyboardType: TextInputType.phone,
  //                 ),
  //
  //                 if (currentUser.role == 'super_admin') ...[
  //                   const SizedBox(height: 16),
  //                   Obx(() => DropdownButtonFormField<String>(
  //                     value: selectedRole.value,
  //                     decoration: InputDecoration(
  //                       labelText: 'Role *',
  //                       prefixIcon: const Icon(Icons.shield_outlined),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                     ),
  //                     items: ['admin']
  //                         .map((role) => DropdownMenuItem(
  //                       value: role,
  //                       child: Text(role.toUpperCase()),
  //                     ))
  //                         .toList(),
  //                     onChanged: (value) {
  //                       if (value != null) selectedRole.value = value;
  //                     },
  //                   )),
  //                 ],
  //
  //                 const SizedBox(height: 24),
  //
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     TextButton(
  //                       onPressed: () => Get.back(),
  //                       child: const Text('Cancel'),
  //                     ),
  //                     const SizedBox(width: 12),
  //                     ElevatedButton.icon(
  //                       onPressed: () {
  //                         if (formKey.currentState!.validate()) {
  //                           controller.createUser(
  //                             email: emailController.text.trim(),
  //                             fullName: nameController.text.trim(),
  //                             role: selectedRole.value,
  //                             phone: phoneController.text.trim().isNotEmpty
  //                                 ? phoneController.text.trim()
  //                                 : null,
  //                           );
  //                         }
  //                       },
  //                       icon: const Icon(Icons.add),
  //                       label: const Text('Create'),
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: currentUser.role == 'super_admin'
  //                             ? AppColors.superAdmin
  //                             : AppColors.admin,
  //                         foregroundColor: Colors.white,
  //                         padding: const EdgeInsets.symmetric(
  //                           horizontal: 24,
  //                           vertical: 12,
  //                         ),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showDeleteConfirmation(UserManagementController controller, UserModel user) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_forever,
                  color: AppColors.error,
                  size: 48,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Delete User',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Are you sure you want to delete ${user.fullName}? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.deleteUser(user.id);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
