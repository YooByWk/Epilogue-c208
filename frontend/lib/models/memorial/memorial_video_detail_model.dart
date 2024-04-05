class MemorialVideoDetailModel {
  final int mediaSeq;
  final String? content;
  final String s3url;
  final int reportCount;

  MemorialVideoDetailModel({
    required this.mediaSeq,
    this.content,
    required this.s3url,
    required this.reportCount,
  });

  factory MemorialVideoDetailModel.fromJson(Map<String, dynamic> json) {
    return MemorialVideoDetailModel(
      mediaSeq: json['mediaSeq'] as int,
      content: json['content'] as String,
      s3url: json['s3url'] as String,
      reportCount: json['reportCount'] as int,
    );
  }
}
