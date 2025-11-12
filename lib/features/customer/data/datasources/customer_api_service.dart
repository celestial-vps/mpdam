// import 'package:dio/dio.dart';
// import 'package:mpdam/core/network/api_constants.dart';
// import 'package:mpdam/core/network/http_manager.dart';

// class CustomerApiService {
//   final HttpManager _httpManager;

//   CustomerApiService({required HttpManager httpManager})
//     : _httpManager = httpManager;

//   Future<Response> getAll({
//     Map<String, dynamic>? query,
//     Map<String, dynamic>? body,
//   }) {
//     return _httpManager.post(
//       url: "${ApiConstants.customerRoot}/q",
//       query: query ?? {},
//       body: body ?? {"name": "", "email": ""},
//     );
//   }

//   Future<Response> getById(String id) {
//     return _httpManager.get(url: "${ApiConstants.customerRoot}/$id");
//   }
// }
