import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_wrapper.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.failure(Exception error) = Failure<T>;
}

Future<Result<R>> safeApiCall<T, R>({
  required Future<T> Function() call,
  Future<R> Function(T data)? mapper,
}) async {
  try {
    final response = await call();
    final mapped = mapper != null ? await mapper(response) : response as R;
    return Result.success(mapped);
  } on DioException catch (e) {
    return Result.failure(_mapDioError(e));
  } catch (e) {
    return Result.failure(Exception('Unknown error: $e'));
  }
}

Exception _mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      return Exception("Connection timed out");
    case DioExceptionType.badResponse:
      return Exception("Server error: ${e.response?.statusCode}");
    default:
      return Exception("Network error: ${e.message}");
  }
}
