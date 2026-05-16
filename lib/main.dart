import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const SocialGymApp());
}

class SocialGymApp extends StatelessWidget {
  const SocialGymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SocialGym',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void startSpeakingSession(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PromptScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FF),
      body: SafeArea(
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
              const Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: "Streak",
                      value: "0 days",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: "XP",
                      value: "0",
                    ),
                  ),
                ],
              ),
              const Spacer(),
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
            ],
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  final List<String> prompts = [
    "Talk for 60 seconds about your dream job.",
    "Explain why confidence matters.",
    "Describe your perfect day.",
    "Convince someone to wake up early.",
    "Talk about a time you overcame something difficult.",
    "Explain one thing you are proud of.",
    "Describe what makes a good friend.",
    "Talk about your biggest goal this year.",
    "Explain why communication skills matter.",
    "Describe a time you had to be brave.",
  ];

  int currentPromptIndex = 0;
  int secondsLeft = 60;
  bool timerRunning = false;
  bool repComplete = false;
  Timer? timer;

  void nextPrompt() {
    timer?.cancel();

    setState(() {
      currentPromptIndex = (currentPromptIndex + 1) % prompts.length;
      secondsLeft = 60;
      timerRunning = false;
      repComplete = false;
    });
  }

  void startTimer() {
    if (timerRunning) {
      return;
    }

    setState(() {
      timerRunning = true;
      repComplete = false;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        timer.cancel();

        setState(() {
          timerRunning = false;
          repComplete = true;
        });
      }
    });
  }

  void resetTimer() {
    timer?.cancel();

    setState(() {
      secondsLeft = 60;
      timerRunning = false;
      repComplete = false;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String timerText = "$secondsLeft";

    if (repComplete) {
      timerText = "Time's up!";
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4FF),
      appBar: AppBar(
        title: const Text("Speaking Rep"),
        backgroundColor: const Color(0xFFF7F4FF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Your Prompt",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      prompts[currentPromptIndex],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                timerText,
                style: TextStyle(
                  fontSize: repComplete ? 34 : 64,
                  fontWeight: FontWeight.bold,
                  color: repComplete ? Colors.deepPurple : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              if (!repComplete)
                Text(
                  timerRunning ? "Keep speaking..." : "Ready when you are.",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              if (repComplete)
                const Text(
                  "Nice work. You completed one speaking rep.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: timerRunning ? null : startTimer,
                  child: Text(
                    timerRunning ? "Timer Running" : "Start Timer",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: resetTimer,
                  child: const Text(
                    "Reset Timer",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: nextPrompt,
                  child: const Text(
                    "New Prompt",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}