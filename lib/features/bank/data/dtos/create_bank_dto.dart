 
import 'dart:convert';

CreateBankDto createBankDtoFromJson(String str) => CreateBankDto.fromJson(json.decode(str));

String createBankDtoToJson(CreateBankDto data) => json.encode(data.toJson());

class CreateBankDto {
  final String bankCode;
  final String bankName;
  

  CreateBankDto({
    required this.bankCode,
    required this.bankName,  
  });

  CreateBankDto copyWith({
    String? bankCode,
    String? bankName,    
  }) =>
      CreateBankDto(
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,        
      );

  factory CreateBankDto.fromJson(Map<String, dynamic> json) => CreateBankDto(
        bankCode: json["bankCode"],
        bankName: json["bankName"],        
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankName": bankName,        
      };
}
