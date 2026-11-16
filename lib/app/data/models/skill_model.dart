import 'package:flutter/material.dart';

class SkillModel {
  final String name;
  final String category;
  final double proficiency;
  final IconData icon;

  SkillModel({
    required this.name,
    required this.category,
    required this.proficiency,
    this.icon = Icons.code,
  });
}

