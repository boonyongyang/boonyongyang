/// Convenience extensions on [String].
extension StringX on String {
  /// Capitalise the first letter of the string.
  String get capitalised =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Convert 'camelCase' or 'PascalCase' to 'Title Case'.
  String get toTitleCase => replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (m) => '${m[1]} ${m[2]}',
      ).capitalised;
}
