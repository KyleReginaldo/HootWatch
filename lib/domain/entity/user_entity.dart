// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  final String uid;
  final String username;
  final String email;
  String? imageLink;
  final bool? isVerified;
  UserEntity({
    required this.uid,
    required this.username,
    required this.email,
    this.imageLink,
    this.isVerified,
  });
}
