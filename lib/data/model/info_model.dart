import 'package:yoyo/domain/entity/info_entity.dart';

import 'title_model.dart';

class InfoModel extends InfoEntity {
  InfoModel({
    required super.id,
    required super.title,
    super.malId,
    required super.synonyms,
    required super.isLicensed,
    required super.isAdult,
    required super.countryOfOrigin,
    super.trailer,
    required super.image,
    required super.popularity,
    super.color,
    required super.cover,
    super.description,
    required super.status,
    required super.releaseDate,
    required super.startDate,
    required super.endDate,
    super.nextAiringEpisode,
    required super.totalEpisodes,
    required super.currentEpisode,
    super.rating,
    super.duration,
    required super.genres,
    super.season,
    required super.studios,
    required super.subOrDub,
    required super.type,
    required super.recommendations,
    required super.characters,
    required super.relations,
    super.mappings,
    required super.episodes,
  });

  factory InfoModel.fromMap(Map<String, dynamic> json) => InfoModel(
        id: json["id"],
        title: TitleModel.fromMap(json["title"]),
        malId: json["malId"],
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        isLicensed: json["isLicensed"],
        isAdult: json["isAdult"],
        countryOfOrigin: json["countryOfOrigin"],
        trailer: json["trailer"] != null
            ? TrailerModel.fromMap(json["trailer"])
            : null,
        image: json["image"],
        popularity: json["popularity"],
        color: json["color"],
        cover: json["cover"],
        description: json["description"],
        status: json["status"],
        releaseDate: json["releaseDate"],
        startDate: DateModel.fromMap(json["startDate"]),
        endDate: DateModel.fromMap(json["endDate"]),
        nextAiringEpisode: json["nextAiringEpisode"] != null
            ? NextAiringEpisodeModel.fromMap(json["nextAiringEpisode"])
            : null,
        totalEpisodes: json["totalEpisodes"],
        currentEpisode: json["currentEpisode"],
        rating: json["rating"],
        duration: json["duration"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        season: json["season"],
        studios: List<String>.from(json["studios"].map((x) => x)),
        subOrDub: json["subOrDub"],
        type: typeValues.map[json['type']] ?? Type.UNKNOWN,
        recommendations: List<AtionModel>.from(
            json["recommendations"].map((x) => AtionModel.fromMap(x))),
        characters: List<CharacterModel>.from(
            json["characters"].map((x) => CharacterModel.fromMap(x))),
        relations: List<AtionModel>.from(
            json["relations"].map((x) => AtionModel.fromMap(x))),
        mappings: json["mappings"] != null
            ? MappingsModel.fromMap(json["mappings"])
            : null,
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromMap(x))),
      );
}

class CharacterModel extends CharacterEntity {
  CharacterModel(
      {required super.id,
      required super.role,
      required super.name,
      required super.image,
      required super.voiceActors});
  factory CharacterModel.fromMap(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        role: roleValues.map[json["role"]] ?? Role.UNKNOWN,
        name: NameModel.fromMap(json["name"]),
        image: json["image"],
        voiceActors: List<VoiceActorModel>.from(
            json["voiceActors"].map((x) => VoiceActorModel.fromMap(x))),
      );
}

class NameModel extends NameEntity {
  NameModel({
    super.first,
    super.last,
    required super.full,
    super.native,
    required super.userPreferred,
  });
  factory NameModel.fromMap(Map<String, dynamic> json) => NameModel(
        first: json["first"],
        last: json["last"],
        full: json["full"],
        native: json["native"],
        userPreferred: json["userPreferred"],
      );
}

enum Role { MAIN, SUPPORTING, UNKNOWN }

final roleValues = EnumValues({
  "MAIN": Role.MAIN,
  "SUPPORTING": Role.SUPPORTING,
  "UNKNOWN": Role.UNKNOWN
});

