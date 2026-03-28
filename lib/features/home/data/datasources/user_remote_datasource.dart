import 'package:test_app/features/home/data/models/user_model.dart';
import 'package:test_app/features/home/domain/entities/business.dart';

class UserRemoteDatasource {
  Future<UserModel> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return UserModel(
      id: 'usr_001',
      fullName: 'Muhammad Umar',
      email: 'muhammad.umar@example.com',
      avatarUrl:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop&crop=face',
      phone: '+998 90 123 45 67',
      registeredAt: DateTime(2023, 3, 15),
      businesses: [
        BusinessModel(
          id: 'biz_001',
          name: 'TechVision Solutions',
          type: BusinessType.technology,
          revenue: 285000,
          employeesCount: 42,
          isActive: true,
          createdAt: DateTime(2023, 5, 10, 0, 0),
          imageUrl:
              'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400&h=300&fit=crop',
        ),
        BusinessModel(
          id: 'biz_002',
          name: 'Urban Bites Cafe',
          type: BusinessType.food,
          revenue: 124500,
          employeesCount: 18,
          isActive: true,
          createdAt: DateTime(2023, 8, 22, 0, 0),
          imageUrl:
              'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?w=400&h=300&fit=crop',
        ),
        BusinessModel(
          id: 'biz_003',
          name: 'StyleHub Boutique',
          type: BusinessType.retail,
          revenue: 89200,
          employeesCount: 12,
          isActive: true,
          createdAt: DateTime(2024, 1, 5, 0, 0),
          imageUrl:
              'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&h=300&fit=crop',
        ),
        BusinessModel(
          id: 'biz_004',
          name: 'ProClean Services',
          type: BusinessType.service,
          revenue: 67800,
          employeesCount: 8,
          isActive: false,
          createdAt: DateTime(2024, 4, 18, 0, 0),
          imageUrl:
              'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=400&h=300&fit=crop',
        ),
      ],
    );
  }
}
