part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUsers extends HomeEvent {}

// ubah filter (all/verified/unverified)
class UpdateFilter extends HomeEvent {
  final FilterOption filter;
  UpdateFilter(this.filter);
  @override
  List<Object?> get props => [filter];
}

// ubah kata pencarian
class UpdateSearch extends HomeEvent {
  final String search;
  UpdateSearch(this.search);
  @override
  List<Object?> get props => [search];
}

enum FilterOption { all, verified, unverified }
