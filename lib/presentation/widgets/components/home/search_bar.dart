// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enable;
  final Widget? suffix;
  final double? width;
  final double? height;
  final Color? borderColor;
  final Color? bgColor;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  const SearchBar({
    Key? key,
    this.controller,
    this.enable,
    this.suffix,
    this.width,
    this.height,
    this.borderColor,
    this.bgColor,
    this.onChange,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        enabled: enable,
        onChanged: onChange,
        onSubmitted: onSubmitted,
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          prefixIconColor: Colors.grey,
          suffixIcon: suffix,
          filled: true,
          fillColor: bgColor,
          prefixIcon: const Icon(Icons.search_outlined),
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
