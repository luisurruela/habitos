import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';

import '../widgets/habits_widgets.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({Key? key}) : super(key: key);

  @override
  State<CreateHabitScreen> createState() => CreateHabitScreenState();
}

class CreateHabitScreenState extends State<CreateHabitScreen> {
  Map<String, dynamic> frecuency = {
    'daily': true,
    'weekly': false,
    'monthly': false,
  };

  Map<String, dynamic> group = {
    'morning': true,
    'afternoon': false,
    'night': false,
  };

  Map<String, dynamic> days = {
    'sunday': true,
    'monday': true,
    'tuesday': true,
    'wednesday': true,
    'thursday': true,
    'friday': true,
    'saturday': true,
  };

  Map<int, bool> week = {1: true, 2: false, 3: false, 4: false, 5: false};
  Map<int, bool> month = {1: true, 2: false, 3: false};

  String weeklyDaysSelected = '1';
  String monthlyDaysSelected = '1';
  String iconSelected = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: AppTheme.backgroundGradient,
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              appBar(context),
              primaryTitle('Add new habbit'),
              primaryInput(context, 'Habit title'),
              IconsColorsButtons(callback: updateIconSelected),
              const SizedBox(
                height: 30,
              ),
              secondaryTitle('Stars'),
              const SizedBox(
                height: 10,
              ),
              normalText(
                  'Define how many points your child will earn by completing this habit.'),
              const SizedBox(
                height: 30,
              ),
              const SliderWidget(),
              const SizedBox(
                height: 30,
              ),
              secondaryTitle('Frequency'),
              const SizedBox(
                height: 10,
              ),
              normalText('How often would you like to do it?'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryButton(
                      title: 'Daily',
                      isActive: frecuency['daily'],
                      callback: updateFrecuency,
                      value: 'daily',
                      elementsCount: frecuency.length,
                    ),
                    SecondaryButton(
                      title: 'Weekly',
                      isActive: frecuency['weekly'],
                      callback: updateFrecuency,
                      value: 'weekly',
                      elementsCount: frecuency.length,
                    ),
                    SecondaryButton(
                      title: 'Monthly',
                      isActive: frecuency['monthly'],
                      callback: updateFrecuency,
                      value: 'monthly',
                      elementsCount: frecuency.length,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (frecuency['daily']) ...[
                normalText('On these days'),
                const SizedBox(
                  height: 20,
                ),
                DaysWidget(callback: updateDailyDays, data: days),
              ],
              if (frecuency['weekly']) ...[
                normalText('Repeat $weeklyDaysSelected day a week'),
                const SizedBox(
                  height: 20,
                ),
                WeekWidget(
                  callback: updateWeeklyDays,
                  data: week,
                ),
              ],
              if (frecuency['monthly']) ...[
                normalText('Repeat $monthlyDaysSelected day a month'),
                const SizedBox(
                  height: 20,
                ),
                MonthsWidget(
                  data: month,
                  callback: updateMonthlyDays,
                ),
              ],
              const SizedBox(
                height: 50,
              ),
              secondaryTitle('Time'),
              normalText('In which time of the day would you like to do it?'),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SecondaryButton(
                      title: 'Morning',
                      isActive: group['morning'],
                      callback: updateGroup,
                      value: 'morning',
                      elementsCount: group.length,
                    ),
                    SecondaryButton(
                      title: 'Afternoon',
                      isActive: group['afternoon'],
                      callback: updateGroup,
                      value: 'afternoon',
                      elementsCount: group.length,
                    ),
                    SecondaryButton(
                      title: 'Night',
                      isActive: group['night'],
                      callback: updateGroup,
                      value: 'night',
                      elementsCount: group.length,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              secondaryTitle('Assign to'),
              normalText('To whom do we assign the habit?'),
              const SizedBox(
                height: 80,
              ),
              submitButton(context),
              const SizedBox(
                height: 50,
              )
            ])),
      ),
    );
  }

  updateFrecuency(String index) {
    resetFrecuency();
    frecuency[index] = true;
    setState(() {});
  }

  updateGroup(String index) {
    resetGroup();
    group[index] = true;
    setState(() {});
  }

  resetGroup() {
    group = {
      'morning': false,
      'afternoon': false,
      'night': false,
    };
    setState(() {});
  }

  resetFrecuency() {
    frecuency = {
      'daily': false,
      'weekly': false,
      'monthly': false,
    };
  }

  updateDailyDays(String day) {
    days[day] = !days[day];
    setState(() {});
  }

  updateWeeklyDays(String days) {
    weeklyDaysSelected = days;
    final day = int.parse(days);
    resetWeeklyDays();
    week.update(day, (value) => true);
    setState(() {});
  }

  updateMonthlyDays(String days) {
    monthlyDaysSelected = days;
    final day = int.parse(days);
    resetMonthlyDays();
    month.update(day, (value) => true);
    setState(() {});
  }

  resetMonthlyDays() {
    month = {
      1: false,
      2: false,
      3: false,
    };
    setState(() {});
  }

  resetWeeklyDays() {
    week = {1: false, 2: false, 3: false, 4: false, 5: false};
  }

  updateIconSelected(String iconName) {
    print(iconName);
    Navigator.pop(context);
    iconSelected = iconName;
    setState(() {});
  }
}
