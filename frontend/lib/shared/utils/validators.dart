class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;
    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!regex.hasMatch(value)) return 'Invalid email';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 7) return 'Invalid phone number';
    return null;
  }

  static String? Function(String?) minLength(int min) {
    return (String? value) {
      if (value == null || value.length < min) return 'Minimum $min characters';
      return null;
    };
  }

  static String? mongoId(String? value) {
    if (value == null || value.isEmpty) return null;
    final regex = RegExp(r'^[0-9a-fA-F]{24}$');
    if (!regex.hasMatch(value)) return 'Invalid ID format';
    return null;
  }
}
