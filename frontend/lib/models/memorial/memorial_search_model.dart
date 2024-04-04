class MemorialSearchModel {
  String searchWord;

  MemorialSearchModel({
    required this.searchWord,
  });

  factory MemorialSearchModel.fromJson(Map<String, dynamic> json) {
    return MemorialSearchModel(
      searchWord: json['searchWord'],
    );
  }

  Map<String, dynamic> toJson() => {
    'searchWord': searchWord,
  };
}

