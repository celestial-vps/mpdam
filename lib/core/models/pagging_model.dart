class PaggingModel {
  final int page;
  final int size;
  final int total;
  final int totalPage;

  PaggingModel({
    required this.page,
    required this.size,
    required this.total,
    required this.totalPage,
  });

  PaggingModel copyWith({
    int? page,
    int? size,
    int? total,
    int? totalPage,
  }) =>
      PaggingModel(
        page: page ?? this.page,
        size: size ?? this.size,
        total: total ?? this.total,
        totalPage: totalPage ?? this.totalPage,
      );

  factory PaggingModel.fromJson(Map<String, dynamic> json) => PaggingModel(
        page: json["page"],
        size: json["size"],
        total: json["total"],
        totalPage: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
        "total": total,
        "totalPages": totalPage,
      };
}
