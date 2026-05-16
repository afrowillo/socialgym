import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static const String xpKey = 'xp';
  static const String repsKey = 'completed_reps';
  static const String challengesKey = 'completed_challenges';

  Future<int> loadXp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(xpKey) ?? 0;
  }

  Future<int> loadCompletedReps() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(repsKey) ?? 0;
  }

  Future<int> loadCompletedChallenges() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(challengesKey) ?? 0;
  }

  Future<void> saveProgress({
    required int xp,
    required int completedReps,
    required int completedChallenges,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(xpKey, xp);
    await prefs.setInt(repsKey, completedReps);
    await prefs.setInt(challengesKey, completedChallenges);
  }

  Future<void> resetProgress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(xpKey, 0);
    await prefs.setInt(repsKey, 0);
    await prefs.setInt(challengesKey, 0);
  }
}