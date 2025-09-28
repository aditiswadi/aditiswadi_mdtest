import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(LoadUsers());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Users',
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
        actions: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return PopupMenuButton<FilterOption>(
                initialValue: state.filter,
                onSelected: (value) =>
                    context.read<HomeBloc>().add(UpdateFilter(value)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: FilterOption.all,
                    child: Text(
                      'All',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: FilterOption.verified,
                    child: Text(
                      'Verified',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: FilterOption.unverified,
                    child: Text(
                      'Not Verified',
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search name or email...',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) =>
                  context.read<HomeBloc>().add(UpdateSearch(val)),
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.error != null) {
                  return Center(child: Text('Error: ${state.error}'));
                }

                final filtered = state.users.where((u) {
                  if (state.filter == FilterOption.verified && !u.isVerified) {
                    return false;
                  }
                  if (state.filter == FilterOption.unverified && u.isVerified) {
                    return false;
                  }
                  final s = state.searchTerm.toLowerCase();
                  return u.fullName.toLowerCase().contains(s) ||
                      u.email.toLowerCase().contains(s);
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('User not found'));
                }

                return ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (context, i) {
                    final user = filtered[i];
                    return ListTile(
                      title: Text(
                        user.fullName,
                        style: blackTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                      subtitle: Text(
                        user.email,
                        style: blackTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            user.isVerified
                                ? Icons.verified
                                : Icons.error_outline,
                            color: user.isVerified ? kGreenColor : kRedColor,
                          ),
                          const SizedBox(width: 4),
                          Text(user.isVerified ? 'Verified' : 'Not Verified'),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
