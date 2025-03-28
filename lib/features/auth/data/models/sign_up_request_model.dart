class SignUpRequestBody {
  final String username;
  final String email;
  final String password;

  SignUpRequestBody({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