class VoiceActorModel extends VoiceActorEntity {
  VoiceActorModel({
    required super.id,
    required super.language,
    required super.name,
    required super.image,
  });
  factory VoiceActorModel.fromMap(Map<String, dynamic> json) => VoiceActorModel(
        id: json["id"],
        language: languageValues.map[json["language"]] ?? Language.UNKNOWN,
        name: NameModel.fromMap(json["name"]),
        image: json["image"],
      );
}

enum Language { JAPANESE, PORTUGUESE, ENGLISH, UNKNOWN }

final languageValues = EnumValues({
  "English": Language.ENGLISH,
  "Japanese": Language.JAPANESE,
  "Portuguese": Language.PORTUGUESE,
  "UNKNOWN": Language.UNKNOWN,
});

class DateModel extends DateEntity {
  DateModel({
    super.year,
    super.month,
    super.day,
  });
  factory DateModel.fromMap(Map<String, dynamic> json) => DateModel(
        year: json["year"],
        month: json["month"],
        day: json["day"],
      );
}

class EpisodeModel extends EpisodeEntity {
  EpisodeModel({
    required super.id,
    super.title,
    super.description,
    required super.number,
    required super.image,
    super.airDate,
  });
  factory EpisodeModel.fromMap(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        number: json["number"].toInt(),
        image: json["image"],
        airDate:
            json["airDate"] != null ? DateTime.parse(json["airDate"]) : null,
      );
}

class MappingsModel extends MappingsEntity {
  MappingsModel({
    super.mal,
    super.anidb,
    super.kitsu,
    super.anilist,
    super.thetvdb,
    super.anisearch,
    super.livechart,
    super.notifyMoe,
    super.animePlanet,
  });
  factory MappingsModel.fromMap(Map<String, dynamic> json) => MappingsModel(
        mal: json["mal"],
        anidb: json["anidb"],
        kitsu: json["kitsu"],
        anilist: json["anilist"],
        thetvdb: json["thetvdb"],
        anisearch: json["anisearch"],
        livechart: json["livechart"],
        notifyMoe: json["notify.moe"],
        animePlanet: json["anime-planet"],
      );
}

class NextAiringEpisodeModel extends NextAiringEpisodeEntity {
  NextAiringEpisodeModel({
    required super.airingTime,
    required super.timeUntilAiring,
    required super.episode,
  });
  factory NextAiringEpisodeModel.fromMap(Map<String, dynamic> json) =>
      NextAiringEpisodeModel(
        airingTime: json["airingTime"],
        timeUntilAiring: json["timeUntilAiring"],
        episode: json["episode"],
      );
}

class AtionModel extends AtionEntity {
  AtionModel({
    required super.id,
    super.malId,
    super.title,
    required super.status,
    super.episodes,
    required super.image,
    required super.cover,
    super.rating,
    required super.type,
    super.relationType,
    super.color,
  });
  factory AtionModel.fromMap(Map<String, dynamic> json) => AtionModel(
        id: json["id"],
        malId: json["malId"],
        title: TitleModel.fromMap(json["title"]),
        status: statusValues.map[json["status"]] ?? Status.COMPLETED,
        episodes: json["episodes"],
        image: json["image"],
        cover: json["cover"],
        rating: json["rating"],
        type: typeValues.map[json["type"]] ?? Type.UNKNOWN,
        relationType: json["relationType"],
        color: json["color"],
      );
}

enum Status { COMPLETED }

final statusValues = EnumValues({"Completed": Status.COMPLETED});

enum Type {
  TV,
  MOVIE,
  MANGA,
  UNKNOWN,
}

final typeValues = EnumValues({
  "MANGA": Type.MANGA,
  "MOVIE": Type.MOVIE,
  "TV": Type.TV,
  "UNKNOWN": Type.UNKNOWN,
});

class TrailerModel extends TrailerEntity {
  TrailerModel(
      {required super.id, required super.site, required super.thumbnail});
  factory TrailerModel.fromMap(Map<String, dynamic> json) => TrailerModel(
        id: json["id"],
        site: json["site"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "site": site,
        "thumbnail": thumbnail,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
