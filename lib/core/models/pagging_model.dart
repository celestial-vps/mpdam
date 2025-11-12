class PaggingModel {
  final int page;
  final int size;
  final int totalItem;
  final int totalPage;

  PaggingModel({
    required this.page,
    required this.size,
    required this.totalItem,
    required this.totalPage,
  });

  PaggingModel copyWith({
    int? page,
    int? size,
    int? totalItem,
    int? totalPage,
  }) =>
      PaggingModel(
        page: page ?? this.page,
        size: size ?? this.size,
        totalItem: totalItem ?? this.totalItem,
        totalPage: totalPage ?? this.totalPage,
      );

  factory PaggingModel.fromJson(Map<String, dynamic> json) => PaggingModel(
        page: json["page"],
        size: json["size"],
        totalItem: json["totalItem"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
        "totalItem": totalItem,
        "totalPage": totalPage,
      };
}
