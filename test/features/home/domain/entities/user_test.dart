import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/features/home/domain/entities/business.dart';
import 'package:test_app/features/home/domain/entities/user.dart';

void main() {
  group('User', () {
    final tUser = User(
      id: 'usr_001',
      fullName: 'Test User',
      email: 'test@example.com',
      avatarUrl: 'https://example.com/avatar.jpg',
      phone: '+1234567890',
      registeredAt: DateTime(2023, 1, 1),
      businesses: [
        Business(
          id: 'biz_001',
          name: 'Active Biz',
          type: BusinessType.technology,
          revenue: 100000,
          employeesCount: 10,
          isActive: true,
          createdAt: DateTime(2023, 5, 1),
          imageUrl: 'https://example.com/biz1.jpg',
        ),
        Business(
          id: 'biz_002',
          name: 'Inactive Biz',
          type: BusinessType.food,
          revenue: 50000,
          employeesCount: 5,
          isActive: false,
          createdAt: DateTime(2024, 1, 1),
          imageUrl: 'https://example.com/biz2.jpg',
        ),
      ],
    );

    test('activeBusinessCount returns correct count', () {
      expect(tUser.activeBusinessCount, 1);
    });

    test('totalRevenue sums all businesses', () {
      expect(tUser.totalRevenue, 150000);
    });

    test('totalEmployees sums all businesses', () {
      expect(tUser.totalEmployees, 15);
    });

    test('supports equality', () {
      final user2 = User(
        id: 'usr_001',
        fullName: 'Test User',
        email: 'test@example.com',
        avatarUrl: 'https://example.com/avatar.jpg',
        phone: '+1234567890',
        registeredAt: DateTime(2023, 1, 1),
        businesses: tUser.businesses,
      );
      expect(tUser, user2);
    });
  });

  group('Business', () {
    test('supports equality', () {
      final biz1 = Business(
        id: 'biz_001',
        name: 'Test',
        type: BusinessType.retail,
        revenue: 1000,
        employeesCount: 5,
        isActive: true,
        createdAt: DateTime(2023, 1, 1),
        imageUrl: 'https://example.com/img.jpg',
      );
      final biz2 = Business(
        id: 'biz_001',
        name: 'Test',
        type: BusinessType.retail,
        revenue: 1000,
        employeesCount: 5,
        isActive: true,
        createdAt: DateTime(2023, 1, 1),
        imageUrl: 'https://example.com/img.jpg',
      );
      expect(biz1, biz2);
    });
  });
}
