import 'package:habit_tracker/data/DataModels/user.dart';

class GlobalData {
  static User _currentUser = User(
    id: 0,
    email: '',
    password: '',
    name: '',
    isUserSignedIn: false,
  );

  // Getter
  static User get currentUser => _currentUser;

  // Setter
  static set currentUser(User user) {
    _currentUser = user;
  }

  // Optional: Method-style setters for more control
  static void setCurrentUser(User user) {
    _currentUser = user;
  }

  // Helper methods
  bool get isUserLoggedIn => _currentUser.isUserSignedIn;
}
