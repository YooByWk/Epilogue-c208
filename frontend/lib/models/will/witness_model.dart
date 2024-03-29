class WitnessModel {
  String witnessName;
  String witnessEmail;
  String witnessMobile;
  String witnessCertificationNumber;

  WitnessModel({
    required this.witnessName,
    required this.witnessEmail,
    required this.witnessMobile,
    required this.witnessCertificationNumber,
  });

  // 인스턴스 생성 (json을 dart객체로 변환)
  factory WitnessModel.fromJson(Map<String, dynamic> json) {
    return WitnessModel(
      witnessName: json['witnessName'],
      witnessEmail: json['witnessEmail'],
      witnessMobile: json['witnessMobile'],
      witnessCertificationNumber: json['witnessCertificationNumber'],
    );
  }

  // server에 보낼 json 데이터 변환 (dart 객체를 json으로 변환)
  Map<String, dynamic> toJson() => {
    'witnessName': witnessName,
    'witnessEmail': witnessEmail,
    'witnessMobile': witnessMobile,
    'witnessCertificationNumber': witnessCertificationNumber,
  };
}

