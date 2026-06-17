import 'package:flutter/material.dart';

class Mission {
  const Mission({
    required this.title,
    required this.reward,
    required this.progress,
    required this.icon,
  });

  final String title;
  final String reward;
  final double progress;
  final IconData icon;
}
