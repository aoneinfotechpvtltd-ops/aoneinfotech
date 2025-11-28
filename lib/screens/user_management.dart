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
class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserManagementController());
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadUsers(),
          ),
        ],
      ),
      body: Obx(() {
        final regularUsers = controller.users
            .where((u) => u.role == 'user')
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
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No Users Found',
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
            padding: const EdgeInsets.all(16),
            itemCount: regularUsers.length,
            itemBuilder: (context, index) {
              final user = regularUsers[index];
              final isCompany = user.userType == 'company';

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (isCompany ? Colors.orange : AppColors.primary)
                            .withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        isCompany ? Icons.business : Icons.person,
                        color: isCompany ? Colors.orange : AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            user.email,
                            style: const TextStyle(fontSize: 13),
                          ),
                          if (user.phone != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              user.phone!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                          if (user.companyName != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.business,
                                  size: 12,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  user.companyName!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: (isCompany ? Colors.orange : AppColors.primary)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            isCompany ? 'COMPANY' : 'USER',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isCompany ? Colors.orange : AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (authController.currentUser.value?.role == 'admin')
                          GestureDetector(
                            onTap: () => controller.deleteUser(user.id),
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
        final currentUser = authController.currentUser.value;
        if (currentUser?.role == 'admin' && controller.canCreateUser()) {
          return FloatingActionButton.extended(
            onPressed: () => _showCreateUserDialog(context, controller),
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.person_add),
            label: Text(
              'Add User/Company (${controller.userCreationCount.value}/2)',
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  void _showCreateUserDialog(
      BuildContext context, UserManagementController controller) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyNameController = TextEditingController();

    final RxString selectedUserType = 'user'.obs;
     Rxn<String> selectedCompany = Rxn<String>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add User or Company'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // User Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedUserType.value,
                  decoration: const InputDecoration(
                    labelText: 'Type *',
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'user',
                      child: Text('User'),
                    ),
                    DropdownMenuItem(
                      value: 'company',
                      enabled: controller.canCreateCompany(),
                      child: Row(
                        children: [
                          const Text('Company'),
                          if (!controller.canCreateCompany())
                            const Text(
                              ' (Limit Reached)',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      selectedUserType.value = value;
                      selectedCompany.value = null;
                    }
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: selectedUserType.value == 'company'
                        ? 'Contact Person Name *'
                        : 'Full Name *',
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
                const SizedBox(height: 12),

                // Company Name Field (only for new company)
                if (selectedUserType.value == 'company')
                  TextFormField(
                    controller: companyNameController,
                    decoration: const InputDecoration(
                      labelText: 'Company Name *',
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: (v) {
                      if (selectedUserType.value == 'company') {
                        return v?.isEmpty ?? true ? 'Required' : null;
                      }
                      return null;
                    },
                  ),

                // Company Dropdown (only for user type and if companies exist)
                if (selectedUserType.value == 'user' &&
                    controller.existingCompanies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedCompany.value,
                    decoration: const InputDecoration(
                      labelText: 'Select Company (Optional)',
                      prefixIcon: Icon(Icons.business),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('No Company'),
                      ),
                      ...controller.existingCompanies.map((company) {
                        return DropdownMenuItem(
                          value: company,
                          child: Text(company),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      selectedCompany.value = value;
                    },
                  ),
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
            )),
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
                  userType: selectedUserType.value,
                  phone: phoneController.text.trim(),
                  companyName: selectedUserType.value == 'company'
                      ? companyNameController.text.trim()
                      : null,
                  selectedCompany: selectedUserType.value == 'user'
                      ? selectedCompany.value
                      : null,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Obx(() => Text(
              selectedUserType.value == 'company' ? 'Create Company' : 'Create User',
            )),
          ),
        ],
      ),
    );
  }
}



class AdminManagementScreen extends StatelessWidget {
  const AdminManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserManagementController());
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Management'),
        backgroundColor: AppColors.superAdmin,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadUsers(),
          ),
        ],
      ),
      body: Obx(() {
        final admins = controller.users
            .where((u) => u.role == 'admin' || u.role == 'super_admin')
            .toList();

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (admins.isEmpty) {
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
                  'No Admins Found',
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
            padding: const EdgeInsets.all(16),
            itemCount: admins.length,
            itemBuilder: (context, index) {
              final admin = admins[index];
              final isSuperAdmin = admin.role == 'super_admin';
              final isCurrentUser = admin.id == authController.currentUser.value?.id;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                        color: (isSuperAdmin ? AppColors.superAdmin : AppColors.admin)
                            .withOpacity(0.1),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        admin.fullName[0].toUpperCase(),
                        style: TextStyle(
                          color: isSuperAdmin ? AppColors.superAdmin : AppColors.admin,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Middle Column (Name, email, phone, company)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  admin.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              if (isCurrentUser)
                                Container(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                            admin.email,
                            style: const TextStyle(fontSize: 13),
                          ),

                          if (admin.phone != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              admin.phone!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],

                          if (admin.companyName != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              admin.companyName!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Right Column (Role + Delete Button)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: (isSuperAdmin ? AppColors.superAdmin : AppColors.admin)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            admin.role.toUpperCase().replaceAll('_', ' '),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isSuperAdmin ? AppColors.superAdmin : AppColors.admin,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        if (authController.currentUser.value?.role == 'super_admin' &&
                            !isSuperAdmin &&
                            !isCurrentUser)
                          GestureDetector(
                            onTap: () => controller.deleteUser(admin.id),
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
        // Only super_admin can create new admins
        if (authController.currentUser.value?.role == 'super_admin') {
          return FloatingActionButton.extended(
            onPressed: () => _showCreateAdminDialog(context, controller),
            backgroundColor: AppColors.superAdmin,
            icon: const Icon(Icons.person_add),
            label: const Text('Create Admin'),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  void _showCreateAdminDialog(
      BuildContext context, UserManagementController controller) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Admin'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name *',
                    prefixIcon: Icon(Icons.person),
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
                const SizedBox(height: 12),
                TextFormField(
                  controller: companyController,
                  decoration: const InputDecoration(
                    labelText: 'Company Name',
                    prefixIcon: Icon(Icons.business),
                  ),
                ),
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
                controller.createAdmin(
                  email: emailController.text.trim(),
                  password: passwordController.text,
                  fullName: fullNameController.text.trim(),
                  phone: phoneController.text.trim(),
                  companyName: companyController.text.trim().isNotEmpty
                      ? companyController.text.trim()
                      : null,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.superAdmin,
              foregroundColor: Colors.white,
            ),
            child: const Text('Create Admin'),
          ),
        ],
      ),
    );
  }
}
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
              return _buildTokenCard(context,token, controller, currentRole);
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

  Widget _buildTokenCard(BuildContext context,
      TokenModel token, TokenController controller, String? currentRole) {
    final isValid = token.isValid;
    final canDelete = currentRole == 'super_admin';
    final serialStr = token.serialNumber.toString().padLeft(8, '0');
    final printSeqStr = token.printSequence.toString().padLeft(8, '0');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (isValid ? AppColors.success : AppColors.error)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.token,
                    color: isValid ? AppColors.success : AppColors.error,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        token.tokenNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'SN: $serialStr',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.info.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Seq: $printSeqStr',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.info,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: (isValid ? AppColors.success : AppColors.error)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    token.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isValid ? AppColors.success : AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildInfoColumn(
                    'Vehicle',
                    token.vehicleNumber ?? 'Not Assigned',
                  ),
                ),
                Expanded(
                  child: _buildInfoColumn(
                    'Material',
                    token.materialType ?? 'N/A',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (token.weightInKg != null)
              Row(
                children: [
                  Expanded(
                    child: _buildInfoColumn(
                      'Weight',
                      '${token.weightInKg} Kg',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoColumn(
                      'Print Count',
                      token.printCount.toString(),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoColumn(
                    'Valid From',
                    '${token.validFrom.day.toString().padLeft(2, '0')}/${token.validFrom.month.toString().padLeft(2, '0')}/${token.validFrom.year}',
                  ),
                ),
                Expanded(
                  child: _buildInfoColumn(
                    'Valid Until',
                    '${token.validUntil.day.toString().padLeft(2, '0')}/${token.validUntil.month.toString().padLeft(2, '0')}/${token.validUntil.year}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (canDelete)
                  TextButton.icon(
                    onPressed: () => _showDeleteConfirmation(
                      context,
                      token,
                      controller,
                    ),
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Delete'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.error,
                    ),
                  ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => generateTokenPDF(token),
                  icon: const Icon(Icons.print, size: 18),
                  label: const Text('Print Token'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
    final vehicleNumberController = TextEditingController();
    final weightController = TextEditingController();
    final materialController = TextEditingController();
    final validFrom = DateTime.now().obs;
    final validUntil = DateTime.now().add(const Duration(days: 30)).obs;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create New Token'),
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
                  controller: vehicleNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Number',
                    prefixIcon: Icon(Icons.local_shipping),
                    hintText: 'e.g., GJ01AB1234',
                  ),
                  textCapitalization: TextCapitalization.characters,
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
                const SizedBox(height: 12),
                TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(
                    labelText: 'Weight (Kg)',
                    prefixIcon: Icon(Icons.scale),
                  ),
                  keyboardType: TextInputType.number,
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
                  vehicleNumber: vehicleNumberController.text.trim().isNotEmpty
                      ? vehicleNumberController.text.trim().toUpperCase()
                      : null,
                  weightInKg: weightController.text.trim().isNotEmpty
                      ? double.tryParse(weightController.text.trim())
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
    final currentUser = authController.currentUser.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
        backgroundColor: currentUser?.role == 'super_admin'
            ? AppColors.superAdmin
            : AppColors.admin,
        elevation: 0,
        actions: [
          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Total: ${controller.users.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
      body: Column(
        children: [
          // Role info banner
          _buildRoleInfoBanner(currentUser),

          // User list
          Expanded(
            child: Obx(() {
              final regularUsers = controller.users
                  .where((u) => u.role == 'user')
                  .toList();
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.users.isEmpty) {
                return _buildEmptyState(currentUser);
              }

              // return RefreshIndicator(
              //   onRefresh: controller.loadUsers,
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(16),
              //     itemCount: controller.users.length,
              //     itemBuilder: (context, index) {
              //       final user = controller.users[index];
              //       return _buildEnhancedUserCard(user, controller, currentUser!);
              //     },
              //   ),
              // );
              return RefreshIndicator(
                onRefresh: controller.loadUsers,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: regularUsers.length,
                  itemBuilder: (context, index) {
                    final user = regularUsers[index];
                    final isCompany = user.userType == 'company';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
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
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (isCompany ? Colors.orange : AppColors.primary)
                                  .withOpacity(0.1),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              isCompany ? Icons.business : Icons.person,
                              color: isCompany ? Colors.orange : AppColors.primary,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  user.email,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                if (user.phone != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    user.phone!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                                if (user.companyName != null) ...[
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.business,
                                        size: 12,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        user.companyName!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: (isCompany ? Colors.orange : AppColors.primary)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  isCompany ? 'COMPANY' : 'USER',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: isCompany ? Colors.orange : AppColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (authController.currentUser.value?.role == 'admin')
                                GestureDetector(
                                  onTap: () => controller.deleteUser(user.id),
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
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        final currentUser = authController.currentUser.value;
        if (currentUser?.role == 'admin' && controller.canCreateUser()) {
          return FloatingActionButton.extended(
            onPressed: () => _showCreateUserDialog(context, controller),
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.person_add),
            label: Text(
              'Add User/Company (${controller.userCreationCount.value}/2)',
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _buildRoleInfoBanner(UserModel? currentUser) {
    Color bgColor;
    String title;
    String description;
    IconData icon;

    if (currentUser?.role == 'super_admin') {
      bgColor = AppColors.superAdmin;
      title = 'Super Admin Access';
      description = 'You can create admins and manage all users';
      icon = Icons.security;
    } else {
      bgColor = AppColors.admin;
      title = 'Admin Access';
      description = 'You can create 1 user and manage your users';
      icon = Icons.admin_panel_settings;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bgColor, bgColor.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: bgColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
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
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(UserModel? currentUser) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            currentUser?.role == 'admin'
                ? 'No Users Created Yet'
                : 'No Users Available',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentUser?.role == 'admin'
                ? 'Create your first user to get started'
                : 'Add admins to manage the system',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedUserCard(
      UserModel user,
      UserManagementController controller,
      UserModel currentUser,
      ) {
    Color roleColor = _getRoleColor(user.role);
    final canDelete = currentUser.role == 'super_admin' ||
        (currentUser.role == 'admin' && user.createdBy == currentUser.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: roleColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              roleColor.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and status
            Row(
              children: [
                Hero(
                  tag: 'user_${user.id}',
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [roleColor, roleColor.withOpacity(0.7)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: roleColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        user.fullName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.email_outlined, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              user.email,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [roleColor, roleColor.withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: roleColor.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    user.role.toUpperCase().replaceAll('_', ' '),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Details section
            Row(
              children: [
                Expanded(
                  child: _buildDetailChip(
                    user.isActive ? 'Active' : 'Blocked',
                    user.isActive ? Icons.check_circle : Icons.block,
                    user.isActive ? AppColors.success : AppColors.error,
                  ),
                ),
                const SizedBox(width: 8),
                if (user.phone != null)
                  Expanded(
                    child: _buildDetailChip(
                      user.phone!,
                      Icons.phone,
                      AppColors.info,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    controller.updateUserStatus(
                      user.id,
                      user.isActive ? 'blocked' : 'active',
                    );
                  },
                  icon: Icon(
                    user.isActive ? Icons.block : Icons.check_circle,
                    size: 18,
                  ),
                  label: Text(user.isActive ? 'Block' : 'Activate'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: user.isActive ? AppColors.error : AppColors.success,
                    side: BorderSide(
                      color: user.isActive ? AppColors.error : AppColors.success,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                if (canDelete) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => _showDeleteConfirmation(controller, user),
                    icon: const Icon(Icons.delete_outline),
                    color: AppColors.error,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.error.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'super_admin':
        return AppColors.superAdmin;
      case 'admin':
        return AppColors.admin;
      case 'user':
        return AppColors.user;
      default:
        return AppColors.viewer;
    }
  }

  Widget _buildDetailChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  void _showCreateUserDialog(
      BuildContext context, UserManagementController controller) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final fullNameController = TextEditingController();
    final phoneController = TextEditingController();
    final companyNameController = TextEditingController();

    final RxString selectedUserType = 'user'.obs;
    final Rxn<String> selectedCompany = Rxn<String>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add User or Company'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // User Type Dropdown
                DropdownButtonFormField<String>(
                  value: selectedUserType.value,
                  decoration: const InputDecoration(
                    labelText: 'Type *',
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'user',
                      child: Text('User'),
                    ),
                    DropdownMenuItem(
                      value: 'company',
                      enabled: controller.canCreateCompany(),
                      child: Row(
                        children: [
                          const Text('Company'),
                          if (!controller.canCreateCompany())
                            const Text(
                              ' (Limit Reached)',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      selectedUserType.value = value;
                      selectedCompany.value = null;
                    }
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    labelText: selectedUserType.value == 'company'
                        ? 'Contact Person Name *'
                        : 'Full Name *',
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
                const SizedBox(height: 12),

                // Company Name Field (only for new company)
                if (selectedUserType.value == 'company')
                  TextFormField(
                    controller: companyNameController,
                    decoration: const InputDecoration(
                      labelText: 'Company Name *',
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: (v) {
                      if (selectedUserType.value == 'company') {
                        return v?.isEmpty ?? true ? 'Required' : null;
                      }
                      return null;
                    },
                  ),

                // Company Dropdown (only for user type and if companies exist)
                if (selectedUserType.value == 'user' &&
                    controller.existingCompanies.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedCompany.value,
                    decoration: const InputDecoration(
                      labelText: 'Select Company (Optional)',
                      prefixIcon: Icon(Icons.business),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('No Company'),
                      ),
                      ...controller.existingCompanies.map((company) {
                        return DropdownMenuItem(
                          value: company,
                          child: Text(company),
                        );
                      }).toList(),
                    ],
                    onChanged: (value) {
                      selectedCompany.value = value;
                    },
                  ),
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
            )),
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
                  userType: selectedUserType.value,
                  phone: phoneController.text.trim(),
                  companyName: selectedUserType.value == 'company'
                      ? companyNameController.text.trim()
                      : null,
                  selectedCompany: selectedUserType.value == 'user'
                      ? selectedCompany.value
                      : null,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Obx(() => Text(
              selectedUserType.value == 'company' ? 'Create Company' : 'Create User',
            )),
          ),
        ],
      ),
    );
  }
}
  // void _showAddUserDialog(
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
