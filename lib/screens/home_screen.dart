import 'package:flutter/material.dart';

import '../services/progress_service.dart';
import '../widgets/stat_card.dart';
import 'challenge_screen.dart';
import 'prompt_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProgressService progressService = ProgressService();

  int xp = 0;
  int completedReps = 0;
  int completedChallenges = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {
    final int savedXp = await progressService.loadXp();
    final int savedReps = await progressService.loadCompletedReps();
    final int savedChallenges =
        await progressService.loadCompletedChallenges();

    setState(() {
      xp = savedXp;
      completedReps = savedReps;
      completedChallenges = savedChallenges;
      isLoading = false;
    });
  }

  Future<void> saveProgress() async {
    await progressService.saveProgress(
      xp: xp,
      completedReps: completedReps,
      completedChallenges: completedChallenges,
    );
  }

  Future<void> startSpeakingSession(BuildContext context) async {
    final bool? repCompleted = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PromptScreen(),
      ),
    );

    if (repCompleted == true) {
      setState(() {
        xp += 10;
        completedReps++;
      });

      await saveProgress();
    }
  }

  Future<void> startChallenge(BuildContext context) async {
    final bool? challengeCompleted = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChallengeScreen(),
      ),
    );

    if (challengeCompleted == true) {
      setState(() {
        xp += 20;
        completedChallenges++;
      });

      await saveProgress();
    }
  }

  Future<void> resetProgress() async {
    await progressService.resetProgress();

    setState(() {
      xp = 0;
      completedReps = 0;
      completedChallenges = 0;
    });
  }

  int get totalActivities {
    return completedReps + completedChallenges;
  }

  String get encouragementMessage {
    if (xp == 0) {
      return "Complete your first activity to earn XP.";
    }

    if (xp < 50) {
      return "Good start. Keep building the habit.";
    }

    if (xp < 150) {
      return "You are gaining momentum. Keep showing up.";
    }

    return "Strong progress. Your confidence reps are stacking up.";
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF7F4FF),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SocialGym",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Train your confidence one rep at a time.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Goal",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Complete one speaking rep and one confidence challenge.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        title: "Reps",
                        value: "$completedReps",
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        title: "Challenges",
                        value: "$completedChallenges",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: StatCard(
                    title: "XP",
                    value: "$xp",
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: StatCard(
                    title: "Total Activities",
                    value: "$totalActivities",
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    encouragementMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: () => startSpeakingSession(context),
                    child: const Text(
                      "Start Speaking Rep",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () => startChallenge(context),
                    child: const Text(
                      "Start Confidence Challenge",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: resetProgress,
                    child: const Text("Reset Progress"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}