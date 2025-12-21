 class Validations {
  
static  String onValidateName(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length == 4 ||
        value.trim().length > 50) {
      return 'The Name Should be between 5 to 50 characters'; //An Error In Input Has occured
    } else {
      return ''; //No Error Has Occured
    }
  }

 static String validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Trusted Measures:
    // Min 8 characters, at least 1 Uppercase, 1 Lowercase, 1 Number and 1 Special Character
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be 8+ characters with upper, lower, number & special char';
    }

    return ''; // Success
  }

static  String validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // The "Standard" Email Regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return ''; // Logic passed
  }

 static String validateConfirmPassword(String? value, String ogPassword) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    // Cross-check with the main password controller
    if (value != ogPassword) {
      return 'Passwords do not match';
    }

    return ''; // Success
  }
}