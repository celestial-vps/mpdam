class ApiConstants {
  // static const String baseUrl = 'https://d486-103-147-8-242.ngrok-free.app/';
  static const String baseTourAPiUrl = 'http://192.168.1.6:5102/';
  static const String baseUrl = 'http://192.168.1.14:5000/';
  static const String staticToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyT2lkIjoiY2ZiYTVhMGEtOTBkMi00N2QzLWIxOGItMzM2OTYwMjMwNmU4IiwidXNlcm5hbWUiOiJ3ZXNseWFpb3JpYUBnbWFpbC5jb20iLCJyb2xlIjoiQWRtaW4iLCJsZXZlbCI6ImFwcGxpY2F0aW9uIiwiZXhwIjoxNzYzMjkwMjQ0LCJpYXQiOjE3NjMwMzEwNDR9.0hx5wqOR6kwtin1N55LnXnaBj92ZeVuBjEavhgNY4BU';

  static const String login = 'api/v1/auth/login';
  static const String register = 'api/v1/auth/register';

  static const String bankRoot = 'api/v1/bank';
  static const String getBankById = 'api/v1/bank/';
  static const String createBank = 'api/v1/bank/create';
  static const String updateBank = 'api/v1/bank';
  static const String deleteBank = 'api/v1/bank/delete';

  static const String getAllProduct = 'api/v1/product';

  static const String getAllCustomer = 'api/v1/customer';
  static const String customerRoot = 'api/v1/customer';

  static const String createSales = 'api/v1/sales-order/create';
}
