import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_ui/src/common/extensions/context_extensions.dart';

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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: context.height * 0.05),
                    const _UsernameAndPhone(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
                      child: Card(
                        child: Column(
                          children: ListTile.divideTiles(
                            context: context,
                            tiles: [
                              ListTile(
                                onTap: () {},
                                leading: const _DoneIcon(),
                                title: const Text(
                                  "captain_docs",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: const _ForwardIcon(),
                                subtitle: const Text('docs_in_review'),
                              ),
                            ],
                          ).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
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

class _AppBar extends ConsumerWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
            size: 24,
          ),
          tooltip: 'Logout',
          onPressed: () {},
        ),
      ],
    );
  }
}

class _UsernameAndPhone extends ConsumerWidget {
  const _UsernameAndPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: context.height * 0.09),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'joseph',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              '0531386493',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
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

class _DoneIcon extends StatelessWidget {
  const _DoneIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.done, size: 33.0);
  }
}
