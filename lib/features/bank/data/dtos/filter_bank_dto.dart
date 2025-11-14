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

extension FilterBankDtoMapper  on FilterBankDto {
  static FilterBankDto? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return FilterBankDto(
      search: map['search']?.toString() ?? '',
    );
  }
}
