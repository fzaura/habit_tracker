import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/listHabitsInterface.dart';
import 'package:habit_tracker/presentation/Habits/BLoC/habit_state.dart';
import 'package:habit_tracker/presentation/Habits/BLoC/habits_event.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';

class HabitBloc extends Bloc<HabitsEvent, HabitState> {
  //1-Define Vars
  //The Single Source of Truth for RAM
  List<Habit> _currentHabits = [];
  //Define the Used Features
  //Private so no one can reach the usecase so the events and the
  //usecase stay in sync
  final ListHabitsFeatureInterface _listHabits;
  HabitBloc({required ListHabitsFeatureInterface listHabits})
    : _listHabits = listHabits,
      super(HabitInitial()) {
    //2-Define Event Handlers
  on<HabitsLoadStarted>(_onListHabits);
  }
  

  Future<void> _onListHabits(
    HabitsLoadStarted event,
    Emitter<HabitState> emit,
  ) async {
    //The Loading State
    emit(HabitLoading());
    //2-
    final result = await _listHabits.getHabitsList();
    result.fold(
      (failure) {
        emit(
          HabitFailure(errorMessage: 'FAILED TO LOAD HABITS FROM BLOC COMING'),
        );
      },
      (habits) {
        _currentHabits = habits;
        emit(
          HabitSuccess(
            bundle: HabitHomeScreenDataBundle(habitsToList: _currentHabits),
          ),
        );
      },
    );
  }
}
