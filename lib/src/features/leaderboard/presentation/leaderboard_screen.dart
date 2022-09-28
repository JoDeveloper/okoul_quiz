import 'package:flutter/material.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scores',
              style: Theme.of(context).textTheme.headline6,
            ),
            // games == null
            //     ? const Center(
            //         child: CircularProgressIndicator(),
            //       )
            //     :
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 90,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 220,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            SizedBox(height: 5),
                            Expanded(
                              child: _Info(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "assets/images/okoul.png",
          height: 40,
        ),
        const SizedBox(height: 3),
        const Text(
          "team.name",
          overflow: TextOverflow.fade,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        const Text(
          "description",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
