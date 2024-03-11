import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rooted_web/bloc/auth/auth_bloc.dart';
import 'package:rooted_web/const.dart';
import 'package:rooted_web/ui/admin/reports/reports_screen.dart';
import 'package:rooted_web/ui/admin/stats/stats_screen.dart';
import 'package:rooted_web/ui/admin/users/users_screen.dart';
import 'package:rooted_web/ui/organizations/organizations_screen.dart';
import 'package:rooted_web/utils/logout.dart';

import '../../models/user_model.dart';
import '../../themes.dart/colors.dart';
import '../admin/feedback/feedback_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isMobile = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (isMobile) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthBloc>().user;
    isMobile = MediaQuery.of(context).size.width <= mobileWidth;
    final List<Widget> screens = [
      if (user.isSuperAdmin) const ReportsScreen(),
      if (user.isSuperAdmin) const StatsScreen(),
      if (user.isSuperAdmin) const FeedbackScreen(),
      if (user.isSuperAdmin) const UsersScreen(),
    ];
    return Scaffold(
      drawer: isMobile ? buildBar() : null,
      appBar: isMobile
          ? buildAppBar()
          : AppBar(
              title: Row(
                children: [
                  // show image logo
                  SvgPicture.asset(
                    'assets/images/icon_ivory.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.background,
                      BlendMode.srcATop,
                    ),
                    height: 40,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Rooted',
                    style: TextStyle(
                      fontFamily: 'LibreBaskerville',
                      color: AppColors.background,
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.primary,
            ),
      body: Row(
        children: [
          if (!isMobile) buildBar(),
          Expanded(child: screens[_selectedIndex]),
        ],
      ),
    );
  }

  Widget buildBar() {
    final User user = context.read<AuthBloc>().user;
    return Container(
      color: Theme.of(context).colorScheme.surface,
      width: mobileWidth / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(doublePadding),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: user.imageUrl,
                height: 128,
                width: 128,
              ),
            ),
          ),
          Text('@${user.username}'),
          Text(('${user.firstName} ${user.lastName}').trim()),
          if (user.isSuperAdmin)
            navTile(index: 0, title: 'Reports', iconData: Icons.report_sharp),
          if (user.isSuperAdmin)
            navTile(index: 1, title: 'Stats', iconData: Icons.query_stats),
          if (user.isSuperAdmin)
            navTile(index: 2, title: 'Feedback', iconData: Icons.comment),
          if (user.isSuperAdmin)
            navTile(index: 3, title: 'Users', iconData: Icons.account_circle),
          const Spacer(),
          logoutTile(),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Rooted',
        style: TextStyle(fontFamily: 'LibreBaskerville'),
      ),
    );
  }

  Widget navTile({
    required int index,
    required String title,
    required IconData iconData,
  }) {
    return ListTile(
      onTap: () => _onItemTapped(index),
      leading: Icon(
        iconData,
        color: _selectedIndex == index
            ? Theme.of(context).colorScheme.secondary
            : null,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: _selectedIndex == index
                  ? Theme.of(context).colorScheme.secondary
                  : null,
              fontWeight: _selectedIndex == index ? FontWeight.bold : null,
            ),
      ),
    );
  }

  Widget logoutTile() {
    return ListTile(
      onTap: () async => logout(context),
      leading: Icon(
        Icons.logout,
        color: Theme.of(context).colorScheme.error,
      ),
      title: Text(
        'Logout',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }
}
