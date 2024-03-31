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

  // 서버로 안보냅니다.
}