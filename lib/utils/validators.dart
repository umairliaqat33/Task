class Validators {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email required";
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(value)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password required";
    } else if (value.length < 8) {
      return "Minimum 8 character required in password";
    } else {
      return null;
    }
  }
}
