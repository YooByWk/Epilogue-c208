class ViewerModel {
  String viewerName;
  String? viewerEmail;
  String? viewerMobile;

  ViewerModel({
    required this.viewerName,
    this.viewerEmail,
    this.viewerMobile,
  });

  // 인스턴스 생성 (json을 dart객체로 변환)
  factory ViewerModel.fromJson(Map<String, dynamic> json) {
    return ViewerModel(
      viewerName: json['viewerName'],
      viewerEmail: json['viewerEmail'],
      viewerMobile: json['viewerMobile'],
    );
  }

  // server에 보낼 json 데이터 변환 (dart 객체를 json으로 변환)
  Map<String, dynamic> toJson() => {
        'viewerName': viewerName,
        'viewerEmail': viewerEmail,
        'viewerMobile': viewerMobile,
      };
}
