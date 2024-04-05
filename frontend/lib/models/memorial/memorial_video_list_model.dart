class MemorialVideoListModel {
  final int memorialVideoSeq;
  final String s3url;

  MemorialVideoListModel({
    required this.memorialVideoSeq,
    required this.s3url
  });

  factory MemorialVideoListModel.fromJson(Map<String, dynamic> json) {
    return MemorialVideoListModel(
      memorialVideoSeq: json['memorialVideoSeq'] as int,
      s3url: json['s3url'] as String,
    );
  }
}
