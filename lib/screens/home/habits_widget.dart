import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';

class Habtis extends StatelessWidget {
  const Habtis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'MORNING',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.bed_rounded,
                        color: AppTheme.tertiary,
                        size: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Following Bedtimes Routines',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Go for it!',
                            style: TextStyle(
                                color: AppTheme.tertiary, fontSize: 18),
                          ),
                        ],
                      ),
                      Row(children: const [
                        Icon(
                          Icons.star,
                          color: AppTheme.secondary,
                          size: 30,
                        ),
                        Text(
                          '+5',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ])
                    ],
                  ),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryLight,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                )
              ],
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('AFTERNOON',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            ListView(
              shrinkWrap: true,
              children: const [
                Text('Habity 1'),
                Text('Habity 2'),
                Text('Habity 3'),
                Text('Habity 4'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
