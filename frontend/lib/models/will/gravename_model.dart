class GraveNameModel {
  String? graveName;

  GraveNameModel({
    this.graveName,
  });

  // 인스턴스 생성 (json을 dart객체로 변환)
  factory GraveNameModel.fromJson(Map<String, dynamic> json) {
    return GraveNameModel(
      graveName: json['graveName'],
    );
  }

  // server에 보낼 json 데이터 변환 (dart 객체를 json으로 변환)
  Map<String, dynamic> toJson() => {
    'graveName': graveName,
  };
}

