import 'dart:convert';

FilterNewsDto filterNewsDtoFromJson(String str) =>
    FilterNewsDto.fromJson(json.decode(str));

String filterNewsDtoToJson(FilterNewsDto data) => json.encode(data.toJson());

class FilterNewsDto {
  final String search;

  FilterNewsDto({required this.search});

  FilterNewsDto copyWith({String? search}) =>
      FilterNewsDto(search: search ?? this.search);

  factory FilterNewsDto.fromJson(Map<String, dynamic> json) =>
      FilterNewsDto(search: json["search"]);

  Map<String, dynamic> toJson() => {"search": search};
}

extension FilterNewsDtoMapper  on FilterNewsDto {
  static FilterNewsDto? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    return FilterNewsDto(
      search: map['search']?.toString() ?? '',
    );
  }
}
