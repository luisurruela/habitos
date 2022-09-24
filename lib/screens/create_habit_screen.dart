import 'package:flutter/material.dart';
import 'package:habitos/services/firebase.dart';
import 'package:habitos/services/util.dart';
import 'package:habitos/theme/habity_icons_icons.dart';
import 'package:habitos/theme/theme.dart';
import 'package:habitos/models/habit_model.dart' as model;
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/habits_widgets.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({Key? key}) : super(key: key);

  @override
  State<CreateHabitScreen> createState() => CreateHabitScreenState();
}

class CreateHabitScreenState extends State<CreateHabitScreen> {
  Future children = Firebase().getChildren();
  List childrenList = [];

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

  Map<dynamic, bool> week = {
    '1': true,
    '2': false,
    '3': false,
    '4': false,
    '5': false
  };
  Map<dynamic, bool> month = {'1': true, '2': false, '3': false};

  int points = 1;
  String weeklyDaysSelected = '1';
  String monthlyDaysSelected = '1';
  int iconSelected = HabityIcons.breakfastDining.codePoint;
  int colorSelected = 0xFF8BE763;
  List childrenSelected = [];
  TextEditingController title = TextEditingController();
  bool validation = false;

  late FToast fToast;

  @override
  void initState() {
    children.then((value) {
      childrenList = value;
    });
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder(
          future: children,
          builder: (context, snapshot) {
            return Container(
              height: height,
              width: width,
              decoration: AppTheme.backgroundGradient,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          appBar(context),
                          primaryTitle('Add new habbit'),
                          const SizedBox(
                            height: 15,
                          ),
                          PrimaryInput(
                            label: 'Habit title',
                            controller: title,
                            callback: updateValidation,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          IconsColorsButtons(
                              callback: updateIconColorSelected,
                              icon: iconSelected,
                              color: colorSelected),
                          const SizedBox(
                            height: 40,
                          ),
                          secondaryTitle('Stars'),
                          const SizedBox(
                            height: 10,
                          ),
                          normalText(
                              'Define how many points your child will earn by completing this habit.'),
                          const SizedBox(
                            height: 20,
                          ),
                          SliderWidget(
                              callback: updatepoints, currentValue: points),
                          const SizedBox(
                            height: 40,
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
                            normalText(
                                'Repeat $monthlyDaysSelected day a month'),
                            const SizedBox(
                              height: 20,
                            ),
                            MonthsWidget(
                              data: month,
                              callback: updateMonthlyDays,
                            ),
                          ],
                          const SizedBox(
                            height: 60,
                          ),
                          secondaryTitle('Time'),
                          normalText(
                              'In which time of the day would you like to do it?'),
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
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Wrap(
                                  alignment: WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  children: childrenList
                                      .map(
                                        (element) => Stack(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    width: 60,
                                                    height: 60,
                                                    child: ElevatedButton(
                                                      child: Text(
                                                        element['name']
                                                            .toString()
                                                            .substring(0, 1)
                                                            .toUpperCase(),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      onPressed: () =>
                                                          updateChildrenSelected(
                                                              element[
                                                                  'childId']),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppTheme.darkPurple,
                                                        side: BorderSide(
                                                            width: 2,
                                                            color: childrenSelected
                                                                    .contains(
                                                                        element[
                                                                            'childId'])
                                                                ? const Color(
                                                                    0xFFFF6668)
                                                                : Colors.white),
                                                        elevation: 0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  Util.getFirstWord(
                                                      element['name']),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            if (childrenSelected.contains(
                                                element['childId'])) ...[
                                              Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        const Color(0xFFFF6668),
                                                    child: IconButton(
                                                      iconSize: 11,
                                                      icon: const Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () =>
                                                          updateChildrenSelected(
                                                              element[
                                                                  'childId']),
                                                    ),
                                                  )),
                                            ],
                                          ],
                                        ),
                                      )
                                      .toList()),
                            ),
                          ),
                          const SizedBox(
                            height: 150,
                          ),
                        ]),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Align(
                        alignment: Alignment.center,
                        child: SubmitButton(
                          validation: validation,
                          callback: submit,
                        )),
                  )
                ],
              ),
            );
          }),
    );
  }

  updateFrecuency(String index) {
    resetFrecuency();
    frecuency[index] = true;
    setState(() {});
  }

  updateGroup(String index) {
    group[index] = !group[index];
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
    final day = days;
    resetWeeklyDays();
    week.update(day, (value) => true);
    setState(() {});
  }

  updateMonthlyDays(String days) {
    monthlyDaysSelected = days;
    final day = days;
    resetMonthlyDays();
    month.update(day, (value) => true);
    setState(() {});
  }

  resetMonthlyDays() {
    month = {
      '1': false,
      '2': false,
      '3': false,
    };
    setState(() {});
  }

  resetWeeklyDays() {
    week = {'1': false, '2': false, '3': false, '4': false, '5': false};
  }

  updateIconColorSelected(dynamic value, String type) {
    if (type == 'icon') {
      iconSelected = value;
    } else {
      colorSelected = value;
    }

    Navigator.pop(context);
    setState(() {});
  }

  updateChildrenSelected(String id) {
    if (childrenSelected.contains(id)) {
      childrenSelected.remove(id);
    } else {
      childrenSelected.add(id);
    }

    updateValidation();
    setState(() {});
  }

  updatepoints(double value) {
    points = value.ceil();
    setState(() {});
  }

  updateValidation() {
    if (title.text != '' && childrenSelected.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }

    setState(() {});
  }

  notifyAndredirect() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppTheme.darkPurple,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "Habit added",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 3),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 130.0,
            left: MediaQuery.of(context).size.width * 0.5 - 55,
          );
        });

    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
  }

  submit() async {
    for (final child in childrenSelected) {
      model.Habit newHabit = model.Habit(
          title: title.text,
          icon: iconSelected,
          color: colorSelected,
          points: points,
          frecuency: frecuency,
          days: days,
          daysPerWeek: week,
          daysPerMonth: month,
          time: group,
          status: 'active',
          childId: child);

      final index = childrenSelected.indexOf(child);
      final lastElementIndex = childrenSelected.indexOf(childrenSelected.last);
      await Firebase().addHabit(newHabit);
      if (index == lastElementIndex) {
        notifyAndredirect();
      }
    }
  }
}
