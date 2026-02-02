import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/domain/Habits/Entities/habitUI.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/listHabitsInterface.dart';
import 'package:habit_tracker/presentation/Habits/BLoC/habit_state.dart';
import 'package:habit_tracker/presentation/Habits/BLoC/habits_event.dart';
import 'package:habit_tracker/presentation/Habits/DataBundles/homeScreenDataBundle.dart';

class HabitBloc extends Bloc<HabitsEvent, HabitState> {
  List<Habit> _currentHabits = [];
  //Define the FEatures that should be used
  final ListHabitsFeatureInterface _listHabits;

  HabitBloc({required ListHabitsFeatureInterface listHabits})
    : _listHabits = listHabits,
      super(HabitInitial()) {
    //Initialize the Event Handler after making the method
    on<HabitsLoadStarted>(_onListHabits);
  }

  Future<void> _onListHabits(
    HabitsLoadStarted event,
    Emitter<HabitState> emit,
  ) async {
    emit(HabitLoading());
    final result = await _listHabits.getHabitsList();
    result.fold(
      (failure) {
        emit(
          HabitFailure(
            errorMessage: 'Failed to load habits message coming fro BLoC',
          ),
        );
      },
      (habitsList) {
        _currentHabits = habitsList;

        emit(
          HabitSuccess(
            bundle: HabitHomeScreenDataBundle(habitsToList: _currentHabits),
          ),
        );
      },
    );
  }
}
