class MemorialGraveModel {
  final int graveSeq;
  final String name;
  final String birth;
  final String goneDate;
  final String graveName;
  final String graveImg;

  MemorialGraveModel({
    required this.graveSeq,
    required this.name,
    required this.birth,
    required this.goneDate,
    required this.graveName,
    required this.graveImg,
  });

  factory MemorialGraveModel.fromJson(Map<String, dynamic> json) {
    return MemorialGraveModel(
      graveSeq: json['graveSeq'] as int,
      name: json['name'] as String,
      birth: json['birth'] as String,
      goneDate: json['goneDate'] as String,
      graveName: json['graveName'] as String,
      graveImg: json['graveImg'] as String,
    );
  }
}
