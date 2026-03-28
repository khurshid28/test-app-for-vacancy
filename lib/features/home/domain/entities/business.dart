import 'package:equatable/equatable.dart';

enum BusinessType { retail, service, technology, food }

class Business extends Equatable {
  final String id;
  final String name;
  final BusinessType type;
  final double revenue;
  final int employeesCount;
  final bool isActive;
  final DateTime createdAt;
  final String imageUrl;

  const Business({
    required this.id,
    required this.name,
    required this.type,
    required this.revenue,
    required this.employeesCount,
    required this.isActive,
    required this.createdAt,
    required this.imageUrl,
  });

  @override
  List<Object?> get props =>
      [id, name, type, revenue, employeesCount, isActive, createdAt, imageUrl];
}
