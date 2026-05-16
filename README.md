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

