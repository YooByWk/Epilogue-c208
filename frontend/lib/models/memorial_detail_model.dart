class MemorialDetailModel {
  final int graveSeq;
  final String name;
  final String birth;
  final String goneDate;
  final String? graveImg;


  MemorialDetailModel({
    required this.graveSeq,
    required this.name,
    required this.birth,
    required this.goneDate,
    this.graveImg,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'birth': birth,
        'goneDate': goneDate,
        'graveImg': graveImg,
      };

  factory MemorialDetailModel.fromJson(Map<String, dynamic> json) {
    return MemorialDetailModel(
      graveSeq: json['graveSeq'] as int,
      name: json['name'] as String,
      birth: json['birth'] as String,
      goneDate: json['goneDate'] as String,
      graveImg: json['graveImg'] as String,
    );
  }
  


 // fromJson도 구현하자.

// // 아직 사용되지 않습니다. -  MemorialDetail이라는 객체를 생성합니다.
// factory MemorialDetailModel.fromJson(Map<String, dynamic> json) { }
}
