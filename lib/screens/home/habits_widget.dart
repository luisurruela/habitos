import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';
import 'package:habitos/theme/habity_icons_icons.dart';

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
              color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: const [
            HabityComponent(
              icon: HabityIcons.clean_hands,
            )
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Text('AFTERNOON',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Column(
            children: const [
              HabityComponent(icon: HabityIcons.breakfast_dining),
              HabityComponent(
                icon: HabityIcons.face_retouching_natural,
              ),
              HabityComponent(
                icon: HabityIcons.settings,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class HabityComponent extends StatelessWidget {
  const HabityComponent({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: AppTheme.tertiary,
                size: 30,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
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
                        style:
                            TextStyle(color: AppTheme.tertiary, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Row(children: const [
                Icon(
                  Icons.star,
                  color: AppTheme.secondary,
                  size: 20,
                ),
                Text(
                  '+5',
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
