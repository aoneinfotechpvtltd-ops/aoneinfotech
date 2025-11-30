// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../utilis/app_colors.dart';
// import '../../config/print_pdf.dart';
// import '../controllers/user_management_controller.dart';
//
// class PrintTokenReportScreen extends StatelessWidget {
//   const PrintTokenReportScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(TokenController());
//     final selectedTokens = <String>[].obs;
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         title: const Text('PRINT TOKEN REPORT'),
//         backgroundColor: AppColors.primary,
//         actions: [
//           Obx(() => selectedTokens.isNotEmpty
//               ? IconButton(
//             icon: Badge(
//               label: Text(selectedTokens.length.toString()),
//               child: const Icon(Icons.print),
//             ),
//             onPressed: () {
//               final tokensToprint = controller.tokens
//                   .where((t) => selectedTokens.contains(t.id))
//                   .toList();
//               if (tokensToprint.isNotEmpty) {
//                 generateTokenPDFList(tokensToprint);
//               }
//             },
//             tooltip: 'Print Selected',
//           )
//               : const SizedBox()),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Header Card
//           Container(
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColors.primary.withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.token,
//                     color: Colors.white,
//                     size: 32,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 const Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'PRINT TOKEN',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Select tokens to print',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Obx(() => Text(
//                   '${controller.tokens.length} Tokens',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )),
//               ],
//             ),
//           ).animate().fadeIn().slideY(begin: -0.2),
//
//           // Data Table
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (controller.tokens.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.token, size: 64, color: Colors.grey.shade400),
//                       const SizedBox(height: 16),
//                       Text(
//                         'No tokens found',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey.shade600,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//
//               return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: DataTable(
//                     headingRowColor: MaterialStateProperty.all(
//                       AppColors.primary.withOpacity(0.1),
//                     ),
//                     headingRowHeight: 56,
//                     dataRowHeight: 72,
//                     horizontalMargin: 16,
//                     columnSpacing: 24,
//                     columns: [
//                       DataColumn(
//                         label: Obx(() => Checkbox(
//                           value: selectedTokens.length ==
//                               controller.tokens.length,
//                           onChanged: (value) {
//                             if (value == true) {
//                               selectedTokens.value = controller.tokens
//                                   .map((t) => t.id)
//                                   .toList();
//                             } else {
//                               selectedTokens.clear();
//                             }
//                           },
//                           activeColor: AppColors.primary,
//                         )),
//                       ),
//                       const DataColumn(
//                         label: Text(
//                           'TOKEN NO',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       // const DataColumn(
//                       //   label: Text(
//                       //     'DRIVER NAME',
//                       //     style: TextStyle(
//                       //       fontWeight: FontWeight.bold,
//                       //       fontSize: 12,
//                       //     ),
//                       //   ),
//                       // ),
//                       // const DataColumn(
//                       //   label: Text(
//                       //     'DRIVER NO',
//                       //     style: TextStyle(
//                       //       fontWeight: FontWeight.bold,
//                       //       fontSize: 12,
//                       //     ),
//                       //   ),
//                       // ),
//                       const DataColumn(
//                         label: Text(
//                           'VEHICAL NO',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       const DataColumn(
//                         label: Text(
//                           'VEHICAL TYPE',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       const DataColumn(
//                         label: Text(
//                           'QUANTITY',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       // const DataColumn(
//                       //   label: Text(
//                       //     'PLACE',
//                       //     style: TextStyle(
//                       //       fontWeight: FontWeight.bold,
//                       //       fontSize: 12,
//                       //     ),
//                       //   ),
//                       // ),
//                       // const DataColumn(
//                       //   label: Text(
//                       //     'SUPERVISOR NAME',
//                       //     style: TextStyle(
//                       //       fontWeight: FontWeight.bold,
//                       //       fontSize: 12,
//                       //     ),
//                       //   ),
//                       // ),
//                       const DataColumn(
//                         label: Text(
//                           'ACTION',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ],
//                     rows: controller.tokens.map((token) {
//                       return DataRow(
//                         cells: [
//                           DataCell(
//                             Obx(() => Checkbox(
//                               value: selectedTokens.contains(token.id),
//                               onChanged: (value) {
//                                 if (value == true) {
//                                   selectedTokens.add(token.id);
//                                 } else {
//                                   selectedTokens.remove(token.id);
//                                 }
//                               },
//                               activeColor: AppColors.primary,
//                             )),
//                           ),
//                           DataCell(
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   token.serialNumber.toString(),
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 2),
//                                 Text(
//                                   token.tokenNumber,
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // DataCell(
//                           //   Text(
//                           //     'N/A',
//                           //     style: TextStyle(
//                           //       fontSize: 13,
//                           //       color: Colors.grey.shade700,
//                           //     ),
//                           //   ),
//                           // ),
//                           // DataCell(
//                           //   Text(
//                           //     'N/A',
//                           //     style: TextStyle(
//                           //       fontSize: 13,
//                           //       color: Colors.grey.shade700,
//                           //     ),
//                           //   ),
//                           // ),
//                           DataCell(
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 8,
//                                 vertical: 4,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: AppColors.info.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Text(
//                                 token.vehicleNumber ?? 'N/A',
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   color: AppColors.info,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           DataCell(
//                             Text(
//                               token.materialType ?? 'N/A',
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey.shade700,
//                               ),
//                             ),
//                           ),
//                           DataCell(
//                             Text(
//                               token.weightInKg != null
//                                   ? '${token.weightInKg} Kg'
//                                   : '0',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           // DataCell(
//                           //   Text(
//                           //     'N/A',
//                           //     style: TextStyle(
//                           //       fontSize: 13,
//                           //       color: Colors.grey.shade700,
//                           //     ),
//                           //   ),
//                           // ),
//                           // DataCell(
//                           //   Text(
//                           //     'N/A',
//                           //     style: TextStyle(
//                           //       fontSize: 13,
//                           //       color: Colors.grey.shade700,
//                           //     ),
//                           //   ),
//                           // ),
//                           DataCell(
//                             ElevatedButton(
//                               onPressed: () => generateTokenPDF(token),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.primary,
//                                 foregroundColor: Colors.white,
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 20,
//                                   vertical: 10,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                               ),
//                               child: const Text(
//                                 'PRINT',
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               );
//             }),
//           ),
//           const SizedBox(height: 16),
//         ],
//       ),
//       floatingActionButton: Obx(() => selectedTokens.isNotEmpty
//           ? FloatingActionButton.extended(
//         onPressed: () {
//           final tokensToprint = controller.tokens
//               .where((t) => selectedTokens.contains(t.id))
//               .toList();
//           if (tokensToprint.isNotEmpty) {
//             generateTokenPDFList(tokensToprint);
//             selectedTokens.clear();
//           }
//         },
//         backgroundColor: AppColors.success,
//         icon: const Icon(Icons.print),
//         label: Text('Print ${selectedTokens.length} Selected'),
//       ).animate().scale()
//           : const SizedBox()),
//     );
//   }
// }
import 'package:aoneinfotech/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../utilis/app_colors.dart';
import '../../config/print_pdf.dart';
import '../controllers/user_management_controller.dart';

