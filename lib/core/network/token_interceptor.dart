import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor(this.dio);

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Here you can put the token, either from preference, sqlite, etc.
    // Here is an example with Preferences
    var prefs = await SharedPreferences.getInstance();
    final someToken = prefs.getString("accessToken");

    options.headers['Authorization'] = 'Bearer $someToken';
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      var prefs = await SharedPreferences.getInstance();
      final someToken = prefs.getString("refreshToken");
      if (someToken == null) {
        return;
      }
      var tokenResponse =
          await dio.post("auth/refresh", data: {"refreshToken": someToken});
      if (tokenResponse.statusCode == 200) {
        String newToken = tokenResponse.data["accessToken"];
        String refreshToken = tokenResponse.data["refreshToken"];

        await prefs.setString("accessToken", newToken);
        await prefs.setString("refreshToken", refreshToken);
        if (newToken != null) {
          RequestOptions options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';
          final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );
          return handler.resolve(await dio.request(options.path,
              options: opts, data: err!.requestOptions.data));
        } else {}
      } else {
        throw new Exception();
      }
    }
    super.onError(err, handler);
  }
}
