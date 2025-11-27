// class UserModel {
//   final String id;
//   final String email;
//   final String fullName;
//   final String role;
//   final String status;
//   final String? phone;
//   final String? companyName;
//   final String? createdBy;
//   final DateTime createdAt;
//   final DateTime? lastLogin;
//   final Map<String, dynamic>? deviceInfo;
//   final String? ipAddress;
//
//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fullName,
//     required this.role,
//     required this.status,
//     this.phone,
//     this.companyName,
//     this.createdBy,
//     required this.createdAt,
//     this.lastLogin,
//     this.deviceInfo,
//     this.ipAddress,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'] as String,
//       email: json['email'] as String,
//       fullName: json['full_name'] as String,
//       role: json['role'] as String,
//       status: json['status'] as String,
//       phone: json['phone'] as String?,
//       companyName: json['company_name'] as String?,
//       createdBy: json['created_by'] as String?,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       lastLogin: json['last_login'] != null
//           ? DateTime.parse(json['last_login'] as String)
//           : null,
//       deviceInfo: json['device_info'] as Map<String, dynamic>?,
//       ipAddress: json['ip_address'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'full_name': fullName,
//       'role': role,
//       'status': status,
//       'phone': phone,
//       'company_name': companyName,
//       'created_by': createdBy,
//       'created_at': createdAt.toIso8601String(),
//       'last_login': lastLogin?.toIso8601String(),
//       'device_info': deviceInfo,
//       'ip_address': ipAddress,
//     };
//   }
//
//   bool get isSuperAdmin => role == 'super_admin';
//   bool get isAdmin => role == 'admin';
//   bool get isUser => role == 'user';
//   bool get isViewer => role == 'viewer';
//   bool get isActive => status == 'active';
//   bool get isBlocked => status == 'blocked';
// }
//
// class TokenModel {
//   final String id;
//   final String tokenNumber;
//   final String status;
//   final DateTime validFrom;
//   final DateTime validUntil;
//   final String? vehicleNumber;
//   final double? weightInKg;
//   final String? materialType;
//   final String? createdBy;
//   final DateTime createdAt;
//   final DateTime? usedAt;
//   final String? usedBy;
//
//   TokenModel({
//     required this.id,
//     required this.tokenNumber,
//     required this.status,
//     required this.validFrom,
//     required this.validUntil,
//     this.vehicleNumber,
//     this.weightInKg,
//     this.materialType,
//     this.createdBy,
//     required this.createdAt,
//     this.usedAt,
//     this.usedBy,
//   });
//
//   factory TokenModel.fromJson(Map<String, dynamic> json) {
//     return TokenModel(
//       id: json['id'] as String,
//       tokenNumber: json['token_number'] as String,
//       status: json['status'] as String,
//       validFrom: DateTime.parse(json['valid_from'] as String),
//       validUntil: DateTime.parse(json['valid_until'] as String),
//       vehicleNumber: json['vehicle_number'] as String?,
//       weightInKg: json['weight_in_kg'] != null
//           ? (json['weight_in_kg'] as num).toDouble()
//           : null,
//       materialType: json['material_type'] as String?,
//       createdBy: json['created_by'] as String?,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       usedAt: json['used_at'] != null
//           ? DateTime.parse(json['used_at'] as String)
//           : null,
//       usedBy: json['used_by'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'token_number': tokenNumber,
//       'status': status,
//       'valid_from': validFrom.toIso8601String(),
//       'valid_until': validUntil.toIso8601String(),
//       'vehicle_number': vehicleNumber,
//       'weight_in_kg': weightInKg,
//       'material_type': materialType,
//       'created_by': createdBy,
//       'created_at': createdAt.toIso8601String(),
//       'used_at': usedAt?.toIso8601String(),
//       'used_by': usedBy,
//     };
//   }
//
//   bool get isValid {
//     final now = DateTime.now();
//     return status == 'active' &&
//         now.isAfter(validFrom) &&
//         now.isBefore(validUntil);
//   }
//
//   bool get isExpired {
//     final now = DateTime.now();
//     return status == 'expired' || now.isAfter(validUntil);
//   }
//
//   bool get isUsed => status == 'used';
//
//   String get statusDisplay {
//     if (isUsed) return 'Used';
//     if (isExpired) return 'Expired';
//     if (isValid) return 'Active';
//     return 'Inactive';
//   }
// }
class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final String status;
  final String? phone;
  final String? companyName;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime? lastLogin;
  final Map<String, dynamic>? deviceInfo;
  final String? ipAddress;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.status,
    this.phone,
    this.companyName,
    this.createdBy,
    required this.createdAt,
    this.lastLogin,
    this.deviceInfo,
    this.ipAddress,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      phone: json['phone'] as String?,
      companyName: json['company_name'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'] as String)
          : null,
      deviceInfo: json['device_info'] as Map<String, dynamic>?,
      ipAddress: json['ip_address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'status': status,
      'phone': phone,
      'company_name': companyName,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'device_info': deviceInfo,
      'ip_address': ipAddress,
    };
  }

  bool get isSuperAdmin => role == 'super_admin';
  bool get isAdmin => role == 'admin';
  bool get isUser => role == 'user';
  bool get isViewer => role == 'viewer';
  bool get isActive => status == 'active';
  bool get isBlocked => status == 'blocked';
}

// ============================================
// TOKEN MODEL - UPDATED
// ============================================
class TokenModel {
  final String id;
  final String tokenNumber;
  final String status;
  final DateTime validFrom;
  final DateTime validUntil;
  final String? vehicleNumber;
  final double? weightInKg;
  final String? materialType;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime? usedAt;
  final String? usedBy;

