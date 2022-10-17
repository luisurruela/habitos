import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';
import 'package:intl/intl.dart';

class Habits extends StatelessWidget {
  final String currentDate;
  final List habits;
  final List morningHabits;
  final List afternoonHabits;
  final List nightHabits;
  const Habits(
      {Key? key,
      required this.currentDate,
      required this.habits,
      required this.morningHabits,
      required this.afternoonHabits,
      required this.nightHabits})
      : super(key: key);

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
        if (morningHabits.isNotEmpty) ...[
          const Text(
            'MORNING',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 2),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: morningHabits
                .map((habit) => HabityComponent(data: habit))
                .toList(),
          )
        ],
        const SizedBox(
          height: 20,
        ),
        if (afternoonHabits.isNotEmpty) ...[
          const Text(
            'AFTERNOON',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 2),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: afternoonHabits
                .map((habit) => HabityComponent(data: habit))
                .toList(),
          )
        ],
        const SizedBox(
          height: 20,
        ),
        if (nightHabits.isNotEmpty) ...[
          const Text(
            'NIGHT',
            style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 2),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: nightHabits
                .map((habit) => HabityComponent(data: habit))
                .toList(),
          )
        ],
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

    return Column(
      children: [
        Container(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.12,
                child: Icon(
                  IconData(data['icon'], fontFamily: 'HabityIcons'),
                  color: Color(data['color']),
                  size: 30,
                ),
              ),
              SizedBox(
                width: width * 0.54,
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
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                  width: width * 0.14,
                  child: Row(children: [
                    const Icon(
                      Icons.star,
                      color: AppTheme.lightPurple,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '+${data['points'].toString()}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ])),
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
