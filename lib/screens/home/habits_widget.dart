import 'package:flutter/material.dart';
import 'package:habitos/theme/habity_icons_icons.dart';
import 'package:habitos/theme/theme.dart';
import 'package:intl/intl.dart';

class Habits extends StatelessWidget {
  const Habits({Key? key, required this.currentDate, required this.habits})
      : super(key: key);
  final String currentDate;
  final List habits;

  @override
  Widget build(BuildContext context) {
    final _selectedDate = DateFormat.MMMd().format(DateTime.parse(currentDate));
    final _today = DateFormat.MMMd().format(DateTime.now());
    final _date = _selectedDate == _today ? 'Today' : _selectedDate;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _date,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: 'PPAgrandir'),
        ),
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
          children:
              habits.map((habit) => HabityComponent(data: habit)).toList(),
        )
      ],
    );
  }
}

class HabityComponent extends StatelessWidget {
  final dynamic data;
  const HabityComponent({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    print(data);
    return Column(
      children: [
        Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                IconData(data['icon'], fontFamily: 'HabityIcons'),
                color: AppTheme.tertiary,
                size: 30,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Go for it!',
                        style:
                            TextStyle(color: AppTheme.tertiary, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Row(children: [
                const Icon(
                  Icons.star,
                  color: AppTheme.secondary,
                  size: 20,
                ),
                Text(
                  '+${data['points'].toString()}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
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
