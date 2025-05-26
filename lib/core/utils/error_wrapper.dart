import 'package:dio/dio.dart';

sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final Exception error;

  const Failure(this.error);
}

Future<Result<R>> safeApiCall<T, R>({
  required Future<T> Function() call,
  R Function(T data)? mapper,
}) async {
  try {
    final response = await call();
    final mapped = mapper != null ? mapper(response) : response as R;
    return Success(mapped);
  } on DioException catch (e) {
    return Failure(_mapDioError(e));
  } catch (e) {
    return Failure(Exception('Unknown error: $e'));
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
