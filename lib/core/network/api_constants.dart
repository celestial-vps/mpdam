class ApiConstants {
  // static const String baseUrl = 'https://d486-103-147-8-242.ngrok-free.app/';
  static const String baseUrl = 'http://192.168.1.6:5102/';
  static const String staticToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyT2lkIjoiN2Y4MGRlNzQtOTcwZC00MGY4LTkzNTgtYmVmYjg0MWJmNWZiIiwidXNlcm5hbWUiOiJ3ZXNseWFpb3JpYUBnbWFpbC5jb20iLCJyb2xlIjoiQWRtaW4iLCJsZXZlbCI6ImFwcGxpY2F0aW9uIiwiZXhwIjoxNzYzMDA5MDk1LCJpYXQiOjE3NjI3NDk4OTV9.etdiS3N4ZMpLtG3cADQmvOP1Kn7gKJjOqDkikfFAAQw';

  static const String login = 'api/v1/auth/login';
  static const String register = 'api/v1/auth/register';

  static const String getBank = 'api/v1/bank';
  static const String getBankById = 'api/v1/bank/';
  static const String createBank = 'api/v1/bank/create';
  static const String updateBank = 'api/v1/bank';
  static const String deleteBank = 'api/v1/bank/delete';

  static const String getAllProduct = 'api/v1/product';

  static const String getAllCustomer = 'api/v1/customer';
  static const String customerRoot = 'api/v1/customer';

  static const String createSales = 'api/v1/sales-order/create';
}
