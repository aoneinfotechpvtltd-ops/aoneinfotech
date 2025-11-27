import 'package:aoneinfotech/config/print_pdf.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';
import '../model/user_model.dart';

class ReportsController extends GetxController {
  final supabase = Supabase.instance.client;

  final RxBool isLoading = false.obs;
  final RxList<ChallanModel> reportData = <ChallanModel>[].obs;

  Future<void> generateReport({
    required DateTime startDate,
    required DateTime endDate,
    String? userId,
    String? vehicleNumber,
  }) async {
    try {
      isLoading.value = true;

      var query = supabase
          .from(SupabaseConfig.challansTable)
          .select()
          .gte('created_at', startDate.toIso8601String())
          .lte('created_at', endDate.toIso8601String());

      if (userId != null) {
        query = query.eq('created_by', userId);
      }

      if (vehicleNumber != null) {
        query = query.eq('vehicle_number', vehicleNumber);
      }

      final response = await query.order('created_at', ascending: false);

      reportData.value = (response as List)
          .map((e) => ChallanModel.fromJson(e))
          .toList();
      generateChallanPDFList(reportData);
      // Get.snackbar('Success', 'Report generated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to generate report: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> exportToPDF() async {
    try {
      // Implementation with pdf package
      Get.snackbar('Success', 'Report exported to PDF');
    } catch (e) {
      Get.snackbar('Error', 'Failed to export: ${e.toString()}');
    }
  }

  Future<void> exportToExcel() async {
    try {
      // Implementation with excel package
      Get.snackbar('Success', 'Report exported to Excel');
    } catch (e) {
      Get.snackbar('Error', 'Failed to export: ${e.toString()}');
    }
  }
}