import 'dart:convert';

UpdateNewsDto createNewsDtoFromJson(String str) =>
    UpdateNewsDto.fromJson(json.decode(str));

String createNewsDtoToJson(UpdateNewsDto data) => json.encode(data.toJson());

class UpdateNewsDto {
  final String author;
  final String category;
  final String content;
  final String image;
  final String language;
  final String publishedAt;
  final String status;
  final String summary;
  final String tags;
  final String title;

  UpdateNewsDto({
    required this.author,
    required this.category,
    required this.content,
    required this.image,
    required this.language,
    required this.publishedAt,
    required this.status,
    required this.summary,
    required this.tags,
    required this.title,
  });

  UpdateNewsDto copyWith({
    String? author,
    String? category,
    String? content,
    String? image,
    String? language,
    String? publishedAt,
    String? status,
    String? summary,
    String? tags,
    String? title,
  }) => UpdateNewsDto(
    author: author ?? this.author,
    category: category ?? this.category,
    content: content ?? this.content,
    image: image ?? this.image,
    language: language ?? this.language,
    publishedAt: publishedAt ?? this.publishedAt,
    status: status ?? this.status,
    summary: summary ?? this.summary,
    tags: tags ?? this.tags,
    title: title ?? this.title,
  );

  factory UpdateNewsDto.fromJson(Map<String, dynamic> json) => UpdateNewsDto(
    author: json["author"],
    category: json["category"],
    content: json["content"],
    image: json["image"],
    language: json["language"],
    publishedAt: json["publishedAt"], //DateTime.parse(json["publishedAt"]),
    status: json["status"],
    summary: json["summary"],
    tags: json["tags"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {"author": author, "category": category};
}
