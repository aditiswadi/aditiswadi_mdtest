import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final String imageUrl;
  final int index;

  const CustomBottomNavigationItem({
    super.key,
    required this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NavigationBloc>().add(NavigateToPage(index: index));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Image.asset(
            imageUrl,
            width: 24,
            height: 24,
            color: context.read<NavigationBloc>().state.index == index
                ? kPrimaryColor
                : kGreyColor,
          ),
          Container(
            width: 30,
            height: 2,
            decoration: BoxDecoration(
              color: context.read<NavigationBloc>().state.index == index
                  ? kPrimaryColor
                  : kGreyColor,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ],
      ),
    );
  }
}
