import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String description;
  final List<String> techStack;
  final List<String> features;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? playStoreUrl;
  final IconData icon;
  final String category;

  ProjectModel({
    required this.title,
    required this.description,
    required this.techStack,
    required this.features,
    this.githubUrl,
    this.liveDemoUrl,
    this.playStoreUrl,
    this.icon = Icons.phone_android,
    this.category = "Mobile App",
  });
}

