import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yoyo/domain/entity/info_entity.dart';

class CustomFunctions {
  static int convertHexToInt(String hex) {
    return int.parse(hex.replaceFirst("#", "0xFF"));
  }

  static String removeTags(String name) {
    name = name.replaceAll("<br>", "");
    name = name.replaceAll("<i>", "");
    name = name.replaceAll("</i>", "");
    name = name.replaceAll("\n", "");
    return name;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static EpisodeEntity getPlayingEpisode(
      String id, List<EpisodeEntity> episodes) {
    return episodes.singleWhere((element) => element.id == id);
  }

  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
