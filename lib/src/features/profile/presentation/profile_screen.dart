import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';
import 'package:quiz_ui/src/common/extensions/int_extensions.dart';
import 'package:quiz_ui/src/constants/app_sizes.dart';
import 'package:quiz_ui/src/features/authentication/repositories/auth_repository.dart';
import 'package:quiz_ui/src/routing/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController scrollController;
  double expandedHight = 0.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  double get top {
    double res = 95.0;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Theme.of(context).primaryColor,
                    ),
                    pinned: true,
                    expandedHeight: expandedHight,
                    flexibleSpace: const _AppBar(),
                  ),
                ];
              },
              body: const _Body(),
            ),
            AnimatedPositioned(
              duration: 300.milliseconds,
              top: top == 95.0 ? (top - 75) : (top - 50.0),
              width: context.width,
              child: Stack(
                children: [
                  Align(
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/avatar.png",
                        fit: BoxFit.cover,
                        width: 65 + (top - 45),
                        height: 65 + (top - 45),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: context.height / 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Card(
                child: Column(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.person),
                        title: Text(
                          user!.name!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const _ForwardIcon(),
                      ),
                      gapH32,
                      ListTile(
                        onTap: () {},
                        leading: const Icon(Icons.phone_android),
                        title: Text(
                          user.mobile,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: const _ForwardIcon(),
                      ),
                    ],
                  ).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _AppBar extends ConsumerWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.watch(authRepositoryProvider);
    return AppBar(
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
            size: 24,
          ),
          tooltip: 'Logout',
          onPressed: () {
            authRepo.logout();
            GoRouter.of(context).replaceNamed(AppRoute.auth.name);
          },
        ),
      ],
    );
  }
}

class _ForwardIcon extends StatelessWidget {
  const _ForwardIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.arrow_forward_ios,
      size: 25.0,
    );
  }
}
