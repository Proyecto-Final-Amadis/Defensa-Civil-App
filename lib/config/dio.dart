import 'package:dio/dio.dart';
import 'package:proyecto_final/config/constants.dart';
import 'package:proyecto_final/config/preferences.dart';

class ClientBase with DioMixin implements Dio {
  static final _clientDio = Dio();

  Dio get clientDio => _clientDio;

  ClientBase() {
    configureDio();
  }

  void configureDio() {
    _clientDio.options.baseUrl = BASE_URL;
    _clientDio.options.connectTimeout = const Duration(seconds: 20);
    _clientDio.options.receiveTimeout = const Duration(seconds: 20);
    _clientDio.options.headers["authorization"] = "Bearer ";
    _clientDio.options.headers['content-Type'] = 'application/json';
    _clientDio.options.headers['accept'] = '*/*';

    _clientDio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          String? token = await AppPreferences.getStringPreference('token');
          _clientDio.options.headers["authorization"] = "Bearer ${token ?? ''}";
          options.headers["authorization"] = "Bearer ${token ?? ''}";
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401 &&
              error.requestOptions.data is! FormData &&
              error.requestOptions.path != "/user/login") {
            String? token = await AppPreferences.getStringPreference('token');
            _clientDio.options.headers["authorization"] =
                "Bearer ${token ?? ''}";
            error.requestOptions.headers["authorization"] =
                "Bearer ${token ?? ''}";
            final formData = error.requestOptions.data != null
                ? FormData.fromMap(error.requestOptions.data)
                : null;
            var response = await _clientDio.request(
              error.requestOptions.path,
              data: formData,
              queryParameters: error.requestOptions.queryParameters,
              options: Options(
                method: error.requestOptions.method,
                headers: error.requestOptions.headers,
              ),
            );
            return handler.resolve(response);
          } else if (error.type == DioExceptionType.sendTimeout) {
            return handler.next(DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.sendTimeout,
                message:
                    "Conexión tardó más de 30 segundos. Inténtalo de nuevo más tarde."));
          } else if (error.type == DioExceptionType.receiveTimeout) {
            return handler.next(DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.receiveTimeout,
                message:
                    "Conexión tardó más de 30 segundos. Inténtalo de nuevo más tarde."));
          } else if (error.type == DioExceptionType.connectionTimeout) {
            return handler.next(DioException(
                requestOptions: RequestOptions(),
                type: DioExceptionType.connectionTimeout,
                message:
                    "Conexión tardó más de 30 segundos. Inténtalo de nuevo más tarde."));
          }
          return handler.next(error);
        },
      ),
    );
  }
}
