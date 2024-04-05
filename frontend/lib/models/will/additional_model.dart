class AdditionalModel {
  String? sustainCare;
  String? funeralType;
  String? graveType;
  String? organDonation;

  AdditionalModel({
    this.sustainCare,
    this.funeralType,
    this.graveType,
    this.organDonation,
  });

  // 인스턴스 생성 (json을 dart객체로 변환)
  factory AdditionalModel.fromJson(Map<String, dynamic> json) {
    return AdditionalModel(
      sustainCare: json['sustainCare'],
      funeralType: json['funeralType'],
      graveType: json['graveType'],
      organDonation: json['organDonation'],
    );
  }

  // server에 보낼 json 데이터 변환 (dart 객체를 json으로 변환)
  Map<String, dynamic> toJson() => {
        'sustainCare': sustainCare,
        'funeralType': funeralType,
        'graveType': graveType,
        'organDonation': organDonation,
      };
}
