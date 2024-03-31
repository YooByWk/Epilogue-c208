class MemorialLetterListModel {
  int memorialLetterSeq;
  String? nickname;
  String? content;
  // String userId; // 사용자의 고유한 아이디, 이메일 혹은 전화번호로 사용자를 식별하는데 사용
  String writtenDate; // 작성일

  MemorialLetterListModel({
    required this.memorialLetterSeq,
    this.nickname,
    this.content,
    required this.writtenDate,
  });

  factory MemorialLetterListModel.fromJson(Map<String, dynamic> json) {
    return MemorialLetterListModel(
      memorialLetterSeq: json['memorialLetterSeq'] as int,
      nickname: json['nickname'] as String,
      content: json['content'] as String,
      writtenDate: json['writtenDate'] as String,
    );
  }

}
