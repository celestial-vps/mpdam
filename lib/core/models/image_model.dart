class ImageModel {
  final String oid;
  final String fileName;
  final String fileUrl;

  ImageModel({
    required this.oid,
    required this.fileName,
    required this.fileUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      oid: json['oid'] ?? '',
      fileName: json['fileName'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
    );
  }
}