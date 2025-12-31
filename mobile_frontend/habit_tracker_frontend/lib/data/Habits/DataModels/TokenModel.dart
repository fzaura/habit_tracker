class TokenModel {
  final String accessToken;
  final String refreshToken;

  TokenModel({required this.accessToken, required this.refreshToken});

  // This is the "Translator" that turns the Map into an Object
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}