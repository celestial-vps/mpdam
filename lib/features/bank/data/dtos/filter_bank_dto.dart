import 'dart:convert';

FilterBankDto filterBankDtoFromJson(String str) =>
    FilterBankDto.fromJson(json.decode(str));

String filterBankDtoToJson(FilterBankDto data) => json.encode(data.toJson());

class FilterBankDto {
  final String search;

  FilterBankDto({required this.search});

  FilterBankDto copyWith({String? search}) =>
      FilterBankDto(search: search ?? this.search);

  factory FilterBankDto.fromJson(Map<String, dynamic> json) =>
      FilterBankDto(search: json["search"]);

  Map<String, dynamic> toJson() => {"search": search};
}
