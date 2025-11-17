// FILE INI UNTUK STATE MANAGEMENT GETX
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // AuthController selalu dibutuhkan
    // Get.put<AuthController>(AuthController(), permanent: true);
    
    // Controller lainnya bisa lazyPut
  }
}
