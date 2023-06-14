import 'package:flutter/widgets.dart';

class GamesModel {
  final String name;
  final String? image;
  final Function(BuildContext context)? onTap;
  GamesModel({
    required this.name,
    required this.image,
    this.onTap,
  });
}
