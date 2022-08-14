import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';

class Habtis extends StatelessWidget {
  const Habtis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        const Text(
          'MORNING',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: const [HabityComponent()],
        ),
        const SizedBox(
          height: 20,
        ),
        const Text('AFTERNOON',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            children: const [
              HabityComponent(),
              HabityComponent(),
              HabityComponent(),
              HabityComponent(),
              HabityComponent(),
              HabityComponent(),
            ],
          ),
        ),
      ],
    );
  }
}

class HabityComponent extends StatelessWidget {
  const HabityComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Go for it!',
                    style: TextStyle(color: AppTheme.tertiary, fontSize: 18),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }
}
