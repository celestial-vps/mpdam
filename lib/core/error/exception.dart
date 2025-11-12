import 'package:mpdam/core/models/error_message_model.dart';

abstract class AppException implements Exception {
  final dynamic message;
  final ErrorMessageModel? errorMessageModel;

  const AppException({
    this.message,
    this.errorMessageModel,
  });
}

class ServerException extends AppException {
  const ServerException({super.message, super.errorMessageModel});
}

class FetchDataException extends AppException {
  FetchDataException({super.message, super.errorMessageModel});
}

class BadRequestException extends AppException {
  BadRequestException({super.message, super.errorMessageModel});
}

class NotAcceptableException extends AppException {
  NotAcceptableException({super.message, super.errorMessageModel});
}

class UnauthorisedException extends AppException {
  UnauthorisedException({super.message, super.errorMessageModel});
}

class NotFoundException extends AppException {
  NotFoundException({super.message, super.errorMessageModel});
}

class MissingParamsException extends AppException {
  MissingParamsException() : super(message: "There is some missing params");
}

class NetworkException extends AppException {
  const NetworkException({super.message, super.errorMessageModel});
}

class InvalidCredentialException extends AppException {
  const InvalidCredentialException({super.message, super.errorMessageModel});
}

class DatabaseException extends AppException {}


// class GeneralException implements Exception {
//   final String message;

//   const GeneralException({required this.message});
// }

// class ServerException implements Exception {
//   final String message;

//   const ServerException({required this.message});
// }

// class StatusCodeException implements Exception {
//   final String message;

//   const StatusCodeException({required this.message});
// }

// class EmptyException implements Exception {
//   final String message;

//   const EmptyException({required this.message});
// }