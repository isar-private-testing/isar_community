// ignore_for_file: public_member_api_docs
// Web stub for word splitting

/// Web stub for splitting words - minimal implementation
List<String> isarSplitWords(String input) {
  // Basic word splitting for web compatibility
  return input
      .toLowerCase()
      .split(RegExp(r'[^\w]+'))
      .where((word) => word.isNotEmpty && word.contains(RegExp(r'\w')))
      .toList();
}
