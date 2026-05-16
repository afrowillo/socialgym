# SocialGym

SocialGym is a confidence-training app built with Flutter. It helps users practise speaking, complete real-world confidence challenges, and track progress through XP and completed activities.

The idea is simple:

> Train your confidence one rep at a time.

## Current MVP Features

- Home screen with progress dashboard
- Impromptu speaking prompt generator
- 60-second speaking timer
- Complete speaking rep reward system
- Confidence challenge screen
- XP rewards for completed activities
- Local progress saving using `shared_preferences`
- Reset progress option
- Clean Flutter folder structure

## Current Reward System

| Activity | Reward |
|---|---:|
| Speaking Rep | +10 XP |
| Confidence Challenge | +20 XP |

## Project Structure

```text
lib/
├── main.dart
├── data/
│   ├── speaking_prompts.dart
│   └── confidence_challenges.dart
├── screens/
│   ├── home_screen.dart
│   ├── prompt_screen.dart
│   └── challenge_screen.dart
├── services/
│   └── progress_service.dart
└── widgets/
    └── stat_card.dart

Tech Stack
Flutter
Dart
shared_preferences
How to Run

Clone the project:

git clone https://github.com/YOUR_USERNAME/socialgym.git
cd socialgym

Install dependencies:

flutter pub get

Run in Chrome:

flutter run -d chrome --web-port 5000

Using a fixed web port helps local progress storage persist during browser testing.

MVP Goal

The current MVP focuses on the core confidence-building loop:

Open app
→ Choose a speaking rep or confidence challenge
→ Complete activity
→ Earn XP
→ Track progress
→ Repeat daily
Planned Features
Reflection screen after each activity
Confidence rating before and after each task
Streak tracking
More prompt categories
More challenge difficulty levels
Voice recording and playback
AI feedback on speaking pace, clarity, filler words, and tone
Conversation simulator
User accounts and cloud sync
iOS deployment
Development Notes

This project is currently being developed and tested on Windows using Flutter Web. iOS deployment will require access to macOS and Xcode later.

Status

MVP in progress.


Then save it and run:

```powershell
git add README.md
git commit -m "Update README for SocialGym MVP"
git push