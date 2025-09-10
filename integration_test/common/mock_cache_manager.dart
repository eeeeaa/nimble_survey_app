import 'package:file/local.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mocktail/mocktail.dart';

// reference: https://github.com/Baseflow/flutter_cached_network_image/issues/307
class MockCacheManager extends Mock implements DefaultCacheManager {
  @override
  Stream<FileResponse> getImageFile(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
    int? maxHeight,
    int? maxWidth,
  }) async* {
    final bytes = await rootBundle.load(
      'integration_test/common/assets/mock_network_image.png',
    );

    final file = LocalFileSystem().systemTempDirectory.childFile(
      'mock_network_image.png',
    );
    await file.writeAsBytes(bytes.buffer.asUint8List());

    yield FileInfo(file, FileSource.Cache, DateTime(2050), url);
  }
}
