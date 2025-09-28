import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/home_page.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/settings_page.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/widgets/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent() {
      if (context.watch<NavigationBloc>().state.index == 0) {
        return HomePage();
      } else if (context.watch<NavigationBloc>().state.index == 1) {
        return SettingsPage();
      } else {
        return HomePage();
      }
    }

    Widget customButtonNavigationItem() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: kWhiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigationItem(
                imageUrl: 'assets/icon_home.png',
                index: 0,
              ),
              CustomBottomNavigationItem(
                imageUrl: 'assets/icon_settings.png',
                index: 1,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(children: [buildContent(), customButtonNavigationItem()]),
    );
  }
}