class PrintTokenReportScreen extends StatefulWidget {
  final bool isAdmin;
  const PrintTokenReportScreen({super.key, required this.isAdmin});

  @override
  State<PrintTokenReportScreen> createState() => _PrintTokenReportScreenState();
}

class _PrintTokenReportScreenState extends State<PrintTokenReportScreen> {
  final controller = Get.put(TokenController());
  final selectedTokens = <String>[].obs;
  final authController=Get.put(AuthController());

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('PRINT TOKEN REPORT'),
        backgroundColor: AppColors.primary,
        actions: [
          Obx(() => selectedTokens.isNotEmpty
              ? IconButton(
            icon: Badge(
              label: Text(selectedTokens.length.toString()),
              child: const Icon(Icons.print),
            ),
            onPressed: () {
              final tokensToprint = controller.tokens
                  .where((t) => selectedTokens.contains(t.id))
                  .toList();
              if (tokensToprint.isNotEmpty) {
                generateTokenPDFList(tokensToprint);
              }
            },
            tooltip: 'Print Selected',
          )
              : const SizedBox()),
        ],
      ),
      body: Column(
        children: [

          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 10,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.token,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRINT TOKEN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Select tokens to print',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(() => Text(
                  '${controller.tokens.length} Tokens',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
          ).animate().fadeIn().slideY(begin: -0.2),

          // Data Table
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.tokens.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.token, size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        'No tokens found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      AppColors.primary.withOpacity(0.1),
                    ),

                    headingRowHeight: 56,

                    dataRowHeight: 72,
                    horizontalMargin: 5,
                    columnSpacing: 10,

                    columns: [
                      // Checkbox Column
                    if(!widget.isAdmin)  DataColumn(
                        label: Obx(() => Checkbox(
                          value: selectedTokens.length ==
                              controller.tokens.length &&
                              controller.tokens.isNotEmpty,
                          onChanged: (value) {
                            if (value == true) {
                              selectedTokens.value = controller.tokens
                                  .map((t) => t.id)
                                  .toList();
                            } else {
                              selectedTokens.clear();
                            }
                          },
                          activeColor: AppColors.primary,
                        )),
                      ),
                      // Serial Number Column
                      const DataColumn(
                        label: Text(
                          'SR NO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // Token Number Column
                      const DataColumn(
                        label: Text(
                          'TOKEN NO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // Driver Name Column
                      const DataColumn(
                        label: Text(
                          'DRIVER NAME',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // Driver Mobile Column
                      const DataColumn(
                        label: Text(
                          'DRIVER NO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // Vehicle Number Column
                      const DataColumn(
                        label: Text(
                          'VEHICLE NO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      // Vehicle Type Column
                      const DataColumn(
                        label: Text(
                          'VEHICLE TYPE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Text(
                          'PLACE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: Text(
                          'SUPERVISOR NAME',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      if(!widget.isAdmin) const DataColumn(
                        label: Text(
                          'ACTION',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      controller.tokens.length,
                          (index) {
                        final token = controller.tokens[index];
                        final rowNumber = index + 1;

                        return DataRow(
                          cells: [
                           if(!widget.isAdmin) DataCell(
                              Obx(() => Checkbox(
                                value: selectedTokens.contains(token.id),
                                onChanged: (value) {
                                  if (value == true) {
                                    selectedTokens.add(token.id);
                                  } else {
                                    selectedTokens.remove(token.id);
                                  }
                                },
                                activeColor: AppColors.primary,
                              )),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  rowNumber.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            // Token Number Cell
                            DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    token.serialNumber.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    token.tokenNumber,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 120,
                                child: Text(
                                  token.driverName.isNotEmpty
                                      ? token.driverName.toUpperCase()
                                      : 'N/A',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                token.driverMobile.isNotEmpty
                                    ? token.driverMobile
                                    : '0000000000',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.info.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.info.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  token.vehicleNumber ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.info,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  token.vehicleType ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  token.place?.isNotEmpty == true
                                      ? token.place!.toUpperCase()
                                      : 'N/A',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            // Supervisor Name Cell
                            DataCell(
                              SizedBox(
                                width: 120,
                                child: Text(
                                  token.supervisorName.isNotEmpty
                                      ? token.supervisorName.toUpperCase()
                                      : 'UNKNOWN',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            // Action Cell
                          if(!widget.isAdmin)  DataCell(
                              ElevatedButton(
                                onPressed: () => generateTokenPDF(token),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'PRINT',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
        ],
      ),
      floatingActionButton: widget.isAdmin?SizedBox():Obx(() => selectedTokens.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: () {
          final tokensToprint = controller.tokens
              .where((t) => selectedTokens.contains(t.id))
              .toList();
          if (tokensToprint.isNotEmpty) {
            generateTokenPDFList(tokensToprint);
            selectedTokens.clear();
          }
        },
        backgroundColor: AppColors.success,
        icon: const Icon(Icons.print),
        label: Text('Print ${selectedTokens.length} Selected'),
      ).animate().scale()
          : const SizedBox()),
    );
  }
}