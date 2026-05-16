import 'dart:async';
import 'package:flutter/material.dart';

import '../data/speaking_prompts.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  int currentPromptIndex = 0;
  int secondsLeft = 60;
  bool timerRunning = false;
  bool repComplete = false;
  Timer? timer;

  void nextPrompt() {
    timer?.cancel();

    setState(() {
      currentPromptIndex = (currentPromptIndex + 1) % speakingPrompts.length;
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

  void completeRep() {
    timer?.cancel();
    Navigator.pop(context, true);
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
                      speakingPrompts[currentPromptIndex],
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
                  "Nice work. Claim your 10 XP.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              const SizedBox(height: 32),
              if (repComplete)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton(
                    onPressed: completeRep,
                    child: const Text(
                      "Complete Rep +10 XP",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              if (!repComplete)
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