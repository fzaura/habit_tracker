# AI Assistant Instructions for Habit Tracker Flutter App

## Project Overview
This is a Flutter mobile application for habit tracking that follows a clean architecture pattern with clear separation of concerns:

- `lib/view(Screens)`: UI components and screens
- `lib/view_model(Providers)`: State management using Riverpod
- `lib/data/Models`: Data models and entities
- `lib/core/utility`: Reusable widgets and utilities
- `lib/app`: App-wide configurations and themes

## Key Architecture Patterns

### State Management
- Uses Riverpod (flutter_riverpod) for state management
- State notifiers define immutable state updates (see `HabitsStateNotifier` in `view_model(Providers)/habitsStateNotifier.dart`)
- Example state update pattern:
```dart
void updateHabits(String oldHabitId, Habit newEdittedHabit) {
  state = state.map((oldhabit) => 
    oldhabit.id == newEdittedHabit.id ? newEdittedHabit : oldhabit
  ).toList();
}
```

### Widget Structure
- Stateful widgets use ConsumerStatefulWidget for Riverpod integration
- Follows composition pattern with smaller utility widgets in `core/utility`
- Uses AnimatedContainer and AnimatedDefaultTextStyle for smooth transitions
- Example from `habitsCheckCard.dart`:
```dart
AnimatedContainer(
  curve: Curves.easeInOutCubicEmphasized,
  duration: Duration(milliseconds: 500),
  // ... widget configuration
)
```

### Data Models
- Models use immutable pattern with copyWith methods
- DateTime handling for habit tracking and streaks
- Stored in `data/Models/UIModels`

## Development Workflow

### Getting Started
1. Ensure Flutter SDK 3.8.1+ is installed
2. Run `flutter pub get` to install dependencies
3. Use `flutter run` to launch the app

### Key Dependencies
- flutter_riverpod: ^3.0.0 (State management)
- google_fonts: ^6.3.0 (Typography)
- table_calendar: ^3.2.0 (Calendar views)
- percent_indicator: ^4.2.5 (Progress visualization)

### Testing
- Tests are located in `test/` directory
- Run tests using `flutter test`

## Common Tasks

### Adding a New Screen
1. Create screen widget in appropriate subfolder under `view(Screens)`
2. If needed, create corresponding state notifier in `view_model(Providers)`
3. Add navigation in `view(Screens)/HomeScreens/mainTabScreen.dart`

### Modifying Habit Data
1. Update model in `data/Models/UIModels/habitUI.dart`
2. Update corresponding state logic in `habitsStateNotifier.dart`
3. Update UI widgets that consume the model

## Best Practices
- Keep widget files focused on UI, move business logic to providers
- Use const constructors for immutable widgets
- Follow existing animation durations (500ms) for consistency
- Use provided theme colors from `app/Themes/themes.dart`

## Common Pitfalls
- Remember to wrap provider modifications in state = [...state] for immutability
- Use ConsumerStatefulWidget/ConsumerWidget when accessing providers
- Ensure proper disposal of animations and controllers in StatefulWidgets