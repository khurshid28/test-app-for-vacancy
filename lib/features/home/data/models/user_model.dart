import 'package:test_app/features/home/domain/entities/business.dart';
import 'package:test_app/features/home/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.avatarUrl,
    required super.phone,
    required super.registeredAt,
    required super.businesses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String,
      phone: json['phone'] as String,
      registeredAt: DateTime.parse(json['registered_at'] as String),
      businesses: (json['businesses'] as List<dynamic>)
          .map((b) => BusinessModel.fromJson(b as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BusinessModel extends Business {
  const BusinessModel({
    required super.id,
    required super.name,
    required super.type,
    required super.revenue,
    required super.employeesCount,
    required super.isActive,
    required super.createdAt,
    required super.imageUrl,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: BusinessType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => BusinessType.service,
      ),
      revenue: (json['revenue'] as num).toDouble(),
      employeesCount: json['employees_count'] as int,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      imageUrl: json['image_url'] as String,
    );
  }
}
