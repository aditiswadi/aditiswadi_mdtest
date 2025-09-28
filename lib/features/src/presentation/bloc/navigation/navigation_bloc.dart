import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.initial()) {
    on<NavigateToPage>(_navigateToPage);
  }

  void _navigateToPage(NavigateToPage event, Emitter<NavigationState> emit) {
    emit(state.copyWith(index: event.index));
  }
}
