import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScoreManager {
  static const String _highScoreKey = 'high_score';

  static var highScore=getHighScore();

  // Save the high score
  static Future<void> saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final currentHighScore = prefs.getInt(_highScoreKey) ?? 0;
    if (score > currentHighScore) {
      await prefs.setInt(_highScoreKey, score);
    }
  }

  // Retrieve the high score
  static Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0;
  }
}