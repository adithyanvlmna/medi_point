String? validateField(String msg, String? value) {
  if (value == null || value.isEmpty) {
    return "$msg is required";
  }
  return null;
}