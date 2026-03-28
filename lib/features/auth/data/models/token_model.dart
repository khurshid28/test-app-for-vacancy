import 'package:test_app/features/auth/domain/entities/auth_token.dart';

class TokenModel extends AuthToken {
  const TokenModel({required super.token, required super.expiresAt});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}
