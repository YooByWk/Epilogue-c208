class MemorialPhotoListModel {
  final int memorialPhotoSeq;
  final String s3url;

  MemorialPhotoListModel({
    required this.memorialPhotoSeq,
    required this.s3url
  });

  factory MemorialPhotoListModel.fromJson(Map<String, dynamic> json) {
    return MemorialPhotoListModel(
      memorialPhotoSeq: json['memorialPhotoSeq'] as int,
      s3url: json['s3url'] as String,
    );
  }
}
