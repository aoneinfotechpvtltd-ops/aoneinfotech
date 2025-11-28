import 'package:aoneinfotech/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../controllers/challan_controller.dart';
import '../../model/user_model.dart';
import '../../utilis/app_colors.dart';

// CHALLAN LIST SCREEN
class ChallanListScreen extends StatelessWidget {
  const ChallanListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallanController());
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Challans'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, controller),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by vehicle number or challan number',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
              ),
              onChanged: (value) {
                // Implement search
              },
            ),
          ),

          // Challan List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.challans.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long,
                          size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No challans found',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey[600])),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.loadChallans,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.challans.length,
                  itemBuilder: (context, index) {
                    final challan = controller.challans[index];
                    return _buildChallanCard(challan, controller);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildChallanCard(ChallanModel challan, ChallanController controller) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          controller.selectedChallan.value = challan;
          Get.toNamed('/challan-detail', arguments: challan);
        },
        borderRadius: BorderRadius.circular(12),
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
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.receipt,
                        color: AppColors.primary, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challan.challanNumber,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dateFormat.format(challan.createdAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: challan.status == 'active'
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      challan.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: challan.status == 'active'
                            ? AppColors.success
                            : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                        'Vehicle', challan.vehicleNumber, Icons.local_shipping),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                        'Material', challan.materialType, Icons.inventory),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem('Weight',
                        '${challan.weight.toStringAsFixed(2)} T', Icons.scale),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      'Amount',
                      '₹${challan.totalAmount.toStringAsFixed(2)}',
                      Icons.currency_rupee,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              if (challan.printCount > 0) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.print,
                        size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      'Printed ${challan.printCount} time(s)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon,
      {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color ?? AppColors.textSecondary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color ?? AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context, ChallanController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Challans'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Today'),
              onTap: () {
                // Filter today's challans
                Get.back();
              },
            ),
            ListTile(
              title: const Text('This Week'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              title: const Text('This Month'),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
class ChallanAdminListScreen extends StatelessWidget {
  const ChallanAdminListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallanController());
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Challans'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, controller),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by vehicle number or challan number',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.surfaceVariant,
              ),
              onChanged: (value) {
                // Implement search
              },
            ),
          ),

          // Challan List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.challans.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long,
                          size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No challans found',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey[600])),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.loadChallans,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.challans.length,
                  itemBuilder: (context, index) {
                    final challan = controller.challans[index];
                    return _buildChallanCard(challan, controller);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildChallanCard(ChallanModel challan, ChallanController controller) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          controller.selectedChallan.value = challan;
          Get.toNamed(AppRoutes.challanDetail, arguments: challan);
        },
        borderRadius: BorderRadius.circular(12),
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
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.receipt,
                        color: AppColors.primary, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challan.challanNumber,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dateFormat.format(challan.createdAt),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: challan.status == 'active'
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      challan.status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: challan.status == 'active'
                            ? AppColors.success
                            : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                        'Vehicle', challan.vehicleNumber, Icons.local_shipping),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                        'Material', challan.materialType, Icons.inventory),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem('Weight',
                        '${challan.weight.toStringAsFixed(2)} T', Icons.scale),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      'Amount',
                      '₹${challan.totalAmount.toStringAsFixed(2)}',
                      Icons.currency_rupee,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
              if (challan.printCount > 0) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.print,
                        size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      'Printed ${challan.printCount} time(s)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon,
      {Color? color}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color ?? AppColors.textSecondary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color ?? AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context, ChallanController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Challans'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Today'),
              onTap: () {
                // Filter today's challans
                Get.back();
              },
            ),
            ListTile(
              title: const Text('This Week'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              title: const Text('This Month'),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// CHALLAN DETAIL SCREEN
class ChallanDetailScreen extends StatelessWidget {
  const ChallanDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallanController());
    final challan = controller.selectedChallan.value ??
        Get.arguments as ChallanModel;
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challan Details'),
        backgroundColor: AppColors.primary,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'print',
                child: Row(
                  children: [
                    Icon(Icons.print),
                    SizedBox(width: 8),
                    Text('Print'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'reprint',
                child: Row(
                  children: [
                    Icon(Icons.print_disabled),
                    SizedBox(width: 8),
                    Text('Request Reprint'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share),
                    SizedBox(width: 8),
                    Text('Share'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'print') {
                controller.printChallan(challan.id);
              } else if (value == 'reprint') {
                _showReprintDialog(context, controller, challan.id);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Challan Number Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'CHALLAN NUMBER',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    challan.challanNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dateFormat.format(challan.createdAt),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Vehicle Details
            _buildSectionCard(
              'Vehicle Details',
              Icons.local_shipping,
              [
                _buildDetailRow('Vehicle Number', challan.vehicleNumber),
                _buildDetailRow('Vehicle Type', challan.vehicleType),
                _buildDetailRow('Driver Name', challan.driverName),
                if (challan.driverPhone != null)
                  _buildDetailRow('Driver Phone', challan.driverPhone!),
              ],
            ),
            const SizedBox(height: 16),

            // Material Details
            _buildSectionCard(
              'Material Details',
              Icons.inventory,
              [
                _buildDetailRow('Material Type', challan.materialType),
                _buildDetailRow('Weight', '${challan.weight} Tons'),
                _buildDetailRow('Rate', '₹${challan.rate} per Ton'),
                _buildDetailRow(
                  'Total Amount',
                  '₹${challan.totalAmount.toStringAsFixed(2)}',
                  valueColor: AppColors.success,
                  isHighlighted: true,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Print Status
            _buildSectionCard(
              'Print Status',
              Icons.print,
              [
                _buildDetailRow('Print Count', '${challan.printCount}'),
                if (challan.lastPrintedAt != null)
                  _buildDetailRow(
                    'Last Printed',
                    dateFormat.format(challan.lastPrintedAt!),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // QR Code
            Container(
              padding: const EdgeInsets.all(20),
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
                children: [
                  const Text(
                    'QR CODE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.border, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: QrImageView(
                      data: challan.qrCode,
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Scan to verify',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Remarks
            if (challan.remarks != null)
              _buildSectionCard(
                'Remarks',
                Icons.notes,
                [
                  Text(
                    challan.remarks!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {Color? valueColor, bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isHighlighted ? 18 : 14,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
                color: valueColor ?? AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReprintDialog(
      BuildContext context, ChallanController controller, String challanId) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Reprint'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please provide a reason for reprint request:'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Enter reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
              if (reasonController.text.trim().isNotEmpty) {
                controller.requestReprint(
                  challanId,
                  reasonController.text.trim(),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
class ChallanAdminDetailScreen extends StatelessWidget {
  const ChallanAdminDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallanController());
    final challan = controller.selectedChallan.value ??
        Get.arguments as ChallanModel;
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challan Details'),
        backgroundColor: AppColors.primary,
        // actions: [
        //   PopupMenuButton(
        //     icon: const Icon(Icons.more_vert),
        //     itemBuilder: (context) => [
        //       const PopupMenuItem(
        //         value: 'print',
        //         child: Row(
        //           children: [
        //             Icon(Icons.print),
        //             SizedBox(width: 8),
        //             Text('Print'),
        //           ],
        //         ),
        //       ),
        //       const PopupMenuItem(
        //         value: 'reprint',
        //         child: Row(
        //           children: [
        //             Icon(Icons.print_disabled),
        //             SizedBox(width: 8),
        //             Text('Request Reprint'),
        //           ],
        //         ),
        //       ),
        //       const PopupMenuItem(
        //         value: 'share',
        //         child: Row(
        //           children: [
        //             Icon(Icons.share),
        //             SizedBox(width: 8),
        //             Text('Share'),
        //           ],
        //         ),
        //       ),
        //     ],
        //     onSelected: (value) {
        //       if (value == 'print') {
        //         controller.printChallan(challan.id);
        //       } else if (value == 'reprint') {
        //         _showReprintDialog(context, controller, challan.id);
        //       }
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Challan Number Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'CHALLAN NUMBER',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    challan.challanNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dateFormat.format(challan.createdAt),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Vehicle Details
            _buildSectionCard(
              'Vehicle Details',
              Icons.local_shipping,
              [
                _buildDetailRow('Vehicle Number', challan.vehicleNumber),
                _buildDetailRow('Vehicle Type', challan.vehicleType),
                _buildDetailRow('Driver Name', challan.driverName),
                if (challan.driverPhone != null)
                  _buildDetailRow('Driver Phone', challan.driverPhone!),
              ],
            ),
            const SizedBox(height: 16),

            // Material Details
            _buildSectionCard(
              'Material Details',
              Icons.inventory,
              [
                _buildDetailRow('Material Type', challan.materialType),
                _buildDetailRow('Weight', '${challan.weight} Tons'),
                _buildDetailRow('Rate', '₹${challan.rate} per Ton'),
                _buildDetailRow(
                  'Total Amount',
                  '₹${challan.totalAmount.toStringAsFixed(2)}',
                  valueColor: AppColors.success,
                  isHighlighted: true,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Print Status
            _buildSectionCard(
              'Print Status',
              Icons.print,
              [
                _buildDetailRow('Print Count', '${challan.printCount}'),
                if (challan.lastPrintedAt != null)
                  _buildDetailRow(
                    'Last Printed',
                    dateFormat.format(challan.lastPrintedAt!),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // QR Code
            Container(
              padding: const EdgeInsets.all(20),
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
                children: [
                  const Text(
                    'QR CODE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.border, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: QrImageView(
                      data: challan.qrCode,
                      version: QrVersions.auto,
                      size: 200,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Scan to verify',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Remarks
            if (challan.remarks != null)
              _buildSectionCard(
                'Remarks',
                Icons.notes,
                [
                  Text(
                    challan.remarks!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {Color? valueColor, bool isHighlighted = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isHighlighted ? 18 : 14,
                fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
                color: valueColor ?? AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReprintDialog(
      BuildContext context, ChallanController controller, String challanId) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Reprint'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please provide a reason for reprint request:'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                hintText: 'Enter reason',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
              if (reasonController.text.trim().isNotEmpty) {
                controller.requestReprint(
                  challanId,
                  reasonController.text.trim(),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}