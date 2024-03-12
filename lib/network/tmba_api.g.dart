// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmba_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _TmbaApi implements TmbaApi {
  _TmbaApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://34.126.136.182';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OtpResponse> getOtp(String phone) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'phone': phone};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OtpResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/v2/get-otp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OtpResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SignInWithPhoneResponse> signInWithPhone(
    String phone,
    String otp,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'phone': phone,
      'otp': otp,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SignInWithPhoneResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/api/v2/check-otp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SignInWithPhoneResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CitiesResponse> getCities() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CitiesResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v2/cities',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CitiesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SnackResponse> getSnacks(
    int categoryId,
    String accept,
    String bearerToken,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'category_id': categoryId};
    final _headers = <String, dynamic>{
      r'Accept': accept,
      r'Authorization': bearerToken,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<SnackResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v2/snacks',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SnackResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CinemaAndShowTimeByDateResponse> getCinemaAndShowTimeByDate(
    String date,
    String bearerToken,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CinemaAndShowTimeByDateResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v2/cinema-day-timeslots',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CinemaAndShowTimeByDateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SeatingPlanByShowTimeResponse> getSeatingPlanByShowTime(
    int cinemaDayTimeslotId,
    String bookingDate,
    String bearerToken,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'cinema_day_timeslot_id': cinemaDayTimeslotId,
      r'booking_date': bookingDate,
    };
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SeatingPlanByShowTimeResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v2/seat-plan',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SeatingPlanByShowTimeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SnackCategoryResponse> getSnackCategory(String bearerToken) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': bearerToken};
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SnackCategoryResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v2/snack-categories',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = SnackCategoryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PaymentTypeResponse> getPaymentTypes(
    String bearerToken,
    String accept,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': bearerToken,
      r'Accept': accept,
    };
    _headers.removeWhere((k, v) => v == null);
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PaymentTypeResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v2/payment-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PaymentTypeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckoutResponse> checkout(
    String bearerToken,
    String accept,
    CheckoutRequest checkoutRequest,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'Authorization': bearerToken,
      r'Accept': accept,
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(checkoutRequest.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CheckoutResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api/v2/checkout',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CheckoutResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
