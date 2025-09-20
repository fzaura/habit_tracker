class User {
  const User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.isUserSignedIn
  });
  final int id;
  final String name;
  final String email;
  final String password; // Usually hashed on backend
  final bool isUserSignedIn;
}