  TokenModel({
    required this.id,
    required this.tokenNumber,
    required this.status,
    required this.validFrom,
    required this.validUntil,
    this.vehicleNumber,
    this.weightInKg,
    this.materialType,
    this.createdBy,
    required this.createdAt,
    this.usedAt,
    this.usedBy,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      id: json['id'] as String,
      tokenNumber: json['token_number'] as String,
      status: json['status'] as String,
      validFrom: DateTime.parse(json['valid_from'] as String),
      validUntil: DateTime.parse(json['valid_until'] as String),
      vehicleNumber: json['vehicle_number'] as String?,
      weightInKg: json['weight_in_kg'] != null
          ? (json['weight_in_kg'] as num).toDouble()
          : null,
      materialType: json['material_type'] as String?,
      createdBy: json['created_by'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      usedAt: json['used_at'] != null
          ? DateTime.parse(json['used_at'] as String)
          : null,
      usedBy: json['used_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token_number': tokenNumber,
      'status': status,
      'valid_from': validFrom.toIso8601String(),
      'valid_until': validUntil.toIso8601String(),
      'vehicle_number': vehicleNumber,
      'weight_in_kg': weightInKg,
      'material_type': materialType,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'used_at': usedAt?.toIso8601String(),
      'used_by': usedBy,
    };
  }

  bool get isValid {
    final now = DateTime.now();
    return status == 'active' &&
        now.isAfter(validFrom) &&
        now.isBefore(validUntil);
  }

  bool get isExpired {
    final now = DateTime.now();
    return status == 'expired' || now.isAfter(validUntil);
  }

  bool get isUsed => status == 'used';

  String get statusDisplay {
    if (isUsed) return 'Used';
    if (isExpired) return 'Expired';
    if (isValid) return 'Active';
    return 'Inactive';
  }
}
class ChallanModel {
  final String id;
  final String challanNumber;
  final String vehicleNumber;
  final String vehicleType;
  final String driverName;
  final String? driverPhone;
  final String materialType;
  final double weight;
  final double rate;
  final double totalAmount;
  final String? tokenId;
  final String createdBy;
  final DateTime createdAt;
  final int printCount;
  final int tyres;
  final DateTime? lastPrintedAt;
  final String qrCode;
  final String status;
  final String? remarks;

  ChallanModel({
    required this.id,
    required this.tyres,
    required this.challanNumber,
    required this.vehicleNumber,
    required this.vehicleType,
    required this.driverName,
    this.driverPhone,
    required this.materialType,
    required this.weight,
    required this.rate,
    required this.totalAmount,
    this.tokenId,
    required this.createdBy,
    required this.createdAt,
    required this.printCount,
    this.lastPrintedAt,
    required this.qrCode,
    required this.status,
    this.remarks,
  });

  factory ChallanModel.fromJson(Map<String, dynamic> json) {
    return ChallanModel(
      id: json['id'] as String,
      challanNumber: json['challan_number'] as String,
      vehicleNumber: json['vehicle_number'] as String,
      vehicleType: json['vehicle_type'] as String,
      driverName: json['driver_name'] as String,
      driverPhone: json['driver_phone'] as String?,
      materialType: json['material_type'] as String,
      weight: (json['weight'] as num).toDouble(),
      rate: (json['rate'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      tokenId: json['token_id'] as String?,
      createdBy: json['created_by'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      printCount: json['print_count'] as int,
      tyres: json['print_count'] as int,
      lastPrintedAt: json['last_printed_at'] != null
          ? DateTime.parse(json['last_printed_at'] as String)
          : null,
      qrCode: json['qr_code'] as String,
      status: json['status'] as String,
      remarks: json['remarks'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'challan_number': challanNumber,
      'vehicle_number': vehicleNumber,
      'vehicle_type': vehicleType,
      'driver_name': driverName,
      'driver_phone': driverPhone,
      'material_type': materialType,
      'weight': weight,
      'rate': rate,
      'total_amount': totalAmount,
      'token_id': tokenId,
      'created_by': createdBy,
      'created_at': createdAt.toIso8601String(),
      'print_count': printCount,
      'tyres': tyres,
      'last_printed_at': lastPrintedAt?.toIso8601String(),
      'qr_code': qrCode,
      'status': status,
      'remarks': remarks,
    };
  }
}

class ReprintRequestModel {
  final String id;
  final String challanId;
  final String requestedBy;
  final DateTime requestedAt;
  final String reason;
  final String status;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final String? reviewNotes;

  ReprintRequestModel({
    required this.id,
    required this.challanId,
    required this.requestedBy,
    required this.requestedAt,
    required this.reason,
    required this.status,
    this.reviewedBy,
    this.reviewedAt,
    this.reviewNotes,
  });

  factory ReprintRequestModel.fromJson(Map<String, dynamic> json) {
    return ReprintRequestModel(
      id: json['id'] as String,
      challanId: json['challan_id'] as String,
      requestedBy: json['requested_by'] as String,
      requestedAt: DateTime.parse(json['requested_at'] as String),
      reason: json['reason'] as String,
      status: json['status'] as String,
      reviewedBy: json['reviewed_by'] as String?,
      reviewedAt: json['reviewed_at'] != null
          ? DateTime.parse(json['reviewed_at'] as String)
          : null,
      reviewNotes: json['review_notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'challan_id': challanId,
      'requested_by': requestedBy,
      'requested_at': requestedAt.toIso8601String(),
      'reason': reason,
      'status': status,
      'reviewed_by': reviewedBy,
      'reviewed_at': reviewedAt?.toIso8601String(),
      'review_notes': reviewNotes,
    };
  }

  bool get isPending => status == 'pending';
  bool get isApproved => status == 'approved';
  bool get isRejected => status == 'rejected';
}