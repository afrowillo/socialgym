import 'package:flutter/material.dart';

import '../widgets/stat_card.dart';
import 'prompt_screen.dart';
import 'challenge_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int xp = 0;
  int completedReps = 0;
  int completedChallenges = 0;

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
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        "Complete one speaking exercise and one confidence challenge.",
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
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    xp == 0
                        ? "Complete your first activity to earn XP."
                        : "Nice. You have earned $xp XP so far.",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
