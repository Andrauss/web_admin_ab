import 'dart:convert';

import 'package:agenda_beauty_online/app/exception/api_error_type.dart';
import 'package:agenda_beauty_online/app/exception/api_exception.dart';
import 'package:agenda_beauty_online/app/security/AuthData.dart';
import 'package:agenda_beauty_online/app/security/AuthStore.dart';
import 'package:agenda_beauty_online/app/service/auth_service.dart';
import 'package:agenda_beauty_online/app/service/service_config.dart';
import 'package:agenda_beauty_online/app/util/toast_util.dart';
import 'package:dio/dio.dart';
import 'package:agenda_beauty_online/app/util/Utils.dart';

class ServiceBase {
  final String? serverURL = Environment.baseUrl;
  Dio? _dio;

  var resourceUrl = '';

  ServiceBase(this.resourceUrl) {
    _dio = new Dio(); // with default Options
    Dio tokenDio = Dio();
    String token;

// Set default configs
    _dio!.options.baseUrl = serverURL!;
    tokenDio.options.baseUrl = serverURL!;
    _dio!.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.headers.containsKey("no-token")) {
        AuthStore authStore = await AuthStore.getInstance();

        if (authStore.currentData != null &&
            authStore.currentData.accessToken != null) {
          token = 'Bearer ${authStore.currentData.accessToken}';
          Utils().printAB('DIO: ADD AUTHORIZATION');
          final authString = {
            'Authorization': 'Bearer ${authStore.currentData.accessToken}'
          };
          Utils().printAB(authString);
          options.headers.addAll(authString);
        } else {
          // TODO: relogin
        }
      }

      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError error, handler) async {
// Do something with response error
      if (error.response?.data != null) {
        Utils().printAB("error: ${error}");
        Utils().printAB("error error: ${error.error}");
        Utils().printAB("error response data: ${error.response?.data}");
        Utils().printAB(
            "error response  statusCode: ${error.response?.statusCode}");

        final apiException = _getApiException(error);
        // if (apiException != null) return error.error;
      }

      // Assume 401 stands for token expired
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 403) {
        print('authStore entrou na rotina do erro 401');

        AuthStore authStore = await AuthStore.getInstance();
        RequestOptions? options = error.response?.requestOptions;
        dio?.lock();
        // dio?.interceptors.responseLock.lock();
        // dio?.interceptors.errorLock.lock();

        var headers = Auth().getBasicAuthHeaders();

        print('authStore currentData refreshToken: ');
        print(authStore.currentData.refreshToken);

        if (authStore.currentData.refreshToken == null) {
          return Auth().authApi().then((d) {
            Utils().printAB('then service_base  Auth().authApi()');
            Utils().printAB(d);
            //update csrfToken
            token = 'Bearer ${d.accessToken}';
            options?.headers["Authorization"] = 'Bearer ${d.accessToken}';
          }).catchError((e) {
            Utils().printAB('catchError service_base  Auth().authApi()');
            // Vai para o login caso não consiga realizar o auth na API
            showErrorToastBottom('Sua sessão expirou, faça login novamente');
            Auth().signOut();
            // locator<NavigatorService>()
            //     .navigateToPathAndRemoveAll('/login');
            return e;
          });
        } else {

          print('authStore tentando pegar um novo token');

          tokenDio
              .post(
            "/oauth/token",
            data: FormData.fromMap({
              "grant_type": "refresh_token",
              "refresh_token": authStore.currentData.refreshToken
            }),
            options: Options(headers: headers),
          )
              .then((d) {
            Utils().printAB("authStore Refresh Token res > ${d.data.toString()}");

            // print('authStore Refresh Token res setou no authSetPrefs');

            var dadoS = json.encode(d.data);

            // print('authStore toJson');
            // print(dadoS);
            // Auth().authSetTeste('dadoJSON', dadoS);
            // print('authStore toString');
            // print(dadoS.toString());
            Auth().authSetTeste('AuthData', dadoS);
             print('Novo token setado!');

            AuthData dados = AuthData.fromJson(d.data);
            authStore.currentData = dados;

            //update csrfToken
            token = 'Bearer ${authStore.currentData.accessToken}';
            options?.headers["Authorization"] =
                'Bearer ${authStore.currentData.accessToken}';

          }).catchError((onError) {
            // error_description: Invalid refresh token (expired):
            if (onError is DioError) {
              Utils().printAB(onError.response?.data);
              if (onError.response != null) {
                final responseData = onError.response?.data;
                if (responseData is Map &&
                    responseData['error_description'] != null) {
                  final responseError =
                      responseData['error_description'].toString();
                  if (authStore.currentData.refreshToken == null ||
                      (responseError.contains('refresh') &&
                          responseError.contains('token') &&
                          responseError.contains('expired'))) {
                    return Auth().authApi().then((d) {
                      Utils().printAB('then service_base  Auth().authApi()');
                      //update csrfToken
                      token = 'Bearer ${d.accessToken}';
                      options?.headers["Authorization"] =
                          'Bearer ${d.accessToken}';
                    }).catchError((e) {
                      Utils()
                          .printAB('catchError service_base  Auth().authApi()');
                      // Vai para o login caso não consiga realizar o auth na API
                      showErrorToastBottom(
                          'Sua sessão expirou, faça login novamente');
                      Auth().signOut();
                      // locator<NavigatorService>()
                      //     .navigateToPathAndRemoveAll('/login');
                      return e;
                    });
                  }
                } else {
                  if (responseData is Map &&
                      responseData['error'] != null &&
                      responseData['error'] == 'unauthorized') {
                    if (responseData['error_description'] != null &&
                        responseData['error_description']
                            .toString()
                            .contains('senha') &&
                        responseData['error_description']
                            .toString()
                            .contains('inv')) {
                      Auth().signOut();
                      showErrorToastBottom(
                          'Sua sessão expirou, faça login novamente');
                      // locator<NavigatorService>()
                      //     .navigateToPathAndRemoveAll('/login');
                    }
                  }
                }
              }
            }
            return onError;
          }).whenComplete(() {
            dio?.unlock();
            // dio?.interceptors.responseLock.unlock();
            // dio?.interceptors.errorLock.unlock();
          }).then((e) {
            //repeat
            // return dio?.request(options!.path,options: options?);
          }).catchError((onError) {
            if (onError is DioError) {
              Utils().printAB('EEEEEERRR');
              Utils().printAB('ERROR DATA: ${(onError).response?.data}');
              // Utils().printAB(onError.response.statusMessage);
              // Utils().printAB((onError).error);
              // Utils().printAB((onError).response.statusCode);
              // Utils().printAB((onError).request.uri);
              // TODO: call login
            }
          });
        }
      }

      return handler.next(error); //continue
    }));
  }

  String get baseUrl => serverURL! + '/' + resourceUrl;

  Dio? get dio => _dio;

  /// Executa uma requisição GET na url passada
  Future<Response<T>> doGET<T>(String url,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    Utils().printAB("REquisição GET: $url");
    Utils().printAB("REquisição queryParameters: $queryParameters");
    Utils().printAB("REquisição headers: $headers");

    final mHeaders = new Map<String, String>();
    mHeaders['Accept'] = 'application/json';
    mHeaders['Content-Type'] = 'application/json';
    mHeaders['Access-Control-Allow-Origin'] = 'true';

    if (headers != null) {
      mHeaders.addAll(headers);
    }

    final response = await dio!.get<T>(
      url,
      queryParameters: queryParameters,
      options: Options(headers: mHeaders),
    );

    Utils().printAB("< GET: Response: $url: ${response.data}");

    return response;
  }

  /// Executa uma requisição DELETE na url passada
  Future<Response<T>> doDELETE<T>(String url,
      {required Map<String, dynamic> queryParameters,
      required Map<String, String> headers}) async {
    Utils().printAB("> DELETE: $url");

    final mHeaders = new Map<String, String>();
    if (headers != null) {
      mHeaders.addAll(headers);
    }

    final response = await dio?.delete<T>(
      url,
      queryParameters: queryParameters,
      options: Options(headers: mHeaders),
    );

    Utils().printAB("< DELETE: Response: $url: ${response!.data}");

    return response;
  }

  /// Trata uma exception vinda da api de acordo com os códigos e formato suportado
  /// formato suportado: {code: ApiException | String, message: String, exception: String}
  Exception _getApiException(DioError error) {
    try {
      final errorData = error.response?.data;
      if (errorData is Map) {
        final code = errorData['code'];

        // if (code == null) return null;

        final errorType = apiErrorTypeFromString(code.toString());
        Utils().printAB('getExceptionTratada [code]: $errorType');
        return ApiException(errorType, errorData as dynamic);
        
      }
    } catch (exception, stackTrace) {
      Utils().printAB(
          "================ Falha ao obter tipo de erro ==================");
      Utils().printAB(exception);
      Utils().printAB(stackTrace);
    }
    return error;
  }
}
