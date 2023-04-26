import 'package:yoyo/domain/entity/title_entity.dart';

class TitleModel extends TitleEntity {
  TitleModel({
    super.english,
    super.native,
    super.romaji,
    super.userPreferred,
  });
  factory TitleModel.fromMap(Map<String, dynamic> json) {
    return TitleModel(
      romaji: json["romaji"],
      english: json["english"],
      native: json["native"],
      userPreferred: json["userPreferred"],
    );
  }
  factory TitleModel.fromE(TitleEntity title) {
    return TitleModel(
      romaji: title.romaji,
      english: title.english,
      native: title.native,
      userPreferred: title.userPreferred,
    );
  }
  Map<String, dynamic> toMap() => {
        "romaji": romaji,
        "english": english,
        "native": native,
        "userPreferred": userPreferred,
      };
}
