import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
}
