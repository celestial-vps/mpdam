import 'dart:convert';

UpdateBankDto createBankDtoFromJson(String str) => UpdateBankDto.fromJson(json.decode(str));

String createBankDtoToJson(UpdateBankDto data) => json.encode(data.toJson());

class UpdateBankDto {
  final String bankCode;
  final String bankName;  

  UpdateBankDto({
    required this.bankCode,
    required this.bankName,    
  });

  UpdateBankDto copyWith({
    String? bankCode,
    String? bankName,    
  }) =>
      UpdateBankDto(
        bankCode: bankCode ?? this.bankCode,
        bankName: bankName ?? this.bankName,        
      );

  factory UpdateBankDto.fromJson(Map<String, dynamic> json) => UpdateBankDto(
        bankCode: json["bankCode"],
        bankName: json["bankName"],        
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankName": bankName,        
      };
}
