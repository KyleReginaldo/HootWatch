// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:yoyo/core/constants/constant.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enable;
  final Widget? suffix;
  final double? width;
  final double? height;
  final Color? borderColor;
  const SearchBar({
    Key? key,
    this.controller,
    this.enable,
    this.suffix,
    this.width,
    this.height,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        enabled: enable,
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          prefixIconColor: Colors.grey,
          suffixIcon: suffix,
          filled: true,
          fillColor: kTransparentColor,
          prefixIcon: const Icon(Icons.search_rounded),
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            gapPadding: 0,
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          errorBorder: InputBorder.none,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            gapPadding: 0,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            gapPadding: 0,
            borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
