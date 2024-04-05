class UseMemorialModel {
  String useMemorial;

  UseMemorialModel({
    required this.useMemorial,
  });

  // 인스턴스 생성 (json을 dart객체로 변환)
  factory UseMemorialModel.fromJson(Map<String, dynamic> json) {
    return UseMemorialModel(
      useMemorial: json['useMemorial'],
    );
  }

  // server에 보낼 json 데이터 변환 (dart 객체를 json으로 변환)
  Map<String, dynamic> toJson() => {
    'useMemorial': useMemorial,
  };
}

