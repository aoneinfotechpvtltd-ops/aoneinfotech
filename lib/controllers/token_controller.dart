// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import '../config/supabase_config.dart';
// import '../model/user_model.dart';
//
// class TokenController extends GetxController {
//   final supabase = Supabase.instance.client;
//
//   final RxList<TokenModel> tokens = <TokenModel>[].obs;
//   final RxBool isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadTokens();
//   }
//
//   Future<void> loadTokens() async {
//     try {
//       isLoading.value = true;
//
//       final response = await supabase
//           .from(SupabaseConfig.tokensTable)
//           .select()
//           .order('created_at', ascending: false);
//
//       tokens.value = (response as List)
//           .map((e) => TokenModel.fromJson(e))
//           .toList();
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to load tokens: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> createToken({
//     required String tokenNumber,
//     required DateTime validFrom,
//     required DateTime validUntil,
//     String? vehicleNumber,
//   }) async {
//     try {
//       isLoading.value = true;
//
//       await supabase.from(SupabaseConfig.tokensTable).insert({
//         'token_number': tokenNumber,
//         'status': 'active',
//         'valid_from': validFrom.toIso8601String(),
//         'valid_until': validUntil.toIso8601String(),
//         'vehicle_number': vehicleNumber,
//         'created_at': DateTime.now().toIso8601String(),
//       });
//
//       await loadTokens();
//
//       Get.back();
//       Get.snackbar('Success', 'Token created successfully');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to create token: ${e.toString()}');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> updateTokenStatus(String tokenId, String status) async {
//     try {
//       await supabase
//           .from(SupabaseConfig.tokensTable)
//           .update({'status': status})
//           .eq('id', tokenId);
//
//       await loadTokens();
//
//       Get.snackbar('Success', 'Token status updated');
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update token: ${e.toString()}');
//     }
//   }
// }
