import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quiz_ui/src/features/home/presentation/widgets/home_widget.dart';
import 'package:quiz_ui/src/features/leaderboard/presentation/leaderboard_screen.dart';
import 'package:quiz_ui/src/features/profile/presentation/profile_screen.dart';

final persistentControllerProvider = Provider.autoDispose<PersistentTabController>((ref) {
  return PersistentTabController(initialIndex: 0);
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      const HomeWidget(),
      const LeaderBoardScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PersistentTabView(
      context,
      controller: ref.watch(persistentControllerProvider),
      screens: _buildScreens(),
      items: _navBarsItems(),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_filled),
      title: "home",
      activeColorSecondary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.leaderboard_outlined),
      title: "platform",
      activeColorSecondary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person_rounded),
      title: "account",
      activeColorSecondary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}
