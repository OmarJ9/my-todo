class SignUpRequestBody {
  final String usernamename;
  final String email;
  final String password;

  SignUpRequestBody({
    required this.usernamename,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': usernamename,
      'email': email,
      'password': password,
    };
  }
}
