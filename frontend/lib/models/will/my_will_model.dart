class MyWillModel {
  String? sustainCare;
  String? funeralType;
  String? graveType;
  String? organDonation;
  String? useMemorial;
  String? graveName;
  String? graveImageAddress;
  String? willFileAddress;

  MyWillModel({
    this.sustainCare,
    this.funeralType,
    this.graveType,
    this.organDonation,
    this.useMemorial,
    this.graveName,
    this.graveImageAddress,
    this.willFileAddress,
  });

  factory MyWillModel.fromJson(Map<String, dynamic> json) {
    return MyWillModel(
      sustainCare: json['sustainCare'],
      funeralType: json['funeralType'],
      graveType: json['graveType'],
      organDonation: json['organDonation'],
      useMemorial: json['useMemorial'],
      graveName: json['graveName'],
      graveImageAddress: json['graveImageAddress'],
      willFileAddress: json['willFileAddress'],
    );
  }

  // UserModel 인스턴스에서 JSON으로의 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'sustainCare': this.sustainCare,
      'funeralType': this.funeralType,
      'graveType': this.graveType,
      'organDonation': this.organDonation,
      'useMemorial': this.useMemorial,
      'graveName': this.graveName,
      'graveImageAddress': this.graveImageAddress,
      'willFileAddress': this.willFileAddress,
    };
  }
}
