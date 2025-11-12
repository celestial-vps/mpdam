import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import '../services/api/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  const baseUrl = 'http://192.168.1.3:3000'; // ganti sesuai env kamu
  return ApiClient(baseUrl: baseUrl);
});
