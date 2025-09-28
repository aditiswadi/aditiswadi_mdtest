part of 'navigation_bloc.dart';

enum NavigationStatus { initial, loading, success, failure }

class NavigationState extends Equatable {
  final NavigationStatus status;
  final int index;

  const NavigationState({required this.status, required this.index});

  static NavigationState initial() =>
      const NavigationState(status: NavigationStatus.initial, index: 0);

  NavigationState copyWith({NavigationStatus? status, int? index}) {
    return NavigationState(
      status: status ?? this.status,
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [status, index];
}
