import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_role_response.g.dart';

@JsonSerializable()
class UserRoleResponse {
  UserRoleResponse({
    required this.userRole,
    required this.id,
  });
  factory UserRoleResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRoleResponseFromJson(json);
  @JsonKey(name: 'role')
  final String? userRole;
  @JsonKey(name: 'id')
  final int id;
}
