// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPage extends NavigationEvent {
  final int index;
  const NavigateToPage({required this.index});

  @override
  List<Object> get props => [index];
}
