class LetterUploadModel {
  String nickname;
  String content;

  LetterUploadModel({
    required this.nickname,
    required this.content,
  });

  // 인스턴스 생성 (json을 dart객체로 변환)
  factory LetterUploadModel.fromJson(Map<String, dynamic> json) {
    return LetterUploadModel(
      nickname: json['nickname'],
      content: json['content'],
    );
  }

  // server에 보낼 json 데이터 변환 (dart 객체를 json으로 변환)
  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'content': content,
  };
  }
