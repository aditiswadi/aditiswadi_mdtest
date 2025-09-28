part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<UserEntity> users; // semua user dari Firestore
  final String searchTerm;
  final FilterOption filter;
  final bool loading;
  final String? error;

  const HomeState({
    this.users = const [],
    this.searchTerm = '',
    this.filter = FilterOption.all,
    this.loading = false,
    this.error,
  });

  HomeState copyWith({
    List<UserEntity>? users,
    String? searchTerm,
    FilterOption? filter,
    bool? loading,
    String? error,
  }) {
    return HomeState(
      users: users ?? this.users,
      searchTerm: searchTerm ?? this.searchTerm,
      filter: filter ?? this.filter,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [users, searchTerm, filter, loading, error];
}
