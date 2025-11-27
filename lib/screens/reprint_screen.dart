import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/reports_controller.dart';
import '../../controllers/challan_controller.dart';
import '../model/user_model.dart';
import '../utilis/app_colors.dart';

// REPORTS SCREEN
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReportsController>();
    final startDate = DateTime.now().subtract(const Duration(days: 7)).obs;
    final endDate = DateTime.now().obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date Range Selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                  const Text(
                    'Select Date Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => _buildDateButton(
                          'Start Date',
                          startDate.value,
                              () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: startDate.value,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) startDate.value = date;
                          },
                        )),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Obx(() => _buildDateButton(
                          'End Date',
                          endDate.value,
                              () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: endDate.value,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                            );
                            if (date != null) endDate.value = date;
                          },
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.generateReport(
                        startDate: startDate.value,
                        endDate: endDate.value,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Generate Report'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Quick Reports
            const Text(
              'Quick Reports',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: [
                _buildQuickReportCard(
                  'Today\'s Report',
                  Icons.today,
                  AppColors.primary,
                      () {
                    controller.generateReport(
                      startDate: DateTime.now(),
                      endDate: DateTime.now(),
                    );
                  },
                ),
                _buildQuickReportCard(
                  'This Week',
                  Icons.calendar_today,
                  AppColors.success,
                      () {
                    final now = DateTime.now();
                    controller.generateReport(
                      startDate: now.subtract(Duration(days: now.weekday - 1)),
                      endDate: now,
                    );
                  },
                ),
                _buildQuickReportCard(
                  'This Month',
                  Icons.calendar_month,
                  AppColors.warning,
                      () {
                    final now = DateTime.now();
                    controller.generateReport(
                      startDate: DateTime(now.year, now.month, 1),
                      endDate: now,
                    );
                  },
                ),
                _buildQuickReportCard(
                  'Last 30 Days',
                  Icons.date_range,
                  AppColors.info,
                      () {
                    controller.generateReport(
                      startDate: DateTime.now().subtract(const Duration(days: 30)),
                      endDate: DateTime.now(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Report Results
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (controller.reportData.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Column(
                      children: [
                        Icon(Icons.bar_chart, size: 48, color: AppColors.textTertiary),
                        SizedBox(height: 8),
                        Text(
                          'No data available',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Summary Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppColors.successGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Total Challans',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${controller.reportData.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total Amount: ₹${_calculateTotalAmount(controller.reportData)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Export Buttons
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton.icon(
                  //         onPressed: controller.exportToPDF,
                  //         icon: const Icon(Icons.picture_as_pdf),
                  //         label: const Text('Export PDF'),
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: AppColors.error,
                  //           foregroundColor: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 12),
                  //     Expanded(
                  //       child: ElevatedButton.icon(
                  //         onPressed: controller.exportToExcel,
                  //         icon: const Icon(Icons.table_chart),
                  //         label: const Text('Export Excel'),
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: AppColors.success,
                  //           foregroundColor: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 16),

                  // Report Data List
                  const Text(
                    'Report Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.reportData.length,
                    itemBuilder: (context, index) {
                      final challan = controller.reportData[index];
                      return _buildReportItem(challan);
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDateButton(String label, DateTime date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd MMM yyyy').format(date),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReportCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
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
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(ChallanModel challan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: const Icon(Icons.receipt, color: AppColors.primary, size: 20),
        ),
        title: Text(challan.challanNumber),
        subtitle: Text(challan.vehicleNumber),
        trailing: Text(
          '₹${challan.totalAmount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.success,
          ),
        ),
      ),
    );
  }

  String _calculateTotalAmount(List<ChallanModel> challans) {
    final total = challans.fold<double>(
      0,
          (sum, challan) => sum + challan.totalAmount,
    );
    return total.toStringAsFixed(2);
  }
}

// REPRINT REQUESTS SCREEN
class ReprintRequestsScreen extends StatelessWidget {
  const ReprintRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChallanController());
    controller.loadReprintRequests();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reprint Requests'),
        backgroundColor: AppColors.primary,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.reprintRequests.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.print_disabled, size: 64, color: AppColors.textTertiary),
                SizedBox(height: 16),
                Text(
                  'No reprint requests',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.reprintRequests.length,
          itemBuilder: (context, index) {
            final request = controller.reprintRequests[index];
            return _buildRequestCard(request, controller);
          },
        );
      }),
    );
  }

  Widget _buildRequestCard(ReprintRequestModel request, ChallanController controller) {
    Color statusColor;
    switch (request.status) {
      case 'pending':
        statusColor = AppColors.warning;
        break;
      case 'approved':
        statusColor = AppColors.success;
        break;
      case 'rejected':
        statusColor = AppColors.error;
        break;
      default:
        statusColor = AppColors.textSecondary;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Request ID',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        request.id.substring(0, 8),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
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
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    request.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Text(
              'Reason: ${request.reason}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            Text(
              'Requested: ${DateFormat('dd MMM yyyy, hh:mm a').format(request.requestedAt)}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
            if (request.status == 'pending') ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.approveReprintRequest(request.id, null),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Reject'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// SYSTEM SETTINGS SCREEN
class SystemSettingsScreen extends StatelessWidget {
  const SystemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final challanTimeLimit = 6.obs;
    final autoApprove = true.obs;
    final require2FA = false.obs;
    final qrVerification = true.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Settings'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingSection(
            'Challan Settings',
            [
              Obx(() => ListTile(
                title: const Text('Challan Time Limit'),
                subtitle: Text('${challanTimeLimit.value} hours between challans'),
                trailing: SizedBox(
                  width: 100,
                  child: Slider(
                    value: challanTimeLimit.value.toDouble(),
                    min: 1,
                    max: 24,
                    divisions: 23,
                    label: '${challanTimeLimit.value}h',
                    onChanged: (value) {
                      challanTimeLimit.value = value.toInt();
                    },
                  ),
                ),
              )),
              Obx(() => SwitchListTile(
                title: const Text('Auto-approve After Time Limit'),
                subtitle: const Text('Automatically allow challan after time limit'),
                value: autoApprove.value,
                onChanged: (value) => autoApprove.value = value,
              )),
            ],
          ),
          const SizedBox(height: 16),
          _buildSettingSection(
            'Security Settings',
            [
              Obx(() => SwitchListTile(
                title: const Text('Require 2FA'),
                subtitle: const Text('Two-factor authentication for login'),
                value: require2FA.value,
                onChanged: (value) => require2FA.value = value,
              )),
              Obx(() => SwitchListTile(
                title: const Text('QR Verification'),
                subtitle: const Text('Enable QR code verification'),
                value: qrVerification.value,
                onChanged: (value) => qrVerification.value = value,
              )),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Get.snackbar('Success', 'Settings saved successfully');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSection(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }
}