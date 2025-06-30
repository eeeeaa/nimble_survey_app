bool isValidUrl(String? url) {
  if (url == null || url.isEmpty) return false;

  try {
    final uri = Uri.parse(url);
    return uri.hasAbsolutePath;
  } catch (e) {
    return false;
  }
}
