import 'package:equatable/equatable.dart';
import 'package:test_app/features/home/domain/entities/business.dart';

class User extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String avatarUrl;
  final String phone;
  final DateTime registeredAt;
  final List<Business> businesses;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.avatarUrl,
    required this.phone,
    required this.registeredAt,
    required this.businesses,
  });

  int get activeBusinessCount =>
      businesses.where((b) => b.isActive).length;

  double get totalRevenue =>
      businesses.fold(0, (sum, b) => sum + b.revenue);

  int get totalEmployees =>
      businesses.fold(0, (sum, b) => sum + b.employeesCount);

  @override
  List<Object?> get props =>
      [id, fullName, email, avatarUrl, phone, registeredAt, businesses];
}
