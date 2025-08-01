extension SafeInt on Object? {
  int toIntOrZero() {
    if (this is int) return this as int;
    if (this is String) return int.tryParse(this as String) ?? 0;
    if (this is double) return (this as double).toInt();
    return 0;
  }
}
